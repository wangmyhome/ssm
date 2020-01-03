/**
 * 创建于:2019-1-10<br>
 * layui打开窗口
 * 通过watch.js监听window对象属性变化,需要提前引入watch.js
 * @author lyc
 * @version 1.0
 */
(function($) {
    window.$myPopup = new function() {
    	var index ;
    	var laydate,laypage,layer,table,carousel,upload,element,slider,form;
    	
    	/**
         * @description 重写showModalDialog 方法
         * @param {url} 打开页面url
         * @param{arg} 可选参数，类型：变体。用来向对话框传递参数。传递的参数类型不限，包括数组等
         * @param{feature}可选参数，类型：字符串。用来描述对话框的外观等信息，可以使用以下的一个或几个，用分号“;”隔开
         * @param {Function} callback=[callback] 回调函数
         */
    	this.showModalDialog = function(url,width,height,callback) {
    		layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function(){
    	  		   laydate = layui.laydate //日期
    	  		  ,laypage = layui.laypage //分页
    	  		  ,layer = layui.layer //弹层
    	  		  ,table = layui.table //表格
    	  		  ,carousel = layui.carousel //轮播
    	  		  ,upload = layui.upload //上传
    	  		  ,element = layui.element //元素操作
    	  		  ,slider = layui.slider //滑块
    	  		  ,form = layui.form,$=layui.$;
    	    		  
    	  		  index = layer.open({
    				  type: 2, 
    				  offset: '30px',
    				  move:false,
    				  resize:false,
    				  area: [width, height],
    				  content: [url, 'yes'],
    				  cancel: function(index, layero){ 
    					  var callback = $myPopup.pullCallback(callbackKey);
    			          if(callback)callback(null);
    				  }    
    				}); 
    		  		if (callback) {
    		            callbackKey = $myPopup.pushCallback(callback);
    		        }
	    	});
        }
    	//关闭打开的子页面
    	this.closeOne = function() {
  	  		  layer.close(index);
        }
    	
        var callbackPool = {};
        var callbackKey = "";
        var callbackIndex = 0;
        /** 
         * @description 向回调池里面新增一个callback函数,并返回索引值
         * @param {Function} callback=[] 回调函数
         * @return {String} 该回调函数的索引值，可通过该值获取到存放的回调函数
         */
        this.pushCallback = function(callback) {
                var key = "callbackKey_" + (callbackIndex++);
                callbackPool[key] = callback;
                return key;
            }
            /** 
             * @description 通过索引值从回调池里面取出一个callback函数
             * @param {String} key=[] 回调函数索引值
             * @return {Function} 存放的回调函数
             */
        this.pullCallback = function(key) {
                var back = callbackPool[key];
                delete callbackPool[key];
                return back;
            }

        this._methodBacked = function(callbackKey, backParam) {
            var callback = this.pullCallback(callbackKey);
            if(callback){
            	callback(backParam);
            	this.closeOne();//关闭弹出子页面
            }
        }
        //回调函数
       window.returnValueFunc = function(returnValue){
    	   $myPopup._methodBacked(callbackKey,returnValue);
       }
       
    }
    
    
})(window)