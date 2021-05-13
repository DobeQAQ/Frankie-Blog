package com.ljh.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.service.BlogService;
import com.ljh.service.TagService;
import com.ljh.vo.BlogVO;
import com.ljh.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TagShowController {

    @Value("${project.pageSize}")
    private String pageSize;

    @Autowired
    private TagService tagService;

    @Autowired
    private BlogService blogService;

    @GetMapping("/tags/{id}")
    public String tags(@PathVariable Long id,
                       @RequestParam(defaultValue = "1", name = "current") Integer current,
                       Model model) {

        List<TagVO> tags = tagService.listTagVO();
        if (id == -1) {
            id = tags.get(0).getId();
        }
        model.addAttribute("tags", tags);
        IPage<BlogVO> page = blogService.listBlogByTag(new Page<>(current, Long.parseLong(pageSize)), id);
        page.setTotal(blogService.countBlogByTag(id));
        model.addAttribute("page", page);
        model.addAttribute("activeTagId", id);
        model.addAttribute("recommendBlogs", blogService.listRecommendBlogTop(4));
        return "tags";
    }

}
