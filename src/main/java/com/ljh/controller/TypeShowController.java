package com.ljh.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Type;

import com.ljh.service.BlogService;
import com.ljh.service.TypeService;
import com.ljh.vo.BlogVO;
import com.ljh.vo.TypeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TypeShowController {

    @Value("${project.pageSize}")
    private String pageSize;
    @Autowired
    private TypeService typeService;

    @Autowired
    private BlogService blogService;

    @GetMapping("/types/{id}")
    public String types(@PathVariable Long id,
                        @RequestParam(defaultValue = "1", name = "current") Integer current,
                        Model model){

        List<TypeVO> types = typeService.listTypeVO();
        //从导航栏跳过来的,就默认显示第一个
        if(id == -1){
            id = types.get(0).getId();
        }
        model.addAttribute("types", types);
        IPage<BlogVO> page = blogService.listBlogByType(new Page<>(current, Long.parseLong(pageSize)), id);
        page.setTotal(blogService.countBlogByType(id));
        model.addAttribute("page", page);
        model.addAttribute("activeTypeId", id);
        model.addAttribute("recommendBlogs", blogService.listRecommendBlogTop(4));
        return "types";
    }
}
