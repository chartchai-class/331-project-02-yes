package com.cqa.controller;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.cqa.domain.pojo.Comments;
import com.cqa.domain.pojo.Users;
import com.cqa.service.CommentsService;
import com.cqa.service.UsersService;
import com.cqa.util.Result;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

/**
* (comments)表控制层
*
* @author xxxxx
*/
@RestController
@RequestMapping("/comments")
public class CommentsController {
    /**
    * 服务对象
    */
    @Autowired
    private CommentsService commentsService;
    @Autowired
    private UsersService usersService;

    // 提交评论
    @PostMapping("/add")
    public Result add(@RequestBody Comments comments) {
        comments.setCreateTime(new Date());
        commentsService.save(comments);
        return Result.ok();
    }

    // 获取评论列表
    @GetMapping("/list")
    public Result list(Comments comments) {
        LambdaQueryWrapper<Comments> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comments::getCountryId, comments.getCountryId());
        wrapper.orderByDesc(Comments::getCreateTime);
        List<Comments> list = commentsService.list(wrapper);
        list.forEach(item -> {
            Users user = usersService.getById(item.getUserId());
            user.setPassword(null);
            item.setUser(user);
        });

        return Result.ok().put("result", list);
    }

}
