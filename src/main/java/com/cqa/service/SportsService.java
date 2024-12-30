package com.cqa.service;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cqa.domain.pojo.Sports;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqa.mapper.SportsMapper;
import com.cqa.domain.pojo.Sports;

import javax.annotation.Resource;

@Service
public class SportsService extends ServiceImpl<SportsMapper, Sports> {
    @Resource
    private SportsMapper mapper;

    public Page<Sports> getPage(Sports sports) {
        Page<Sports> sportsPage = new Page<>(sports.getPageNum(), sports.getPageSize());
        sportsPage = mapper.selectPage(sportsPage, getWrapper(sports));
        sportsPage.getRecords().forEach(this::convert);
        return sportsPage;
    }

    private void convert(Sports sports) {

    }

    public int addSports(Sports sports) {
        return mapper.insert(sports);
    }

    public int editSports(Sports sports) {
        return mapper.updateById(sports);
    }

    public List<Sports> selectList(Sports sports) {
        List<Sports> list = mapper.selectList(getWrapper(sports));
        list.forEach(this::convert);
        return list;
    }

    private LambdaQueryWrapper<Sports> getWrapper(Sports sports) {
        LambdaQueryWrapper<Sports> wrapper = new LambdaQueryWrapper<>();
        if (Objects.nonNull(sports.getCountryId())) {
            wrapper.eq(Sports::getCountryId, sports.getCountryId());
        }
        // Add more conditions as needed
        return wrapper;
    }

    public Sports getSportsById(String id) {
        Sports sports = mapper.selectById(id);
        convert(sports);
        return sports;
    }
}
