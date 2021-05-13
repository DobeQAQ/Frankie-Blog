package com.ljh.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("t_blog_tags")
public class BlogAndTags implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long tagId;
    private Long blogId;

    private static final long serialVersionUID = 1L;
}
