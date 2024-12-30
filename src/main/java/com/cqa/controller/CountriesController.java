package com.cqa.controller;
import com.cqa.domain.pojo.Countries;
import com.cqa.service.CountriesService;
import com.cqa.util.Result;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.Valid;

/**
* (countries)表控制层
*
* @author xxxxx
*/
@RestController
@RequestMapping("/countries")
public class CountriesController {
    /**
    * 服务对象
    */
    @Autowired
    private CountriesService countriesService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("/detail")
    public Result detail(String id) {
        return Result.ok("查询成功").put("result", countriesService.getCountriesById(id));
    }

    @GetMapping("/list")
    @Operation(summary = "查询所有国家信息")
    public Result list( Countries countries) {
        return Result.ok("查询成功").put("result", countriesService.selectList(countries));
    }

    @GetMapping("/page")
    @Operation(summary = "分页查询国家信息")
    public Result page(Countries countries) {
        return Result.ok("查询成功").put("result", countriesService.getPage(countries));
    }

    @PostMapping("/add")
    @Operation(summary = "新增国家")
    public Result add(@RequestBody Countries countries) {
        int result = countriesService.addCountries(countries);
        if (result > 0) {
            return Result.ok("新增国家成功！").put("result", result);
        } else {
            return Result.error("新增国家失败!");
        }
    }

    @PostMapping("/delete")
    @Operation(summary = "删除国家")
    public Result delete(@RequestBody Countries countries) {
        boolean result = countriesService.removeById(countries);
        if (result) {
            return Result.ok("删除国家成功！").put("result", result);
        } else {
            return Result.error("新增国家失败!");
        }
    }

    @PostMapping("/edit")
    @Operation(summary = "编辑国家")
    public Result edit(@RequestBody Countries countries) {
        int result = countriesService.editCountries(countries);
        if (result > 0) {
            return Result.ok("编辑国家成功！").put("result", result);
        } else if (result == -3) {
            return Result.error("国家ID不存在！");
        } else {
            return Result.error("编辑国家失败!");
        }
    }
}
