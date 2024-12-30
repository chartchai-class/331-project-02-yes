package com.cqa.controller;

import com.cqa.domain.pojo.Sports;
import com.cqa.service.SportsService;
import com.cqa.util.Result;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sports")
public class SportsController {
    /**
     * 服务对象
     */
    @Autowired
    private SportsService sportsService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("/detail")
    public Result detail(String id) {
        return Result.ok("查询成功").put("result", sportsService.getSportsById(id));
    }

    @GetMapping("/list")
    @Operation(summary = "查询所有项目信息")
    public Result list( Sports sports) {
        return Result.ok("查询成功").put("result", sportsService.selectList(sports));
    }

    @GetMapping("/page")
    @Operation(summary = "分页查询项目信息")
    public Result page(Sports sports) {
        return Result.ok("查询成功").put("result", sportsService.getPage(sports));
    }

    @PostMapping("/add")
    @Operation(summary = "新增项目")
    public Result add(@RequestBody Sports sports) {
        int result = sportsService.addSports(sports);
        if (result > 0) {
            return Result.ok("新增项目成功！").put("result", result);
        } else {
            return Result.error("新增项目失败!");
        }
    }

    @PostMapping("/delete")
    @Operation(summary = "删除项目")
    public Result delete(@RequestBody Sports sports) {
        boolean result = sportsService.removeById(sports);
        if (result) {
            return Result.ok("删除项目成功！").put("result", result);
        } else {
            return Result.error("新增项目失败!");
        }
    }

    @PostMapping("/edit")
    @Operation(summary = "编辑项目")
    public Result edit(@RequestBody Sports sports) {
        int result = sportsService.editSports(sports);
        if (result > 0) {
            return Result.ok("编辑项目成功！").put("result", result);
        } else if (result == -3) {
            return Result.error("项目ID不存在！");
        } else {
            return Result.error("编辑项目失败!");
        }
    }
}
