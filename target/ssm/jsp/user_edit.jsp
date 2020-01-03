<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setAttribute("base",request.getContextPath());
%>
<HTML>
<HEAD><TITLE>用户管理</TITLE>
    <meta charset="utf-8">
    <LINK rel=stylesheet href="${base}/layui/css/layui.css">
    <script src="${base}/layui/layui.js" charset="utf-8"></script>
    <STYLE>
        /*自定义样式*/
        body{
            background-color: #f2f2f2;
        }
        .layui-fluid {
            padding: 5px 8px;
        }
        .fly-panel {
            margin-bottom: 15px;
            border-radius: 2px;
            background-color: #fff;
            box-shadow: 0 1px 2px 0 rgba(0,0,0,.05);
        }
        .layui-btn-normal{
            background-color: #009ACD;
        }
        .layui-form-item {
            margin-bottom: 2px;
        }
        xm-select .scroll-body{
            padding-left: 10px;
            overflow: hidden;
        }
    </STYLE>

<BODY>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-form layui-form-pane">
                <div class="fly-panel" style="padding: 20px 15px 5px 15px;">
                    <form  id="queryForm" action="" method="post" >
                        <input id="id" name="id" value="${user.id}" type="hidden"/>
                        <div class="layui-row layui-col-space12 layui-form-item">
                            <div class="layui-col-sm6" >
                                <label class="layui-form-label">账号<font color="red">*</font></label>
                                <div class="layui-input-block" >
                                    <input type="text" class="layui-input" id="account"  lay-verType="tips" lay-verify="required" name="account" value="${user.account }" placeholder="请输入账号" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-col-sm6" >
                                <label class="layui-form-label">密码<font color="red">*</font></label>
                                <div class="layui-input-block" >
                                    <input type="text" class="layui-input" id="password" name="password"  lay-verType="tips" lay-verify="required"  value="${user.password }" placeholder="请输入密码" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-col-sm6" >
                                <label class="layui-form-label">昵称<font color="red">*</font></label>
                                <div class="layui-input-block" >
                                    <input type="text" class="layui-input" id="realName" name="realName"  lay-verType="tips" lay-verify="required" value="${user.realName }" placeholder="请输入昵称" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-col-sm6">
                                <label class="layui-form-label">性别<font color="red">*</font></label>
                                <div class="layui-input-block">
                                    <select id="sex"  name="sex"  lay-verType="tips" lay-verify="required">
                                        <option value="" >请选择</option>
                                        <option value="1" <c:if test="${1==user.sex}">selected</c:if>>男</option>
                                        <option value="2" <c:if test="${2==user.sex}">selected</c:if>>女</option>
                                    </select>
                                </div>
                            </div>

                            <div class="layui-col-sm6" >
                                <label class="layui-form-label">邮箱<font color="red">*</font></label>
                                <div class="layui-input-block" >
                                    <input type="text" class="layui-input" id="email"  lay-verType="tips" lay-verify="required" name="email" value="${user.email }" placeholder="请输入邮箱" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-col-sm6" >
                                <label class="layui-form-label">电话<font color="red">*</font></label>
                                <div class="layui-input-block" >
                                    <input type="text" class="layui-input" id="phoneNumber"  lay-verType="tips" lay-verify="required" name="phoneNumber" value="${user.phoneNumber }" placeholder="请输入电话" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block" style="margin-left:265px;">
                                    <button class="layui-btn layui-btn-normal" lay-submit type="button" id="submit_btn"
                                            lay-filter="submit_btn">保存</button>
                                    <button type="button" class="layui-btn" onclick="fnClose();"> 关闭</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</BODY>
<script type="text/javascript">
    /** 设置关闭按钮的click事件处理 */
    function fnClose() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
</script>
<script>
    layui.config({
        base: "${base}/layui/lay/mymodules/"
    }).extend({ //设定模块别名
        tablePlug: 'tablePlug/tablePlug'
    }).use(['jquery', 'layer', 'form', 'table', 'element','laytpl','tablePlug',  'laydate', 'util'], function () {
        var layer = layui.layer //弹层
            , tablePlug = layui.tablePlug
            , form = layui.form, $ = layui.$
        tablePlug.smartReload.enable(true);//开启智能重载模式

        //如果是用于查看，需要把所有修改项全部设为只读
        if(${0 == addOrEdit }){
            $("select").attr("disabled","disabled");//所有下拉列表设为disabled
            $("input:text").attr("disabled","disabled");//所有text输入框设为disabled
            $("input:text").css("background","#efefef");//所有text输入框背景色设为灰色
            //$(":radio").attr("disabled","disabled");//所有单选radio设为disabled
            $(".layui-btn").hide();//隐藏按钮
        }
        form.render('select');


        //保存
        form.on('submit(submit_btn)', function (data) {
            debugger
            var  field = data.field,
            account = field.account,
            phoneNumber = field.phoneNumber,
            email = field.email;

            if(!/^[0-9]*$/.test(account)){
                alert("账号只能是数字");
                return false;
            }
            if(!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email)){
                alert("邮箱格式不正确");
                return false;
            }
            var url = '${base }/user/addUser.do';
            if(${2 == addOrEdit }){
                url = '${base }/user/updateUser.do'
            }
            var field = data.field;
            $.ajax({
                type: "POST",
                url: url,
                data: field,
                error:function(){
                    layer.alert("请求失败...",{offset: '240px',icon: 5});
                    hideLoading();
                },
                success: function(res){
                    alert(res.msg);
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            });
            return false;
        });
        //遮罩
        function showLoading(){
            layer.open({
                type: 3,
                id:'showLoad',
                shade: [0.7, '#FFFFFF']
            });
        }
        function hideLoading(){
            layer.closeAll('loading'); //关闭加载层;
        }
    });
</script>
</HTML>
