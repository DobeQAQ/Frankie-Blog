package com.ljh.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("t_blog")
public class Blog implements Serializable {

    @TableId(type = IdType.AUTO)
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

    private static final long serialVersionUID = 1L;
}