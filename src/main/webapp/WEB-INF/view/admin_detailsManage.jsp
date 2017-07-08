<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_detailsManager</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="resources/easyui/themes/default/easyui.css">   
    <link rel="stylesheet" type="text/css" href="resources/easyui/themes/icon.css"> 
      <script type="text/javascript" src="resources/easyui/jquery.min.js"></script>   
  <script type="text/javascript" src="resources/easyui/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="resources/easyui/locale/easyui-lang-zh_CN.js"></script> 
  <script type="text/javascript">
    function admin_insertDetails(){
    	$('#dlg').dialog('open').dialog('setTitle','添加回答');
    	$('#fm').form('clear');
    	url = 'details/admin_insertDetails';
    }
    
    function admin_updateDetails(){
    	
        var row = $('#dg').datagrid('getSelected');
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要更新的回答！");
            return;
        }
        if (row){
        	$('#dlg').dialog('open').dialog('setTitle','编辑回答');
        	$('#fm').form('load',row);
        	url = 'details/admin_updateDetails';
        }
    }

    function saveDetails(){
    	$('#fm').form('submit',{
    		url: url,
    		onSubmit: function(){
    			return $(this).form('validate');
    		},
    		success: function(data){ 
    			var result = eval('('+data+')');
    			if(result.tips=='成功'){
    				$('#dg').datagrid('reload');
    			}
    			$.messager.alert({
    				title : '提示',
    				msg : result.tips
    			});
    		}
    	});
    }
    
    function closeDetailsDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function admin_deleteDetails() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的回答！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].did);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>个回答吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		dids : ids	
            	};
            	
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'details/admin_deleteDetails',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "回答已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "回答删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            			
            		}
            	});
            }
        });
       }
    
       function admin_searchDetails(){
    	   var bid = $('#bid').val();
    	   var pid = $('#pid').val();
    	   var dcontent = $('#dcontent').val();
    	   var replyStart = $('#replyStart').val();
    	   var replyEnd = $('#replyEnd').val(); 
   		   $('#dg').datagrid('load', {  
   			bid : bid,
   			pid : pid,
   			dcontent: dcontent,
   			replyStart : replyStart,
   			replyEnd : replyEnd
  	       });  
    	   
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 回答列表框 -->
	<table id="dg" title="回答管理" class="easyui-datagrid" 
			url="details/admin_selectDetailsList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"c
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true" striped="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="did" width="30" align="center">编号</th>
				<th field="userb" width="30" align="center" data-options="formatter:function(value){return value.bid;}">回答人编号</th>
				<th field="postings" width="30" align="center" data-options="formatter:function(value){return value.pid;}">所在帖子编号</th>
				<th field="dcontent" width="200" align="center">回答内容</th>
				<th field="praisenum" width="20" align="center">获赞数</th>
				<th field="replynum" width="20" align="center">评论数</th>
				<th field="replytime" width="50" align="center">评论时间</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="admin_insertDetails()">添加评论</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="admin_updateDetails()">编辑评论</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteDetails()">删除评论</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;回答人编号：&nbsp;<input type="text" id="bid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchDetails()" style="width:50px;"/> 
        
        &nbsp;所在帖子编号：&nbsp;<input type="text" id="pid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchDetails()" style="width:50px;"/>
        
        &nbsp;回答内容：&nbsp;<input type="text" id="dcontent" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchDetails()" style="width:100px;"/>
        
        &nbsp;回答起始时间：&nbsp;
        <input id="replyStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchDetails()" style="width:100px;"/> 
        -
        &nbsp;回答结束时间：&nbsp;
        <input id="replyEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchDetails()" style="width:100px;"/>  
         <a href="javascript:admin_searchDetails()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

	<!-- 创建或编辑用户对话框 -->
    <div id="dlg" class="easyui-dialog" style="width:400px;height:250px;padding:10px 20px"
		rownumbers="true" singleSelect="true" closed="true" buttons="#dlg-buttons">
		
	<div class="ftitle">回答信息</div>
	<hr>
	<form id="fm" method="post" >
		<input name="did" hidden>
		<div class="fitem">
			<label>回答人编号:</label>
			<input name="userb.bid" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>所在帖子编号:</label>
			<input name="postings.pid" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>回答内容:</label>
			<input name="dcontent" class="easyui-validatebox" required="true">
		</div>
	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveDetails()">保存</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
	
	

  </body>
</html>
