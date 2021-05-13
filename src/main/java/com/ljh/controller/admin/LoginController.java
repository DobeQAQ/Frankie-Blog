package com.ljh.controller.admin;

import com.ljh.entity.User;
import com.ljh.service.BlogService;
import com.ljh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class LoginController {

    private static final String BLOG_MESSAGE = "message";
    private static final String SUCCESS_ADD = "新增成功";
    private static final String FAILED_ADD = "新增失败";
    private static final String SUCCESS_EDIT = "修改成功";
    private static final String FAILED_EDIT = "修改失败";
    private static final String SUCCESS_DEL = "删除成功";
    private static final String FAILED_DEL = "删除失败";

    @Autowired
    private UserService userService;

    @Autowired
    private BlogService blogService;

    @GetMapping
    public String loginPage() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session, RedirectAttributes attributes) {
        User user = userService.checkUser(username, password);
        if (user != null) {
            user.setPassword(null);
            session.setAttribute("user", user);
            return "admin/index";
        } else {
            attributes.addFlashAttribute("message", "用户名和密码错误");
            return "redirect:/admin";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/admin";
    }

}
