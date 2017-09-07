<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>박스오피스 목록 - BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="박스오피스 목록 - BoxOffice" >
	<meta property="og:description"   content="BoxOffice페이지입니다. " >
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>박스오피스 목록</h2>
			
			<div class="btn_area top">
				<span class="total">총<b>${total}</b>건</span>
				<div class="fr">
					<c:if test="${sessionID ne null}">
					<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/movie/insert.do'">영화등록</button>
					</c:if>
					<button type="button" class="btn btn-default" title="포스터형보기" id="poster_btn">
					  <span class="glyphicon glyphicon-th-large" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-default" title="리스트형보기" id="list_btn">
					  <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
					</button>
				</div>
			</div>
			
			<table class="table table-striped" id="listForm" style="display: none;">
				<thead>
					<tr>
						<th class="text-center">순위</th>
						<th class="text-center">제목</th>
						<th class="text-center">평점</th>
						<th class="text-center">상영기간</th>
						<th class="text-center">장르</th>
						<th class="text-center">등급</th>
						<th class="text-center">관객수(명)</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${list}" varStatus="status">
					<tr>
						<td class="text-center">
							<%-- ${status.count} --%>
							${(pageNum-1)*rowNum+status.index+1}
						</td>
						<td>
							<a href="${pageContext.request.contextPath}/movie/detail.do?m_id=${list.m_id}">${list.m_title}
							<c:if test="${list.m_re_total != 0}"><span class="glyphicon glyphicon-comment"></span>
								<c:if test="${list.m_re_total >= 1000}"><fmt:formatNumber value="${list.m_re_total}" pattern=",000" /></c:if>
								<c:if test="${list.m_re_total < 1000}">${list.m_re_total}</c:if>
							</c:if>
							</a>
						</td>
						<td class="text-center btn_star">
							<c:if test="${list.m_re_star > 0}">
								<c:forEach var="i" begin="1" end="${list.m_re_star}" step="1">
							  		<a href="#none" class="on"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
						  		</c:forEach>
						  		<c:forEach var="i" begin="1" end="${5-list.m_re_star}" step="1">
							  		<a href="#none"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
						  		</c:forEach>
					  		</c:if>
					  		<c:if test="${list.m_re_star == 0}">-</c:if>
						</td>
						<td class="text-center">${list.m_date}</td>
						<td class="text-center m_kind">
							<!-- 장르  -->
							<c:if test="${fn:indexOf(list.m_kind, '1') != -1}">드라마,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '2') != -1}">판타지,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '3') != -1}">애니메이션,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '4') != -1}">액션,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '5') != -1}">코미디,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '6') != -1}">공포,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '7') != -1}">SF,</c:if>
							<c:if test="${fn:indexOf(list.m_kind, '8') != -1}">기타,</c:if>
						</td>
						<!-- 등급  -->
						<c:if test="${list.m_grade eq '1'}"><td class="text-center">전체 관람가</td></c:if>
						<c:if test="${list.m_grade eq '2'}"><td class="text-center">12세 관람가</td></c:if>
						<c:if test="${list.m_grade eq '3'}"><td class="text-center">15세 관람가</td></c:if>
						<c:if test="${list.m_grade eq '4'}"><td class="text-center">청소년 관람불가</td></c:if>
						<c:if test="${list.m_grade eq '5'}"><td class="text-center">기타</td></c:if>
						<td class="text-right">
							<c:if test="${list.m_count >= 1000}"><fmt:formatNumber value="${list.m_count}" pattern=",000" /></c:if>
							<c:if test="${list.m_count < 1000}">${list.m_count}</c:if>
						</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
			<div id="posterForm" style="display: none;">
				<div class="row">
					<c:forEach var="list" items="${list}" varStatus="status">
					<div class="col-xs-12 col-sm-4 col-md-3">
						<div class="poster_form" onclick="location.href='${pageContext.request.contextPath}/movie/detail.do?m_id=${list.m_id}'">
							<div class="poster">
								<span <c:if test="${status.count==1}">class="best"</c:if>>
								<%-- ${status.count} --%>
								${(pageNum-1)*rowNum+status.index+1}
								</span>
								<img src="${pageContext.request.contextPath}/saveFile/${list.m_file}" alt="${list.m_title}" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
							</div>
							<dl>
								<dt>${list.m_title}</dt>
								<dd>${list.m_date}</dd>
								<dd>관객수
								<c:if test="${list.m_count >= 1000}"><fmt:formatNumber value="${list.m_count}" pattern=",000" /></c:if>
								<c:if test="${list.m_count < 1000}">${list.m_count}</c:if>명
								</dd>
								<!-- 장르  -->
								<dd class="m_kind">
								<c:if test="${fn:indexOf(list.m_kind, '1') != -1}">드라마,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '2') != -1}">판타지,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '3') != -1}">애니메이션,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '4') != -1}">액션,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '5') != -1}">코미디,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '6') != -1}">공포,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '7') != -1}">SF,</c:if>
								<c:if test="${fn:indexOf(list.m_kind, '8') != -1}">기타,</c:if>
								</dd>
								<!-- 등급  -->
								<c:if test="${list.m_grade eq '1'}"><dd>전체 관람가</dd></c:if>
								<c:if test="${list.m_grade eq '2'}"><dd>12세 관람가</dd></c:if>
								<c:if test="${list.m_grade eq '3'}"><dd>15세 관람가</dd></c:if>
								<c:if test="${list.m_grade eq '4'}"><dd>청소년 관람불가</dd></c:if>
								<c:if test="${list.m_grade eq '5'}"><dd>기타</dd></c:if>
							</dl>
							<%-- <c:if test="${list.m_re_total != 0}"> --%>
							<div class="reply">
								<span class="glyphicon glyphicon-comment"></span>
								<c:if test="${list.m_re_total >= 1000}"><fmt:formatNumber value="${list.m_re_total}" pattern=",000" /></c:if>
								<c:if test="${list.m_re_total < 1000}">${list.m_re_total}</c:if>
								<span class="glyphicon glyphicon-star"></span>${list.m_re_star}
							</div>
							<%-- </c:if> --%>
						</div>
					</div>
					</c:forEach>	
				</div>
			</div>
			<!-- 페이징 -->
			<c:if test="${total != 0}">
			<jsp:include page="/common/paging.jsp"/>
			</c:if>
		</div>	
	</section>
	
	<!-- 알림창 -->
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
	        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='${pageContext.request.contextPath}/movie/select.do'">Close</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<%@ include file="/common/footer.jsp" %>
	<script>
		var movieTheme=sessionStorage.getItem('movieTheme');
		if(movieTheme=="list"){
			$("#posterForm").hide();
			$("#listForm").show();
		}else{
			$("#listForm").hide();
			$("#posterForm").show();
		}
		var msg="${param.msg}";
		console.log("전"+msg);
		if(msg=="true"){
			$('#myModal').modal('show');
			$('#msg').text("삭제 성공");
		}else if(msg=="false"){
			$('#myModal').modal('show');
			$('#msg').text("삭제 실패");
		}
		$(".nav li").removeClass("active");
		$("#movie").addClass("active");
					
		// 장르 끝 쉼표 없애기
	    for(var i=0; i<'${total}'; i++){
	    	var m_kind_table=$('tbody tr:eq('+i+') .m_kind').text().replace(/(\s*)/g, "").slice(0,-1);
	    	var m_kind_poster=$('#posterForm .poster_form:eq('+i+') .m_kind').text().replace(/(\s*)/g, "").slice(0,-1);
	    	$('tbody tr:eq('+i+') .m_kind').text(m_kind_table);
	    	$('#posterForm .poster_form:eq('+i+') .m_kind').text(m_kind_poster);
	    }
		
		// 포스터형식, 리스트형식보기
		$("#list_btn").click(function(){
			$("#posterForm").hide();
			$("#listForm").show();
			sessionStorage.setItem('movieTheme','list');
			setTimeout(function() {setHeight()}, 0);
		});
		$("#poster_btn").click(function(){
			$("#listForm").hide();
			$("#posterForm").show();
			sessionStorage.setItem('movieTheme','poster');
			setTimeout(function() {setHeight()}, 0);
		});		
	</script>
</body>
</html>