package com.ssm.service;

import com.ssm.bean.User;
import com.ssm.utils.DataGridView;
import com.ssm.vo.UserVo;

import java.util.List;


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

    /**
     * @Description 查询用户数据
     * @Author shanpeng
     * @Date  15:45
     * @Param [userVo]
     * @return java.util.List<com.ssm.vo.UserVo>
     **/
    List<User> findAllUserList(UserVo userVo);
}
