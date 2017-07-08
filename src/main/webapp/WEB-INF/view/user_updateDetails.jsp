<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="czx"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'userDetails.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link href="resources/amazeui/css/amazeui.css" type="text/css"
	rel="stylesheet">
<link rel="stylesheet" href="resources/amazeui/css/admin.css">
<style type="text/css">
#img {
	width: 150px;
	height: 150px;
}

h2 {
	margin-top: 5px;
}

textarea {
	margin-top: 10px;
}
.loadfile {
	margin-top: 15%;
	display: block;
	width: 100px;
	height: 100px;
	line-height: 100px;
	font-size: 60px;
	text-align: center;
	border: 1px solid #ccc;
	font-size: 60px;
}

.bg_size {
	background-repeat: no-repeat;
	background-size: 100px 100px;
}
#save{
  margin-top:10px;
}
</style>

</head>

<body>


  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改信息</strong> / <small>Update information</small></div>
      </div>

      <hr/>

      <div class="am-g">
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
          <div class="am-panel am-panel-default">
            <div class="am-panel-bd">
              <div class="am-g">
               <form action="user/user_updateImg" method="post" enctype="multipart/form-data">
                <div class="am-u-md-4">
	                <div class="c">
						<label id="imglab" title="点击上传头像" class="loadfile"
							for="uploadfile"><img height="100px" width="100px" 
							src="${sessionScope.curr_user.img }"></label><input type="file"
							id="uploadfile" style="display:none;" name="upload"/>
					</div>
                </div>
                <div class="am-u-md-8" id="save">
                  <p>点击更新头像 </p>
                  <br>
                  <div class="am-form">
                    <div class="am-form-group">
                      <button type="submit" class="am-btn am-btn-primary am-btn-xs">保存</button>
                    </div>
                  </div>
                </div>
               </form>
              </div>
            </div>
          </div>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
          <div class="am-form am-form-horizontal">
            <div class="am-form-group">
              <label for="name" class="am-u-sm-3 am-form-label">姓名 / Name</label>
              <div class="am-u-sm-9">
                <input type="email" id="name" value="${sessionScope.curr_user.name }" disabled>
              </div>
            </div>

            <div class="am-form-group">
              <label for="email" class="am-u-sm-3 am-form-label">电子邮件 / Email</label>
              <div class="am-u-sm-9">
                <input type="email" id="email" value="${sessionScope.curr_user.email }">
              </div>
            </div>

            <div class="am-form-group">
              <label for="phone" class="am-u-sm-3 am-form-label">电话 / Telephone</label>
              <div class="am-u-sm-9">
                <input type="tel" id="phone" value="${sessionScope.curr_user.phone }">
              </div>
            </div>

            <div class="am-form-group">
              <label for="intro" class="am-u-sm-3 am-form-label">简介 / Intro</label>
              <div class="am-u-sm-9">
                <textarea class="" rows="5" id="intro" >${sessionScope.curr_user.intro }</textarea>
              </div>
            </div>

            <div class="am-form-group">
              <div class="am-u-sm-9 am-u-sm-push-3">
                <button type="button" class="am-btn am-btn-primary" onclick="user_updateDetails()">保存修改</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <footer class="admin-content-footer">
      <hr>
      <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
    </footer>

  </div>
  <!-- content end -->
	<!--[if lt IE 9]>
	<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
	<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
	<![endif]-->

	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<!--<![endif]-->
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script src="resources/amazeui/js/app.js"></script>
	<script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
	
	function user_updateDetails(){
		var email=$('#email').val();
		var phone=$('#phone').val();
		var intro=$('#intro').val();
		
	    var jsonStr = {
	    		email : email,
	    		phone : phone,
	    		intro : intro
		};
	
		$.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : 'user/user_doUpdateDetails',
			data : jsonStr,
			dataType : 'json',
			success : function(data) {
				layer.msg(data.tips);
				
			},
			error : function(data) {
				layer.msg('服务器出错，请稍后重试');
			}
		});
	}
	
	$(function() {
		$("#uploadfile")
				.on(
						"change",
						function(e) {
							var fr = new FileReader();
							fr.readAsDataURL(document
									.getElementById("uploadfile").files[0]);
							fr.onload = function(e) {
								$("#imglab").addClass("bg_size");
								$("#imglab").css("background-image",
										"url(" + e.target.result + ")");
								$("#imglab").html('');
							};
						});
	});
	</script>
</body>
</html>
