package com.ljh.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.service.BlogService;
import com.ljh.service.TagService;
import com.ljh.service.TypeService;
import com.ljh.vo.BlogVO;
import com.ljh.vo.TagVO;
import com.ljh.vo.TypeVO;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class IndexController {

    @Value("${project.pageSize}")
    private String pageSize;

    @Value("${project.pageTypeSize}")
    private String pageTypeSize;

    @Value("${project.pageTagSize}")
    private String pageTagSize;

    @Autowired
    private BlogService blogService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private TagService tagService;

    @GetMapping("/")
    public String index(@RequestParam(defaultValue = "1", name = "current") Integer current,
                        Model model){
        //博客分页信息
        IPage<BlogVO> page = blogService.listPublishedBlog(new Page<>(current, Long.parseLong(pageSize)));
        page.setTotal(blogService.countBlog());
        model.addAttribute("page",page);

        //侧边栏分类信息
        List<TypeVO> typeVOList=typeService.listTypeVO();
        if(typeVOList.size()>Integer.parseInt(pageTypeSize)){
            typeVOList.subList(0,Integer.parseInt(pageTypeSize));
        }
        model.addAttribute("types",typeVOList);
        //侧边栏标签信息
        List<TagVO> tagVOList=tagService.listTagVO();
        if(tagVOList.size()>Integer.parseInt(pageTagSize)){
            tagVOList.subList(0,Integer.parseInt(pageTagSize));
        }
        model.addAttribute("tags",tagVOList);
        //侧边栏推荐博客
        model.addAttribute("recommendBlogs",blogService.listRecommendBlogTop(4));

        return "index";
    }

    //搜索
    @PostMapping("/search")
    public String search(@RequestParam(defaultValue = "1", name = "current") Integer current,
                         @RequestParam("query") String query,
                         Model model){
        //搜索结果分页信息
        IPage<BlogVO> page = blogService.listSearchBlog(new Page<>(current, Long.parseLong(pageSize)), query);
        page.setTotal(blogService.countSearchBlog(query));
        System.out.println(query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "search";
    }

    @GetMapping("/search/{query}")
    public String searchConvertPage(@RequestParam(defaultValue = "1", name = "current") Integer current,
                                    @PathVariable String query,
                         Model model){
        //搜索结果分页信息
        IPage<BlogVO> page = blogService.listSearchBlog(new Page<>(current, Long.parseLong(pageSize)), query);
        page.setTotal(blogService.countSearchBlog(query));
        System.out.println(query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "search";
    }


    @GetMapping("/blog/{id}")
    public String blog(@PathVariable("id") Long id, Model model){
        model.addAttribute("blog", blogService.getBlogVO(id));
        return "blog";
    }

    @GetMapping("/footer/newblog")
    public String newblog(Model model){
        model.addAttribute("newblogs", blogService.getNewBlogs());
        return "_fragments :: newblogList";
    }
}
