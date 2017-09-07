<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>loginForm - BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<c:if test="${sessionID eq null}">
	<jsp:include page="/common/menu.jsp"/>
	<section>
		<div class="container">
			<div class="center">
			<h2>로그인</h2>
			<form action="${pageContext.request.contextPath}/admin/login.do" class="form-horizontal" method="post">
			  <div class="form-group">
			    <label for="id" class="col-sm-2 control-label">ID</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="id" name="id" placeholder="ID">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="pw" class="col-sm-2 control-label">Password</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="pw" name="pw">
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <div class="checkbox">
			        <label>
			          <input type="checkbox" name="idSaveCheck" id="idSaveCheck"> Remember me
			        </label>
			      </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-default">Sign in</button>
			    </div>
			  </div>
			</form>
			</div>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#login").addClass("active");

		//로그인 정보 맞지 않을때
		var msg ='${msg}';
		if(msg.length>0){
			alert("${msg}");
		}
		
		$(document).ready(function(){
		    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		    var userInputId = getCookie("userInputId");
		    $("input[name='id']").val(userInputId); 
		     
		    if($("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		    }
		     
		    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
		            var userInputId = $("input[name='id']").val();
		            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		        }else{ // ID 저장하기 체크 해제 시,
		            deleteCookie("userInputId");
		        }
		    });
		     
		    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		    $("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
		            var userInputId = $("input[name='id']").val();
		            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		        }
		    });
		});
		 
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		 
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName);
		    var cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue);
		}
	</script>
</c:if>
<c:if test="${sessionID ne null}">
	<% 	
		response.sendRedirect(request.getContextPath()+"/error/403code.html"); 	
	%>
</c:if>
</body>
</html>