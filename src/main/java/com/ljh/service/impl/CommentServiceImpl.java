package com.ljh.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ljh.mapper.CommentMapper;
import com.ljh.entity.Comment;
import com.ljh.service.CommentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Transactional
    @Override
    public int saveComment(Comment comment, String avatar) {
        System.out.println(LocalDateTime.now());
        comment.setCreateTime(LocalDateTime.now());
        comment.setAvatar(avatar);
        return commentMapper.insert(comment);
    }

    @Override
    public List<Comment> listCommentByBlogId(Long blogId) {
        List<Comment> comments = commentMapper.selectList(new QueryWrapper<Comment>().eq("blog_id", blogId).orderByAsc("create_time"));
        return firstComment(comments);
    }

    public List<Comment> firstComment(List<Comment> comments){
        //存储父评论为根评论-1的评论
        ArrayList<Comment> list = new ArrayList<>();
        for (Comment comment : comments) {
            //其父id小于0则为第一级别的评论
            if(comment.getParentCommentId() <0){
                //我们将该评论下的所有评论都查出来
                comment.setReplyComments(findReply(comments,comment.getId()));
                //这就是我们最终数组中的Comment
                list.add(comment);
            }
        }
        return list;
    }

    /**
     * @param comments 我们所有的该博客下的评论
     * @param targetId 我们要查到的目标父id
     * @return 返回该评论下的所有评论
     */
    public List<Comment> findReply(List<Comment> comments, Long targetId){
        //第一级别评论的子评论集合
        ArrayList<Comment> reply = new ArrayList<>();
        for (Comment comment : comments) {
            //发现该评论的父id为targetId就将这个评论加入子评论集合
            if(find(comment.getParentCommentId(),targetId)){
                reply.add(comment);
            }
        }
        return reply;
    }

    public boolean find(Long id, Long target){
        //不将第一节评论本身加入自身的子评论集合
        if(id < 0){
            return false;
        }
        //如果父id等于target，那么该评论就是id为target评论的子评论
        if (id.equals(target)){
            return true;
        } else{
            //否则就再向上找
            return find(commentMapper.selectById(id).getParentCommentId(),target);
        }
    }
}
