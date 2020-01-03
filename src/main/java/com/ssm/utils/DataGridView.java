package com.ssm.utils;

import com.ssm.bean.User;

import java.util.List;

/**
 * @author shanpeng
 * @ClassName DataGridView
 * @description TODO
 * @date 2020/1/3 14:32
 * @Version 1.0
 */
public class DataGridView {
    private Integer code=0;
    private String msg="";
    private Long count;
    private Object data;


    public DataGridView() {
        // TODO Auto-generated constructor stub
    }
    public DataGridView(Object data) {
        super();
        this.data = data;
    }

    public DataGridView(Long count, Object data) {
        super();
        this.count = count;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
