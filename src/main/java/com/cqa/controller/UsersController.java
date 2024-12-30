package com.cqa.controller;
import com.cqa.domain.pojo.Users;
import com.cqa.domain.pojo.Users;
import com.cqa.service.UsersService;
import com.cqa.service.UsersService;
import com.cqa.util.Result;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;

/**
* (users)表控制层
*
* @author xxxxx
*/
@RestController
@RequestMapping("/users")
public class UsersController {
    /**
    * 服务对象
    */
    @Autowired
    private UsersService usersService;
    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("/detail")
    public Result detail(String id) {
        return Result.ok("查询成功").put("result", usersService.getUsersById(id));
    }

    @GetMapping("/list")
    @Operation(summary = "查询所有用户信息")
    public Result list( Users users) {
        return Result.ok("查询成功").put("result", usersService.selectList(users));
    }

    @GetMapping("/page")
    @Operation(summary = "分页查询用户信息")
    public Result page(Users users) {
        return Result.ok("查询成功").put("result", usersService.getPage(users));
    }

    @PostMapping("/add")
    @Operation(summary = "新增用户")
    public Result add(@RequestBody Users users) {
        int result = usersService.addUsers(users);
        if (result > 0) {
            return Result.ok("新增用户成功！").put("result", result);
        } else {
            return Result.error("新增用户失败!");
        }
    }

    @PostMapping("/delete")
    @Operation(summary = "删除用户")
    public Result delete(@RequestBody Users users) {
        boolean result = usersService.removeById(users);
        if (result) {
            return Result.ok("删除用户成功！").put("result", result);
        } else {
            return Result.error("新增用户失败!");
        }
    }

    @PostMapping("/edit")
    @Operation(summary = "编辑用户")
    public Result edit(@RequestBody Users users) {
        int result = usersService.editUsers(users);
        if (result > 0) {
            return Result.ok("编辑用户成功！").put("result", result);
        } else if (result == -3) {
            return Result.error("用户ID不存在！");
        } else {
            return Result.error("编辑用户失败!");
        }
    }
}
