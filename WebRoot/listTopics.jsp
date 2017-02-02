<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>主题列表</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
	<style type="text/css">
	a:link{text-decoration:none;color:#0066ff;}
	a:hover{text-decoration:underline;}
	</style>
	<style> 
        .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%;
            height: 100%;
            min-height: 200px;
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 38%; 
            width: 20%; 
            height: 35%; 
            padding: 20px; 
            border: 2px solid orange; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        } 
        button{
        	width:60px;
        	height:20px;
        	border:1px solid #dddddd;
        }
    </style>
    
    <script type="text/javascript">
    $(function(){
    	$("#username").val();
    	$("#password").val();
    });
    
    function submitlogin(){
    	$("#err").html("");
    	var username = $("#username").val();
    	var password = $("#password").val();
    	var role = $("#role").val();
    	
    	if(username == ""){
    		$("#err").html("用户名不能为空");
    		return false;
    	} else if(password == ""){
    		$("#err").html("密码不能为空");
    		return false;
    	} else if(role == ""){
    		$("#err").html("请选择一个角色登录");
    		return false;
    	}
    	
    	if(role == "0"){//普通用户登录
    		fm.action = "${pageContext.request.contextPath}/userAction_login";
    		fm.submit();
    	} else{//管理员登录
    		fm.action = "${pageContext.request.contextPath}/managerAction_login";
    		fm.submit();
    	}
    }
    </script>
</head>
<body>
    <script type="text/javascript">
        function test(){
            var page = document.getElementById("page_id").value;
            var reg = /\d{3}/; //正则匹配
            if(page == ""){
            	alert("请输入页码");
            } else if(!reg.test(page)){
            	alert("数据非法");
            } else{
                window.location.href="topicAction_findAll?page_num="+page;
            }
        }
    </script>
	<!-- 标题 -->
	<div style="margin: 15px auto;" ><font class="logoLabel">C语言精品课程在线交流</font></div>
	<div style="text-align:right;">
		<s:if test="#session.user != null">
			当前登录：<span style="color:#ff0000;text-align:right;"><s:property value="#session.user.username"/></span>&nbsp;&nbsp;
			<s:a name="/" action="userAction_logout" cssClass="color:#aaaaaa;font-size:14px;" cssStyle="text-decoration:none;">[退出]</s:a>
		</s:if>
		<s:else>
			<div style="text-align:right;">
			    <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';
                document.getElementById('fade').style.display='block'">登录</a>&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/register.jsp" style="color:#ff0000;">[注册]</a>
			</div>
		</s:else>
	</div>
	
	<!-- 菜单 -->
	<div class="menubar" style="padding-left:40px;">
		<span style="color:#ffffff;">贴子</span>
	</div>

	<!-- 主题列表 -->
	<table cellspacing="0">
		<tbody class="list topicList">
    		<!--显示表头-->
		    <tr class="title">
		        <td width="25">编号</td>
		        <td width="25">回复</td>
		        <td width="500">标题</td>
		        <td width="110">作者</td>
		        <td width="145">最后回复时间</td>
		    </tr>

    		<!-- 显示帖子列表 -->
    		<s:iterator value="#allTopic" var="topic" status="status">
		        <tr class="data">
		            <td class="num">
		            	<s:property value="#status.index + 1"/>    <!-- 编号 -->
		            </td>
		            <td class="num">
		            	<s:property value="#topic.replies.size()"/>    <!-- 回帖数量 -->
		            </td>
		            <td>
		            	<s:a namespace="/" action="topicAction_findById">    <!-- 这个可以点击 -->
		            		<s:param name="id" value="#topic.id"/>
		            		<s:property value="#topic.title"/>    <!-- 【打印】帖子标题 -->
		            	</s:a>
		            </td>
		            <td class="info">
		            	<s:property value="#topic.author"/>    <!-- 【打印】帖子作者 -->
		            </td>
		            <td class="info">
		            	<s:date name="#topic.lastReplyDate" format="yyyy-MM-dd hh:mm:ss"/>    <!-- 【打印】最后回复时间 -->
		            </td>
		        </tr>
			</s:iterator>
		    
		    <tr>
		        <td colspan="5" class="num">共有主题数<font color="red"><s:property value="#allTopic.size()"/></font>个</td>
		    </tr>    
   		 </tbody>
   		 
	</table>
	
	<!-- 分页 -->
	<table>
	    <!-- 判断是否锁死"首页"和"上一页" -->
	    <s:if test="page_num == 1">
	        <td><button type="button" disabled="disabled">首页</button></td>
	        <td><button type="button" disabled="disabled">上一页</button></td>
   		</s:if>
   		<s:else>
   		    <td><button type="button" onclick="window.location='topicAction_findAll?page_num=1'">首页</button></td>
			<td><button type="button" onclick="window.location='topicAction_findAll?page_num=${page_num-1}'">上一页</button></td>
		</s:else>
		<td>当前第<s:property value="#session.page_num"/>页，共<s:property value="#session.total_page"/>页</td>
		<!-- 显示当前是第几页 -->
		<!-- 判断是否锁死"下一页"和"尾页" %{name == age}-->
		<s:if test="page_num == #session.total_page">
	        <td><button type="button" disabled="disabled">下一页</button></td>
		    <td><button type="button" disabled="disabled">尾页</button></td>
   		</s:if>
   		<s:else>
			<td><button type="button" onclick="window.location='topicAction_findAll?page_num=${page_num+1}'">下一页</button></td>
		    <td><button type="button" onclick="window.location='topicAction_findAll?page_num=${total_page}'">尾页</button></td>
		</s:else>
		<td><input type="text" name="page_text" id="page_id" style="width:30px;" value=""/></td>
		<td><button type="button" onclick="test()">确定</button></td>
		
	</table>
	<div style="margin-bottom: 15px"></div>

	<hr/>
	<!--发表主题表单-->
	<span style="margin-left:15px;font-weight:bolder;">发表新贴</span><br/><br/>
	<s:form namespace="/" action="topicAction_add" method="post" cssClass="addNewTopicForm">
	    <table class="publishArticleForm">
	    <s:if test="#session.user != null">
	        <input type="hidden" name="author" value="${sessionScope.user.username}"/>
	        <tr><td>标　题:</td><td><s:textfield name="title" value="" cssClass="title"/></td></tr>
	        <tr><td>内　容:</td><td><s:textarea name="content" cssClass="content"/></td></tr>
	        <tr><td></td><td><s:submit value="发　表"/></td></tr>
	    </s:if>
	    <s:else>
	        <tr><td>标　题:</td><td><s:textfield name="title" value="" readonly="true" cssClass="title"/></td></tr>
	        <tr><td>内　容:</td><td><s:textarea name="content" readonly="true" cssClass="content"/></td></tr>
	        <tr><td><br></td><td><s:submit value="发　表" disabled="true"/>
	                     请先<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';
            document.getElementById('fade').style.display='block'">登录</a></td></tr>
	    </s:else>
	    </table>
	</s:form>
	<!-- 登录层div---------------------------- -->
	<div id="light" class="white_content"><a href = "javascript:void(0)" onclick = 
        "document.getElementById('light').style.display='none';
         document.getElementById('fade').style.display='none'">关闭</a>
         <fieldset style="width:220px;padding-left:40px;padding-top:20px;margin-top:10%;margin-left:0%;">
	    <legend>登录贴吧</legend>
	    <s:form name="fm" action="" method="post" onsubmit="return submitlogin()">
	    	<div id="err" style="font-size:14px;color:#ff0000;"></div>
	    	<table>
	    		<tr><td>用户名</td><td><s:textfield id="username" name="username" value="" cssStyle="width:150px;"/></td></tr>
	    		<tr><td>密　码</td><td><s:password id="password" name="password" value="" cssStyle="width:150px;"/></td></tr>
	    		<tr><td>角　色</td><td><s:select id="role" name="role" list="#{'0':'普通用户','1':'管理员'}" listKey="key" listValue="value" headerKey="" headerValue="请选择" cssStyle="width:80px;"/></td></tr>
	    		<tr><td colspan="2" align="center"><s:submit value="登录"/></td></tr>
	    	</table>
	    </s:form>
         </fieldset>
         </div> 
        <div id="fade" class="black_overlay"></div> 
</body>
</html>
