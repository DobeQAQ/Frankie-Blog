package com.ljh.vo;

import com.ljh.entity.Comment;
import com.ljh.entity.Tag;
import com.ljh.entity.Type;
import com.ljh.entity.User;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class BlogVO {

    private Long id;
    private String title;//标题
    private String content;//内容
    private String firstPicture;//首图
    private String flag;//标记
    private Integer views;//浏览次数
    private boolean appreciation;//开启赞赏
    private boolean shareStatement;//开启转载声明
    private boolean commentabled;//开启评论
    private boolean published;//发布
    private boolean recommend;//开启推荐
    private LocalDateTime createTime;//创建时间
    private LocalDateTime updateTime;//更新时间

    private Long typeId;//分类id
    private Long userId;//拥有者id
    private String description;//描述
    private String tagIds;//标签id

    private Type type;//分类
    private User user;//拥有者
    private List<Tag> tags = new ArrayList<>();//标签
    private List<Comment> comments = new ArrayList<>();//评论

    private static final long serialVersionUID = 1L;

}
