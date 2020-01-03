package com.ssm.vo;

import com.ssm.bean.User;

/**
 * @author shanpeng
 * @ClassName UserVo
 * @description TODO
 * @date 2020/1/3 14:27
 * @Version 1.0
 */
public class UserVo extends User {

    /**
     * 分页参数
     */
    private Integer page;
    private Integer limit;

    private String code;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
