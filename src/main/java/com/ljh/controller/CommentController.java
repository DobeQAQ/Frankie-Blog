package com.ljh.controller;

import com.ljh.entity.Comment;
import com.ljh.entity.User;
import com.ljh.service.BlogService;
import com.ljh.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;


    @Value("${project.avatar}")
    private String avatar;

    @Value("${project.name}")
    private String name;

    @Value("${project.email}")
    private String email;

    @Value("${project.adminAvatar}")
    private String adminAvatar;

    /**
     * 得到列表
     * @param blogId 评论所属博客id
     * @param model 评论数据
     * @return 返回渲染fragment
     */
    @GetMapping("/comments/{blogId}")
    public String comments(@PathVariable Long blogId, Model model){
        model.addAttribute("comments", commentService.listCommentByBlogId(blogId));
        System.out.println(commentService.listCommentByBlogId(blogId));
        return "blog :: commentList";
    }

    @PostMapping("/comments")
    public String post(Comment comment){

        if (email.equals(comment.getEmail())&&name.equals(comment.getNickname())) {
            comment.setAdminComment(true);
            commentService.saveComment(comment, adminAvatar);
        } else {
            commentService.saveComment(comment, avatar);
        }
        System.out.println(comment);
        return "redirect:/comments/" + comment.getBlogId();
    }
}
