package com.ssm.service;

import com.ssm.bean.User;
import com.ssm.utils.DataGridView;
import com.ssm.vo.UserVo;
import org.springframework.stereotype.Service;


public interface UserService {

    /**
     * 添加用户
     * @param user
     */
    public void addUser(User user);

    /**
     * 修改用户
     * @param userVo
     */
    public void updateUser(UserVo userVo);

    /**
     * 根据id删除用户
     * @param userid
     */
    public void deleteUser(Integer userid);

    /**
     * 通过主键查对象
     * @param id
     */
    public User findUserById(Integer id);

    /**
     * 分页查询
     * @param userVo
     * @return
     */
    DataGridView findAllUser(UserVo userVo);
}
