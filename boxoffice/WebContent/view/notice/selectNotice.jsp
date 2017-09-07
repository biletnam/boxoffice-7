<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>공지사항 - BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="공지사항- BoxOffice" >
	<meta property="og:description"   content="공지사항입니다." >
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>공지사항</h2>
			<p>총${total}건</p>
			<table class="table table-striped">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="30%">
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">No.</th>
						<th class="text-center">제목</th>
						<th class="text-center">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<tr>
							<td class="text-center">${list.n_id}</td>
							<td><a href="${pageContext.request.contextPath}/notice/detail.do?n_id=${list.n_id}">${list.n_title}</a></td>
							<td class="text-center"><fmt:formatDate value="${list.n_reg_date}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
			<!-- 페이징 -->
			<jsp:include page="/common/paging.jsp"/>
			
			<c:if test="${sessionID ne null}">
			<div class="btn_area">
			    <div class="fr">
				<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/notice/insert.do'">공지사항 등록</button>
				</div>
			</div>	
			</c:if>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#notice").addClass("active");
	</script>
</body>
</html>