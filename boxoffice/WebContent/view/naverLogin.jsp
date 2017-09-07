<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/docType.jspf" %>
<html>
  <head>
    <title>네이버로그인-로그인창닫기</title>
    <%@ include file="/common/common.jspf" %>
  </head>
  <body>
  	<script>
  		function loginclose(){
  			window.opener.location.reload();
  			window.close();
  		}
  		setTimeout(loginclose(), 1000);
  	</script>
  </body>
</html>