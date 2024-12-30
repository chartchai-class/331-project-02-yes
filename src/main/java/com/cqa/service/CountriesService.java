package com.cqa.service;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cqa.domain.pojo.Sports;
import org.springframework.stereotype.Service;

import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqa.mapper.CountriesMapper;
import com.cqa.domain.pojo.Countries;

import javax.annotation.Resource;

@Service
public class CountriesService extends ServiceImpl<CountriesMapper, Countries> {
    @Resource
    private CountriesMapper mapper;
    @Resource
    private SportsService sportsService;

    public Page<Countries> getPage(Countries countries) {
        Page<Countries> countriesPage = new Page<>(countries.getPageNum(), countries.getPageSize());
        countriesPage = mapper.selectPage(countriesPage, getWrapper(countries));
        countriesPage.getRecords().forEach(this::convert);
        return countriesPage;
    }

    private void convert(Countries countries) {
        if (countries.getId() == null) {
            return;
        }
        LambdaQueryWrapper<Sports> sportsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sportsLambdaQueryWrapper.eq(Sports::getCountryId,countries.getId());
        List<Sports> sportsList = sportsService.list(sportsLambdaQueryWrapper);
        countries.setSportsList(sportsList);
        Integer gold = 0;
        Integer silver = 0;
        Integer bronze = 0;
        if (CollectionUtil.isNotEmpty(sportsList)) {

            for (Sports sport : sportsList) {
               gold += sport.getGold();
               silver += sport.getSilver();
               bronze += sport.getBronze();
            }
        }
        countries.setGold(gold);
        countries.setSilver(silver);
        countries.setBronze(bronze);
    }

    public int addCountries(Countries countries) {
        return mapper.insert(countries);
    }

    public int editCountries(Countries countries) {
        return mapper.updateById(countries);
    }

    public List<Countries> selectList(Countries countries) {
        List<Countries> list = mapper.selectList(getWrapper(countries));
        list.forEach(this::convert);
        return list;
    }

    private LambdaQueryWrapper<Countries> getWrapper(Countries countries) {
        LambdaQueryWrapper<Countries> wrapper = new LambdaQueryWrapper<>();
        
        // Add more conditions as needed
        return wrapper;
    }

    public Countries getCountriesById(String id) {
        Countries countries = mapper.selectById(id);
        convert(countries);
        return countries;
    }
}
