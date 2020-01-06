package com.ssm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.User;
import com.ssm.dao.UserMapper;
import com.ssm.service.UserService;
import com.ssm.utils.DataGridView;
import com.ssm.vo.UserVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author shanpeng
 * @ClassName UserServiceImpl
 * @description TODO
 * @date 2020/1/3 14:44
 * @Version 1.0
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;


    @Override
    public void addUser(User user) {
        this.userMapper.save(user);
    }

    @Override
    public void updateUser(UserVo userVo) {
        this.userMapper.updateByUserId(userVo);
    }

    @Override
    public void deleteUser(Integer userid) {
        this.userMapper.deleteByUserId(userid);
    }


    @Override
    public User findUserById(Integer id) {
        if(null == id){
            throw new RuntimeException("传入查询用户的id为空");
        }
        return userMapper.findUserById(id);
    }


    @Override
    public DataGridView findAllUser(UserVo userVo) {
        PageHelper.startPage(userVo.getPage(),userVo.getLimit());
        List<User> data = userMapper.findAll(userVo);
        PageInfo<User> info = new PageInfo<User>(data);
        return  new DataGridView(info.getTotal(), data);
    }

    @Override
    public List<User> findAllUserList(UserVo userVo) {
        return userMapper.findAll(userVo);
    }
}
