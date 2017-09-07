<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="boxoffice" >
	<meta property="og:description"   content="boxoffice 메인 " >
	
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<article class="row">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
				  	<c:forEach var="bannerList" items="${bannerList}" varStatus="status">
					    <li data-target="#carousel-example-generic" data-slide-to="${status.count-1}"></li>
				    </c:forEach>
				  </ol>
				  
				  <!-- <ol class="carousel-indicators">
				    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				  </ol> -->
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner" role="listbox">
				  	<c:forEach var="bannerList" items="${bannerList}">
						<div class="item">
					      <img src="${pageContext.request.contextPath}/saveFile/${bannerList.banner_file}" alt="${bannerList.banner_name}">
					      <div class="carousel-caption">
							${bannerList.banner_name}
					      </div>
					    </div>
					</c:forEach>
				  
				    <%-- <div class="item active">
				      <img src="${pageContext.request.contextPath}/images/banner_1.png" alt="...">
				      <div class="carousel-caption">
						<!-- 신기한 동물 사전 -->
				      </div>
				    </div>
				    <div class="item">
				      <img src="${pageContext.request.contextPath}/images/banner_2.png" alt="...">
				      <div class="carousel-caption">
						<!-- 신기한 동물 사전 -->
				      </div>
				    </div> --%>
				  </div>
				
				  <!-- Controls -->
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>
			</article>
			<article>
				<div class="row">
					<h3>BOXOFFICE</h3>
					<c:forEach var="list" items="${movieList}" varStatus="status">
					<div class="col-xs-12 col-sm-3">
						<div class="poster_form" onclick="location.href='${pageContext.request.contextPath}/movie/detail.do?m_id=${list.m_id}'">
							<div class="poster">
								<span <c:if test="${status.count==1}">class="best"</c:if>>${status.count}
								</span>
								<img src="${pageContext.request.contextPath}/saveFile/${list.m_file}" alt="${list.m_title}" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
							</div>
							<dl>
								<dt>${list.m_title}</dt>
								<dd>${list.m_date}</dd>
								<dd>관객수 
								<c:if test="${list.m_count >= 1000}"><fmt:formatNumber value="${list.m_count}" pattern=",000" /></c:if>
								<c:if test="${list.m_count < 1000}">${list.m_count}</c:if>
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
			</article>
			<article class="row">
				<div class="col-xs-12 col-md-4">
					<h3>NOTICE</h3>
					<table class="table table-striped">
						<colgroup>
							<col width="*">
							<col width="40%">
						</colgroup>
						<tbody>
							<c:forEach var="noticeList" items="${noticeList}">
								<tr>
									<td><a href="${pageContext.request.contextPath}/notice/detail.do?n_id=${noticeList.n_id}">${noticeList.n_title}</a></td>
									<td class="text-right"><fmt:formatDate value="${noticeList.n_reg_date}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="col-xs-12 col-md-8">
					<h3>EVENT</h3>
					<a href="${pageContext.request.contextPath}/event/select.do">
						<img src="${pageContext.request.contextPath}/images/banner_3.jpg" style="width:100%;">
					</a>
				</div>
			</article>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
</body>
<script>
	$(".nav li").removeClass("active");
	$("#home").addClass("active");
	$("#back").hide();
	$(".item:eq(0)").addClass("active");
	$(".carousel-indicators li:eq(0)").addClass("active");
	// 장르 끝 쉼표 없애기
    for(var i=0; i<4; i++){
    	var m_kind_poster=$('.poster_form:eq('+i+') .m_kind').text().replace(/(\s*)/g, "").slice(0,-1);
    	$('.poster_form:eq('+i+') .m_kind').text(m_kind_poster);
    }
</script>
</html>