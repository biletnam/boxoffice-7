<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>영화상세 - BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="영화상세" >
	<meta property="og:description"   content="${movieVO.m_title}" >
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>${movieVO.m_title}</h2>
			<div class="text-center">
				<img src="${pageContext.request.contextPath}/saveFile/${movieVO.m_file}" alt="your image" class="poster_large" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
			</div>
			
			<div class="panel panel-default">
			  <!-- Default panel contents -->
			  <div class="panel-heading"><b>예고편</b></div>
			  <div class="panel-body">
			  <c:if test="${movieVO.m_youtube ne ''}">
			   <div class="embed-responsive embed-responsive-16by9">
				  <iframe class="embed-responsive-item" src="${movieVO.m_youtube}"></iframe>
				</div>
			   </c:if>
			   <c:if test="${movieVO.m_youtube eq ''}">예고편 없음</c:if>
			  </div>
			  <div class="panel-heading"><b>줄거리</b></div>
			  <div class="panel-body">
			    <pre>${movieVO.m_contents}</pre>
			  </div>
			
			  <!-- List group -->
			  <ul class="list-group">
			    <li class="list-group-item"><b>상영날자</b> ${movieVO.m_date}</li>
			    <li class="list-group-item"><b>영화장르</b> 
			    <span class="m_kind">
		    		<!-- 장르  -->
					<c:if test="${fn:indexOf(movieVO.m_kind, '1') != -1}">드라마,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '2') != -1}">판타지,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '3') != -1}">애니메이션,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '4') != -1}">액션,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '5') != -1}">코미디,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '6') != -1}">공포,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '7') != -1}">SF,</c:if>
					<c:if test="${fn:indexOf(movieVO.m_kind, '8') != -1}">기타,</c:if>
				</span>	
			    </li>
			    <li class="list-group-item"><b>영화등급</b>
					<!-- 등급  -->
					<c:if test="${movieVO.m_grade eq '1'}">전체 관람가</c:if>
					<c:if test="${movieVO.m_grade eq '2'}">12세 관람가</c:if>
					<c:if test="${movieVO.m_grade eq '3'}">15세 관람가</c:if>
					<c:if test="${movieVO.m_grade eq '4'}">청소년 관람불가</c:if>
					<c:if test="${movieVO.m_grade eq '5'}">기타</c:if>
			  	</li>
			  </ul>
			</div>
			<c:if test="${sessionID ne null}">
			<div class="btn_area">
				<div class="fr">
					<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/movie/insert.do'">영화등록</button>
					<button type="button" class="btn btn btn-info" onclick="location.href='${pageContext.request.contextPath}/movie/update.do?m_id=${movieVO.m_id}'">수정</button>	
					<button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/movie/delete.do?m_id=${movieVO.m_id}'">삭제</button>
				</div>
			</div>
			</c:if>

			<article class="reply">
				<h3>댓글(${reply_total}개 -평점 
				<span class="btn_star2">
					<c:forEach var="i" begin="1" end="${starAvg}" step="1">
					  		<a href="#none" class="on"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
				  	</c:forEach>
				 </span>${starAvg}점)
				</h3>
				<!-- 댓글쓰기 -->
				<c:if test="${reply_search_total == 0 && naver_nickname ne null}">
					<form action="${pageContext.request.contextPath}/movie/insertReply.do" method="post">
					<input type="hidden" name="m_id" value="${movieVO.m_id}">
					<input type="hidden" name="m_re_nickname" value="${naver_nickname}">
					<input type="hidden" name="m_re_email" value="${naver_email}">
					<input type="hidden" id="m_re_star" name="m_re_star" value="">
					<div class="panel panel-success">
					  <div class="panel-heading">${naver_nickname}
						  <div class="btn"><button type="submit"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></button></div>				
					  </div>
					  <div class="panel-body">
					  	<div class="btn_star">
					  		<label>평점</label>
					  		<a href="#none" class="on" onclick="star_check(1, null);"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
					  		<a href="#none" class="on" onclick="star_check(2, null);"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
					  		<a href="#none" class="on" onclick="star_check(3, null);"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
					  		<a href="#none" class="on" onclick="star_check(4, null);"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
					  		<a href="#none" class="on" onclick="star_check(5, null);"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
					  	</div>
					    <textarea class="form-control" rows="3" name="m_re_contents"></textarea>	
					  </div>
					</div>
					</form>
				</c:if>
				<c:if test="${movieVO.m_re_total == 0}">
					등록된 댓글 없음
				</c:if>
				
				<c:forEach var="list" items="${reply_list}" varStatus="status">
				<!-- 댓글목록  -->
				<div class="panel panel-info" id="num_${list.m_re_id}">
				  <div class="panel-heading">
				  	  <span class="m_re_id skip">${list.m_re_id}</span>
				  	     작성자:${list.m_re_nickname}<span class="info">(<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.m_re_reg_date}"/>)</span>
					  <div class="btn">
						  <c:if test="${naver_nickname eq list.m_re_nickname}">
						  	<button type="button" class="btn_update">					
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							</button>
						  	<button type="button" onclick="deleteReply(${list.m_re_id}, '${list.m_re_nickname}')">					
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
							</button>
						  </c:if>	
					  </div>	
					  <div class="btn update">
					  	<button type="button" onclick="updateReply(${list.m_re_id})">
					  		<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
					  	</button>	
					  	<button type="button" class="btn_cancel"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span></button>
					  </div>  			
				  </div>
				  <div class="panel-body">
				  	<div class="btn_star">
				  		<label>평점</label>
				  		<c:forEach var="i" begin="1" end="${list.m_re_star}" step="1">
					  		<a href="#none" class="on"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
				  		</c:forEach>
				  		<c:forEach var="i" begin="1" end="${5-list.m_re_star}" step="1">
					  		<a href="#none"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></a>
				  		</c:forEach>
				  	</div>
				  	<pre class="info">${list.m_re_contents}</pre>
				  	<textarea class="form-control update" rows="3" name="m_re_contents">${list.m_re_contents}</textarea>	
				  </div>
				</div>
				</c:forEach>
				<!-- 댓글목록  -->
				<!-- 페이징 -->
				<c:if test="${reply_total != 0}">
				<jsp:include page="/common/paging.jsp"/>
				</c:if>
			</article>
		</div>	
	</section>
	<form id="replyForm">
		<input type="hidden" name="m_id" value="${movieVO.m_id}">
		<input type="hidden" name="m_re_id">
		<input type="hidden" name="m_re_nickname">
		<input type="hidden" name="m_re_star">
		<input type="hidden" name="m_re_contents">
	</form>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#movie").addClass("active");
		$("input[name=m_re_star]").val(5);
		$("#replyUpdateForm").hide();
		
		// 장르끝 쉼표 없애기
    	var m_kind=$('.m_kind').text().replace(/(\s*)/g, "").slice(0,-1);
    	$('.m_kind').text(m_kind);
		
		//별점
		function star_check(index, id){
			if(id!=null){
				id='#num_'+id+' '; 
			}else{
				id='';
			}
			console.log("댓글번호:"+id);
			
			for(var i=index; i<5; i++){$(''+id+'.btn_star a:eq('+i+')').removeClass('on');}
			for(var i=0; i<index; i++){$(''+id+'.btn_star a:eq('+i+')').addClass('on');}
			
			/* if(index == 1){
				for(var i=1; i<5; i++){$(''+id+'.btn_star a:eq('+i+')').removeClass('on');}
				$('.btn_star a:eq(0)').addClass('on');
			}else if(index == 2){
				for(var i=2; i<5; i++){$(''+id+'.btn_star a:eq('+i+')').removeClass('on');}
				for(var i=0; i<2; i++){$(''+id+'.btn_star a:eq('+i+')').addClass('on');}
			}else if(index == 3){
				for(var i=3; i<5; i++){$(''+id+'.btn_star a:eq('+i+')').removeClass('on');}
				for(var i=0; i<3; i++){$(''+id+'.btn_star a:eq('+i+')').addClass('on');}
			}else if(index == 4){
				$('.btn_star a:eq(4)').removeClass('on');
				for(var i=0; i<4; i++){$(''+id+'.btn_star a:eq('+i+')').addClass('on');}
			}else if(index == 5){
				for(var i=0; i<5; i++){$(''+id+'.btn_star a:eq('+i+')').addClass('on');}
			} */
			$("input[name=m_re_star]").val(index);
		}

		//수정폼 활성화
		$('.btn_update').click(function(){
			var id=$(this).parents('.panel').find('.m_re_id').text();
			console.log("댓글번호:"+id);
			$(this).parents('.panel').find('.info').hide();
			$(this).parents('.panel').find('.update').show();
			for(var i=0; i<5; i++){
				$('.btn_star').find('a:eq('+i+')').attr('onclick','star_check('+(i+1)+', '+id+')');
			}
		});
		
		//수정 취소
		$('.btn_cancel').click(function(){
			$(this).parents('.panel').find('.info').show();
			$(this).parents('.panel').find('.update').hide();
		});
		
		// 댓글 수정
		function updateReply(id){
			console.log(id);
			$('#replyForm input[name=m_re_id]').val(id);
			$('#replyForm input[name=m_re_contents]').val($('#num_'+id+' textarea').val());
			$('#replyForm').attr({
	    		action:'${pageContext.request.contextPath}/movie/updateReply.do',
	    		method:'post'
	    	}).submit();	    												
		}
		
		// 댓글 삭제
		function deleteReply(id, name){
			console.log(id+","+name);
			$('input[name=m_re_id]').val(id);
			$('input[name=m_re_nickname]').val(name);
			$('#replyForm').attr({
	    		action:'${pageContext.request.contextPath}/movie/deleteReply.do',
	    		method:'post'
	    	}).submit();
		}		
	</script>
</body>
</html>