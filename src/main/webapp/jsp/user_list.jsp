<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setAttribute("base",request.getContextPath());
%>
<html>
<head>
    <title>用户管理</title>
    <meta charset="utf-8">
    <LINK rel=stylesheet href="${base}/layui/css/layui.css">
    <script src="${base}/layui/layui.js" charset="utf-8"></script>
    <style>
        /*全局背景色*/
        .layui-card{
            background-color: #F6F5F0;
            margin: 20px 50px 20px 50px;
        }.layui-field-title{
             margin: 20px 50px 20px 50px;
         }
        /*搜索区域样式自定义 */
        .layui-card-header.layui-card-header-auto{padding-top: 20px; padding-bottom: 5px; height: auto;}

    </style>
</head>
<body>
<center>
    <fieldset class="layui-elem-field layui-field-title">
        <legend ><b>SSM-CRUD案例</b></legend>
    </fieldset>
</center>
<div class="layui-card" >
    <div class="layui-card-header layui-card-header-auto" style="margin-top: 10px">
        <form id="queryForm" name="queryForm" class="layui-form layui-form-pane"  method="post" action="">
            <div class="layui-row layui-col-space5 layui-form-item" >
                <div class="layui-col-md3">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <input type="text" id="account" name="account" autocomplete="off" placeholder="请输入账号" class="layui-input">
                    </div>
                </div>
                <div class="layui-col-md3">
                    <label class="layui-form-label">昵称</label>
                    <div class="layui-input-block">
                        <input type="text" id="realName" name="realName" autocomplete="off" placeholder="请输入昵称" class="layui-input">
                    </div>
                </div>
                <div class="layui-col-md3">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <select id="sex"  name="sex" >
                            <option value="" >请选择</option>
                            <option value="1" >男</option>
                            <option value="2" >女</option>
                        </select>
                    </div>
                </div>
                <div >
                    <div class="layui-inline" style="float: right;">
                        <button class="layui-btn" lay-submit="" lay-filter="formmit"  ><i class="layui-icon layui-icon-search" style="font-size: 25px;"></i></button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="layui-card-body" style="margin-top: -20px">
        <table id="user_list" class="layui-hide layui-bg-blue" lay-filter="test"></table>
    </div>
</div>

<script type="text/html" id="barEdit">
    <a title="查看" class="layui-table-link" lay-event="viewRow"><i class="layui-icon">&#xe63c;</i></a>
    &nbsp;<a title="修改" class="layui-table-link" lay-event="editRow"><i class="layui-icon">&#xe631;</i></a>
    &nbsp;<a title="删除" class="layui-table-link" lay-event="delRow"><i class="layui-icon">&#xe640;</i></a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <span class="layui-btn layui-btn-sm" lay-event="addRowData"><i class="layui-icon">&#xe654;</i>新增</span>
        <span type="button" class="layui-btn layui-btn-green layui-btn-sm"
              lay-event="doExport"><i class="layui-icon">&#xe601;</i>导出</span>
        <%--<span class="layui-btn layui-btn-sm" lay-event="delRowData"><i class="layui-icon">&#xe640;</i>批量删除</span>--%>
    </div>
</script>
</body>
<script>
    layui.config({
        base: "${base}/layui/lay/mymodules/"
    }).extend({ //设定模块别名
        tablePlug: 'tablePlug/tablePlug' //相对于上述 base 目录的子目录
    }).use(['layer','form','table','laydate','laytpl','tablePlug','element','util'], function(){
        var layer = layui.layer //弹层
            ,table = layui.table //表格
            ,element = layui.element //元素操作
            ,util = layui.util//工具集
            ,laydate = layui.laydate
            ,laytpl = layui.laytpl
            ,tablePlug = layui.tablePlug
            ,form = layui.form,$=layui.$;
        tablePlug.smartReload.enable(true);//开启智能重载模式
        var tableIns = table.render({
            elem: '#user_list'
            ,skin: 'row' //行边框风格
            ,even: true //开启隔行背景
            ,toolbar: '#toolbarDemo'
            ,smartReloadModel: true
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,url: "${base}/user/findAllUser.do" //数据接口
            ,primaryKey:'id'//主键
            ,page: true //开启分页
            ,limit:5
            ,limits:[5,10,30]
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'id', title: '编号',width:130,align:'center',style:'text-align: center;'}
                ,{field: 'account',title: '账号',width:150,align:'center',style:'text-align: center;'}
                ,{field: 'password',title: '密码',width:150,align:'center',style:'text-align: center;'}
                ,{field: 'realName',title: '昵称',minWidth:100,align:'center',style:'text-align: center;'}
                ,{field: 'sex',title: '性别',width:150,align:'center',style:'text-align: center;'
                    ,templet: function(d){
                        if(d.sex == '1'){
                            return "男";
                        }else if(d.sex == '2'){
                            return "女";
                        }else{
                            return "未知"
                        }
                    }
                }
                ,{field: 'email',title: '邮箱',width:180,align:'center',style:'text-align: center;'}
                ,{field: 'phoneNumber',title: '电话',minWidth:160,align:'center',style:'text-align: center;'}
                ,{field: 'createTime', title: '创建时间',width:160,align:'center',style:'text-align: center;',hide:true
                    ,templet: function(d){
                        var time=d.createTime;
                        if(null == time){
                            return "";
                        }else{
                            return layui.util.toDateString(time,'yyyy-MM-dd');
                        }
                    }
                }
                ,{title: '操作',width:120,align:'center',style:'text-align: center;',toolbar: '#barEdit',fixed:'right'}
            ]]
            /*,parseData: function(res){ //res 即为原始返回的数据
                debugger
                // console.log(JSON.stringify(res.rows[0]));
                return {
                    "code": '0', //解析接口状态
                    "msg": '', //解析提示文本
                    "count": res.records, //解析数据长度
                    "data": res.rows //解析数据列表
                };
            }*/
        });


        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var config = obj.config;
            var tableId = config.id;
            switch(obj.event){
                case 'addRowData': //新增
                    editRow('',1);
                    break;
                case 'doExport': //导出
                    var params = $("#queryForm").serialize();
                    window.location.href="${base}/user/exportUser.do?"+params;
                    break;
                case 'delRowData': //批量删除
                    var checkedIds = tablePlug.tableCheck.getChecked(tableId);
                    if(!checkedIds.length) return layer.msg("请选择删除项",{icon: 5});
                    var userId = checkedIds.join(',');
                    $.ajax({
                        type: "POST",
                        url: "${base }/user/delUser.do",
                        data: "conferenceId="+key,
                        error:function(){
                            alert("请求失败...");
                        },
                        success: function(msg){
                            if(msg){
                                alert("删除成功");
                                SaveAndClosePop();
                            }else{
                                alert("操作失败！");
                            }
                        }
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'viewRow'){//查看
                editRow(data.id,0);
            } else if(obj.event === 'editRow'){//修改
                editRow(data.id,2);
            } else if(obj.event === 'delRow'){//删除
                deleteRow(data.id);
            }
        });



        /* addOrEdit;//0:查看；1：添加；2：修改；*/
        function editRow(id,addOrEdit){
            var title = 0==addOrEdit?'查看用户信息':1==addOrEdit?'添加用户信息':2==addOrEdit?'修改用户信息':'';
            layer.open({
                type: 2,
                title:title,
                offset: '50px',
                move:false,
                resize:false,
                id:'editRow',
                shade: 0.8,
                area: ['700px', '450px'],
                content:['${base}/user/toUserEdit.do?addOrEdit='+addOrEdit+'&id='+id]
                ,cancel: function(index, layero){
                    tableIns.reload({
                        url: '${base}/user/findAllUser.do'
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                    layer.close(index);
                }
                ,end: function () {
                    tableIns.reload({
                        url: '${base}/user/findAllUser.do'
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                }
            });
        }

        //删除
        function deleteRow(key){
            if(confirm('确定删除么')){
                $.ajax({
                    type: "POST",
                    url: "${base }/user/delUser.do",
                    data: "id="+key,
                    error:function(){
                        alert("请求失败...");
                    },
                    success: function(res){
                        debugger
                        alert(res.msg);
                        layer.msg(res.msg);
                        SaveAndClosePop();
                    }
                });
            }
        }


        //查询
        var tableReload = function(){
            var params = $('#queryForm').serialize();
            params = encodeURI(params);
            tableIns.reload({
                url: '${base}/user/findAllUser.do?'+params
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        }

        //监听搜索
        form.on('submit(formmit)', function(data){
            tableReload();
            return false;
        });
        //保存关闭
        function SaveAndClosePop(){
            layer.close(layer.index);
            tableReload();
        }

    });
</script>
</html>
