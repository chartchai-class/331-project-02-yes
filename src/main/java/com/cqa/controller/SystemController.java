package com.cqa.controller;

import cn.dev33.satoken.stp.StpUtil;
import com.cqa.domain.pojo.Users;
import com.cqa.service.UsersService;
import com.cqa.util.Result;
import com.cqa.domain.form.LoginForm;
import com.cqa.domain.form.RegisterForm;
import io.swagger.v3.oas.annotations.Operation;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import java.util.Objects;

import static com.cqa.util.TokenUtils.*;

@RestController
@RequestMapping("/system")
@Tag(name = "用户接口")
public class SystemController {
    private Logger logger = LoggerFactory.getLogger(SystemController.class);

    @Autowired
    private UsersService usersService;

    @PostMapping("/login")
    @Operation(summary = "登陆系统")
    public Result login(@Valid @RequestBody LoginForm loginForm) {
        if (StringUtils.isBlank(loginForm.getUserName())) {
            return Result.error("用户名不能为空");
        }
        if (StringUtils.isBlank(loginForm.getPassword())) {
            return Result.error("密码不能为空");
        }
        Users users = usersService.login(loginForm);
        if (Objects.isNull(users) || !users.getPassword().equals(loginForm.getPassword())) {
            return Result.error("用户名或密码错误!");
        }
        
        Result result = Result.ok("登录成功");
        result.put("userName", users.getUserName());
        result.put("userId", users.getId());
        result.put("userType", users.getType());

        StpUtil.login(users.getId());
        StpUtil.getSession().set("userType", users.getType());
        StpUtil.getSession().set("loginUserId", users.getId());
        /*
         * 因为新版的Chrome浏览器不支持前端Ajax的withCredentials，
         * 导致Ajax无法提交Cookie，所以我们要取出生成的Token返回给前端，
         * 让前端保存在Storage中，然后每次在Ajax的Header上提交Token
         */
        String token = StpUtil.getTokenInfo().getTokenValue();
        result.put("token", token);

        return result;
    }


    @GetMapping("/loginOut")
    @Operation(summary = "退出登录")
    public Result loginOut() {
        try {
            StpUtil.logout();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return Result.ok().put("result", true);
    }


    @PostMapping("/register")
    @Operation(summary = "注册")
    public Result register(@Valid @RequestBody RegisterForm registerForm) {
        int result = usersService.register(registerForm);
        if (result == -1) {
            return Result.error("用户名已存在");
        }
        return Result.ok("注册成功").put("result", result);
    }

    @GetMapping("/checkToken")
    @Operation(summary = "检查Token是否过期")
    public Result checkToken() {
        return Result.ok("检查成功").put("result", StpUtil.isLogin());
    }

}

