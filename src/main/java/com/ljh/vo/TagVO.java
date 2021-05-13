package com.ljh.vo;


import com.ljh.entity.Blog;
import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


/**
 * @Author manster
 * @Date 2021/5/1
 **/
@Data
@ToString
public class TagVO implements Serializable {

    private Long id;
    private String name;//标签名
    private List<Blog> blogs = new ArrayList<>();//该标签下的所有blog

    private static final long serialVersionUID = 1L;
}
