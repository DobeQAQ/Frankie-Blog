package com.ljh.service;

import com.ljh.entity.User;

public interface UserService {

    User checkUser(String username, String password);//验证登录信息
}
