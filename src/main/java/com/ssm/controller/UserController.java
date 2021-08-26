package com.ssm.controller;

import com.ssm.bean.User;
import com.ssm.service.UserService;
import com.ssm.utils.DataGridView;
import com.ssm.utils.ExportExcelUtils;
import com.ssm.utils.ResultObj;
import com.ssm.vo.UserVo;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

/**
 * @author shanpeng
 * @ClassName UserController
 * @description TODO
 * @date 2020/1/3 14:43
 * @Version 1.0
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Resource
    private UserService userService;


    /**
     * @Description 跳转到用户列表页面
     * @Author shanpeng
     * @Date 11:51 2020/1/3
     * @return java.lang.String
     **/
    @RequestMapping("toUserManager.do")
    public String toUserManager(){
        return "user_list";
    }

    /**
     * @Description 跳转到用户编辑页面
     * @Author shanpeng
     * @Date  14:51
     * @Param [user, addOrEdit]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping("toUserEdit.do")
    public ModelAndView toUserEdit(User user, @RequestParam(value="addOrEdit")String addOrEdit){
//        ModelAndView mv = new ModelAndView("user_edit");
//        //addOrEdit;0:查看；1：新建；2：修改；
//        if("0".equals(addOrEdit)||"2".equals(addOrEdit)){
//            User userdb = userService.findUserById(user.getId());
//            mv.addObject("user",userdb);
//        }
//        mv.addObject("addOrEdit",addOrEdit);
//        return mv;
    }


    /**
     * @Description 查询用户
     * @Author shanpeng
     * @Date  14:52
     * @Param [userVo]
     * @return com.ssm.utils.DataGridView
     **/
    @RequestMapping("findAllUser.do")
    @ResponseBody
    public DataGridView findAll(UserVo userVo) throws UnsupportedEncodingException {
        String realName = userVo.getRealName();
        if(realName != null){
            String decode = java.net.URLDecoder.decode(realName, "UTF-8");
            userVo.setRealName(decode);
        }
        return this.userService.findAllUser(userVo);
    }


    /**
     * @Description 添加用户
     * @Author shanpeng
     * @Date  14:52
     * @Param [user]
     * @return com.ssm.utils.ResultObj
     **/
    @RequestMapping("addUser.do")
    @ResponseBody
    public ResultObj addUser(User user) {
        try {
            user.setCreateTime(new Date());
            this.userService.addUser(user);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * @Description 更新
     * @Author shanpeng
     * @Date  14:53
     * @Param [userVo]
     * @return com.ssm.utils.ResultObj
     **/
    @RequestMapping("updateUser.do")
    @ResponseBody
    public ResultObj updateUser(UserVo userVo) {
        try {
            this.userService.updateUser(userVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * @Description 删除用户
     * @Author shanpeng
     * @Date  14:53
     * @Param [userVo]
     * @return com.ssm.utils.ResultObj
     **/
    @RequestMapping("delUser.do")
    @ResponseBody
    public ResultObj deleteUser(UserVo userVo) {
        try {
            this.userService.deleteUser(userVo.getId());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }


    @RequestMapping("exportUser.do")
    public ResponseEntity<Object> exportCustomer(UserVo userVo, HttpServletResponse response){
        List<User> users = userService.findAllUserList(userVo);
        String fileName="用户数据.xls";
        String sheetName="用户数据";

        ByteArrayOutputStream bos = ExportExcelUtils.exportCustomer(users,sheetName);

        try {
            //处理文件名乱码
            fileName= URLEncoder.encode(fileName,"UTF-8");
            //创建 封装响应头信息的对象
            HttpHeaders headers = new HttpHeaders();
            //封装响应内容类型(APPLICATION_OCTET_STREAM 响应的内容不限定)
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            //设置下载的文件的名称
            headers.setContentDispositionFormData("attachment",fileName);
            return new ResponseEntity<Object>(bos.toByteArray(),headers, HttpStatus.CREATED);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return null;
    }
}
