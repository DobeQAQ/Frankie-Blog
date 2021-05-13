package com.ljh.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_user")
public class User implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String nickname;//昵称
    private String username;//用户名
    private String password;//密码
    private String email;//邮箱
    private String avatar;//头像
    private Integer type;//权限
    private Date createTime;//创建时间
    private Date updateTime;//修改时间

    private static final long serialVersionUID = 1L;
}
