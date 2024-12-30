package com.cqa.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cqa.domain.form.LoginForm;
import com.cqa.domain.form.RegisterForm;
import com.cqa.domain.pojo.Users;
import com.cqa.domain.pojo.Users;
import com.cqa.mapper.UsersMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqa.mapper.UsersMapper;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

@Service
public class UsersService extends ServiceImpl<UsersMapper, Users> {
    @Resource
    private UsersMapper usersMapper;

    public Users login(LoginForm loginForm) {
        LambdaQueryWrapper<Users> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(loginForm.getUserName())) {
            wrapper.like(Users::getUserName, loginForm.getUserName());
        }
        return usersMapper.selectOne(wrapper);
    }

    public int register(RegisterForm registerForm) {
        LambdaQueryWrapper<Users> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(registerForm.getUserName())) {
            wrapper.like(Users::getUserName, registerForm.getUserName());
        }
        if (usersMapper.selectOne(wrapper) != null) {
            return -1;
        }
        Users users = new Users();
        users.setUserName(registerForm.getUserName());
        users.setPassword(registerForm.getPassword());
        users.setAvatar(registerForm.getAvatar());
        users.setType("1");
        users.setCreateTime(new java.util.Date());
        return usersMapper.insert(users);
    }

    public Page<Users> getPage(Users users) {
        Page<Users> usersPage = new Page<>(users.getPageNum(), users.getPageSize());
        usersPage = usersMapper.selectPage(usersPage, getWrapper(users));
        usersPage.getRecords().forEach(this::convert);
        return usersPage;
    }

    private void convert(Users users) {

    }

    public int addUsers(Users users) {
        return usersMapper.insert(users);
    }

    public int editUsers(Users users) {
        return usersMapper.updateById(users);
    }

    public List<Users> selectList(Users users) {
        List<Users> list = usersMapper.selectList(getWrapper(users));
        list.forEach(this::convert);
        return list;
    }

    private LambdaQueryWrapper<Users> getWrapper(Users users) {
        LambdaQueryWrapper<Users> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(users.getUserName()), Users::getUserName, users.getUserName());
        wrapper.ge(Objects.nonNull(users.getQueryStartTime()), Users::getCreateTime, users.getQueryStartTime());
        wrapper.le(Objects.nonNull(users.getQueryEndTime()), Users::getCreateTime, users.getQueryEndTime());

        // Add more conditions as needed
        return wrapper;
    }

    public Users getUsersById(String id) {
        Users users = usersMapper.selectById(id);
        convert(users);
        return users;
    }
}
