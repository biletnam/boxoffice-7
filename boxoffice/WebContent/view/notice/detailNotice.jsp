<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<title>공지사항상세 - BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="공지사항상세- BoxOffice" >
	<meta property="og:description"   content="${noticeVO.n_title}" >
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>공지사항</h2>
			<table class="table table-striped">
			<colgroup>
				<col width="10%">
			</colgroup>
				<tbody>
					<tr>
						<th>No.</th>
						<td>${noticeVO.n_id}</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${noticeVO.n_title}</td>
					</tr>
					<tr>	
						<th>등록일</th>
						<td><fmt:formatDate value="${noticeVO.n_reg_date}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					</tr>
					<tr>
						<td colspan="3">${noticeVO.n_contents}</td>
					</tr>
					<c:if test="${noticeVO.n_file ne null}">
					<tr>
						<td colspan="3">${noticeVO.n_file}							
							<button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/download.do?filename=${noticeVO.n_file}'">다운로드</button>
						</td>		
					</tr>
					</c:if>
				</tbody>
			</table>
			
			<div class="btn_area">
				<div class="fr">
				<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/notice/select.do'">목록</button>
				<c:if test="${sessionID ne null}">
					<button type="button" class="btn btn-info" onclick="location.href='${pageContext.request.contextPath}/notice/update.do?n_id=${noticeVO.n_id}'">수정</button>
					<button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/notice/delete.do?n_id=${noticeVO.n_id}'">삭제</button>
				</c:if>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#notice").addClass("active");
		$(".table").find("br").remove();
	</script>
</body>
</html>