package com.ljh.vo;

import lombok.Data;

/**
 * @Author manster
 * @Date 2021/4/29
 **/
@Data
public class BlogQuery {

    private String title;
    private Long typeId;
    private boolean recommend;

}
