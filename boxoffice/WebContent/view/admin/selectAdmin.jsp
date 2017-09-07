<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>selectAdmin - BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>관리자 목록</h2>
			<p>총${total}건</p>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>아이디</th>
						<th>패스워드</th>
						<th>가입일자</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
					<c:if test="${list.id eq 'admin'}"><tr class="info"></c:if>
					<c:if test="${list.id ne 'admin'}"><tr></c:if>
						<td>${list.id}</td>
						<td>${list.pw}</td>
						<td><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
						<td>
							<c:if test="${sessionID eq 'admin'}">
								<c:if test="${list.id ne 'admin'}">
								<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/delete.do?id=${list.id}'">					
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
								</button>
								</c:if>
							</c:if>
						</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
			<div class="box1">
				<form action="${pageContext.request.contextPath}/admin/insert.do" name="insertAdminForm" method="post" class="form-inline" onsubmit="return check();">
				  <h2>관리자 등록</h2>	
				  <div class="form-group">
				    <label class="id" for="id">id</label>
				    <input type="text" class="form-control" id="id" name="id" placeholder="id">
				  </div>
				  <div class="form-group">
				    <label class="pw" for="pw">Password</label>
				    <input type="password" class="form-control" id="pw" name="pw">
				  </div>
				  <button type="submit" class="btn btn-primary">관리자 등록</button>
				</form>
			</div>
			<c:set var="result" value="${param.insertmsg}"/>
			<c:if test="${result ==true}">
				<p id="insertResult">${param.id}가 등록되었습니다.</p>
			</c:if>
			<c:if test="${result ==false}">
				<p id="insertResult">${param.id}는 이미 등록되어있습니다.</p>
			</c:if>
		</div>	
	</section>
	
	<!-- 알림창  -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">알림창</h4>
	      </div>
	      <div class="modal-body">
	        <p id="msg"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='${pageContext.request.contextPath}/admin/select.do'">Close</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<%@ include file="/common/footer.jsp" %>
	<script>
		var deletemsg="${param.deletemsg}";
		console.log("전"+msg);
		if(deletemsg=="true"){
			$('#myModal').modal('show');
			$('#msg').text("${param.id}삭제 성공");
		}else if(deletemsg=="false"){
			$('#myModal').modal('show');
			$('#msg').text("${param.id}삭제 실패");
		}
	
		$(".nav li").removeClass("active");
		$("#admin").addClass("active");
		 
		setTimeout(function(){
			$("#insertResult").remove();
		}, 2000);
		
		function check() {
		  if(insertAdminForm.id.value == "") {
		    alert("값을 입력해 주세요.");
		    insertAdminForm.id.focus();
		    return false;
		  }
		  else if(insertAdminForm.pw.value == "") {
		    alert("값을 입력해 주세요.");
		    insertAdminForm.pw.focus();
		    return false;
		  }
		  else return true;
		}
	</script>
</body>
</html>