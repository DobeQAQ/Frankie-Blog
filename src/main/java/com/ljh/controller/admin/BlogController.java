package com.ljh.controller.admin;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Blog;
import com.ljh.entity.User;
import com.ljh.service.BlogService;
import com.ljh.service.TagService;
import com.ljh.service.TypeService;
import com.ljh.vo.BlogQuery;
import com.ljh.vo.BlogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/admin")
public class BlogController {


    private static final String BLOG_MESSAGE = "message";
    private static final String SUCCESS_ADD = "新增成功";
    private static final String FAILED_ADD = "新增失败";
    private static final String SUCCESS_EDIT = "修改成功";
    private static final String FAILED_EDIT = "修改失败";
    private static final String SUCCESS_DEL = "删除成功";
    private static final String FAILED_DEL = "删除失败";


    @Value("${project.pageSize}")
    private String pageSize;
    @Autowired
    private BlogService blogService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private TagService tagService;

    //跳转到博客列表页面
    @GetMapping("/blogs")
    public String blogs(@RequestParam(defaultValue = "1", name = "current") Integer current,
                        Model model) {
        IPage<BlogVO> page = blogService.listBlog(new Page<>(current, Long.parseLong(pageSize)));
        model.addAttribute("page", page);
        model.addAttribute("types", typeService.listType());
        return "admin/blogs";
    }

    //根据查询条件刷新表格
    @PostMapping("/blogs/search")
    public String search(@RequestParam(defaultValue = "1", name = "current") Integer current,
                         Model model, BlogQuery blogQuery) {
        IPage<BlogVO> page = blogService.listBlogSearch(new Page<>(current, Long.parseLong(pageSize)), blogQuery);
        model.addAttribute("page", page);
        return "admin/blogs :: blogList";
    }

    //查询分类和标签
    private void queryTypeAndTag(Model model) {
        model.addAttribute("types", typeService.listType());
        model.addAttribute("tags", tagService.listTag());
    }

    //跳转到博客发布页面
    @GetMapping("/blogs/input")
    public String input(Model model) {
        queryTypeAndTag(model);
        model.addAttribute("blog", new Blog());
        return "admin/blogs-input";
    }


    // 携带该标签跳转到编辑页面
    @GetMapping("/blogs/{id}/edit")
    public String edit(@PathVariable Long id, Model model) {
        queryTypeAndTag(model);
        model.addAttribute("blog", blogService.getBlog(id));
        return "admin/blogs-input";
    }

    //保存分类
    //如果没有id则为新增，id存在则为修改
    @PostMapping("/blogs")
    public String save(Blog blog, HttpSession session, RedirectAttributes attributes) {
        User user = (User) session.getAttribute("user");
        blog.setUserId(user.getId());
        int i;
        //修改
        if (blog.getId() != null) {
            i = blogService.updateBlog(blog);
            if (i > 0) {
                attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_EDIT);
            } else {
                attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_EDIT);
            }
        } else {
            i = blogService.saveBlog(blog);
            if (i > 0) {
                attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_ADD);
            } else {
                attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_ADD);
            }
        }

        return "redirect:/admin/blogs";
    }

    @GetMapping("/blogs/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes attributes) {
        int i = blogService.deleteBlog(id);
        if (i < 1) {
            attributes.addFlashAttribute(BLOG_MESSAGE, FAILED_DEL);
        } else {
            attributes.addFlashAttribute(BLOG_MESSAGE, SUCCESS_DEL);
        }
        return "redirect:/admin/blogs";
    }
}
