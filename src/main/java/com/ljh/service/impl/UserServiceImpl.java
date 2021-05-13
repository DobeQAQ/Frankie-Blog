package com.ljh.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ljh.mapper.UserMapper;
import com.ljh.entity.User;
import com.ljh.service.UserService;
import com.ljh.util.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 验证登录
     * @param username
     * @param password
     * @return
     */
    @Override
    public User checkUser(String username, String password) {
        User user = userMapper.selectOne(new QueryWrapper<User>()
                .eq("username",username)
                .eq("password",MD5Utils.code(password)));
        return user;
    }
}
