package com.ljh.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Tag;
import com.ljh.entity.Type;
import com.ljh.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin")
public class TagController {


    private static final String BLOG_MESSAGE = "message";
    private static final String SUCCESS_ADD="新增成功";
    private static final String FAILED_ADD = "新增失败";
    private static final String SUCCESS_EDIT = "修改成功";
    private static final String FAILED_EDIT = "修改失败";
    private static final String SUCCESS_DEL = "删除成功";
    private static final String FAILED_DEL ="删除失败";

    @Value("${project.pageSize}")
    private String pageSize;
    @Autowired
    private TagService tagService;

    /**
     * 对标签信息进行分页
     * @param current 当前页
     * @param model 记录分页信息
     * @return 返回tags页面
     */
    @GetMapping("/tags")
    public String tags(@RequestParam(defaultValue = "1", name = "current") Integer current,
                       Model model){
        //获取分页信息
        IPage<Tag> page = tagService.listTag(new Page<>(current, Long.parseLong(pageSize)));
        model.addAttribute("page", page);
        return "admin/tags";
    }

    // 跳转到标签输入页
    @GetMapping("/tags/input")
    public String input(Model model){
        model.addAttribute("tag", new Tag());
        return "admin/tags-input";
    }

    // 携带该标签跳转到编辑页面
    @GetMapping("/tags/{id}/edit")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("tag", tagService.getTag(id));
        return "admin/tags-input";
    }


    // 保存标签如果没有id则为新增，id存在则为修改
    @PostMapping("/tags")
    public String save(Tag tag, BindingResult result, RedirectAttributes attributes){
        Tag t = tagService.getTagByName(tag.getName());
        if(t != null){
            result.rejectValue("name", "nameError", "该标签已存在，不可重复添加！");
            return "admin/tags-input";
        }
        if(!StringUtils.hasText(tag.getName())) {
            result.rejectValue("name", "nameError", "请输入标签名称！");
            return "admin/tags-input";
        }
        int i;
        if(tag.getId() != null){//有id则为修改
            i = tagService.updateTag(tag);
            if(i < 1){
                attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_EDIT);
            } else {
                attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_EDIT);
            }
        } else {//没有id则为新增
            i = tagService.saveTag(tag);
            if(i < 1){
                attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_ADD);
            } else {
                attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_ADD);
            }
        }

        return "redirect:/admin/tags";
    }

    //根据id删除标签
    @GetMapping("/tags/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes attributes) {
        int i = tagService.deleteTag(id);
        if(i < 1){
            attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_DEL);
        } else {
            attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_DEL);
        }
        return "redirect:/admin/tags";
    }
}
