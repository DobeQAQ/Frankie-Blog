package com.ljh.service;

import com.ljh.entity.Comment;
import java.util.List;

public interface CommentService {

    List<Comment> listCommentByBlogId(Long blogId); //获取博客评论列表

    int saveComment(Comment comment, String avatar);//保存一条评论
}
