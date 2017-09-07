<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>loginForm - BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section>
		<div class="container center">
			<div class="center">
				<h2>로그아웃</h2>
				로그아웃 되셨습니다. 2초 뒤에 메인페이지로 이동합니다.
			</div>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#login").addClass("active");
		var url="location.href='${pageContext.request.contextPath}/admin/login.do'"
		setTimeout(url, 2000);
	</script>
</body>
</html>