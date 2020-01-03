package com.ssm.dao;

import com.ssm.bean.User;
import com.ssm.vo.UserVo;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface UserMapper {
    void save(User user);

    void updateByUserId(UserVo userVo);

    void deleteByUserId(Integer userid);

    List<User> findAll(User user);

    User findUserById(Integer id);
}
