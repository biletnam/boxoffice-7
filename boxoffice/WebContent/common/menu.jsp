<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="${pageContext.request.contextPath}/main.do">BoxOffice</a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li id="home"><a href="${pageContext.request.contextPath}/main.do">Home<span class="sr-only">(current)</span></a></li>
	        <li id="movie"><a href="${pageContext.request.contextPath}/movie/select.do">Movie<span class="sr-only">(current)</span></a></li>
	        <li id="dropdown" class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Menu<span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li id="banner"><a href="${pageContext.request.contextPath}/banner/select.do">Banner</a></li>
	            <li class="divider"></li>
	            <li id="notice"><a href="${pageContext.request.contextPath}/notice/select.do">Notice</a></li>
	            <li class="divider"></li>
	            <li id="event"><a href="${pageContext.request.contextPath}/event/select.do">Event</a></li>
	          </ul>
	        </li>
	        <c:if test="${sessionID ne null}">
	        	<li id="admin"><a href="${pageContext.request.contextPath}/admin/select.do">Admin<span class="sr-only">(current)</span></a></li>
	      	</c:if>
	      </ul>
	      <form class="navbar-form navbar-left" role="search" action="${pageContext.request.contextPath}/movie/select.do">
	        <div class="form-group">
	        	 <select class="form-control" name="keyWord">
					  <option value="m_title">영화제목</option>
					  <option value="m_kind">장르</option>
					  <option value="m_grade">등급</option>
				 </select>
				 <input type="text" name="keyValue" class="form-control" placeholder="검색할 단어를 입력하세요." id="m_title">
				 <select class="form-control" name="keyValue" style="display: none" id="m_kind">
				 	  <option value="">전체</option>
					  <option value="1">드라마</option>
					  <option value="2">판타지</option>
					  <option value="3">애니메이션</option>
					  <option value="4">액션</option>
					  <option value="5">코미디</option>
					  <option value="6">공포</option>
					  <option value="7">SF</option>
					  <option value="8">기타</option>
				 </select>
				 <select class="form-control" name="keyValue" style="display: none" id="m_grade">
				 	  <option value="">전체</option>
					  <option value="1">전체 관람가</option>
					  <option value="2">12세 관람가</option>
					  <option value="3">15세 관람가</option>
					  <option value="4">청소년 관람불가</option>
					  <option value="5">기타</option>
				 </select>
	        </div>
	        <button type="submit" class="btn btn-primary">Search</button>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	      	<li id="naver_id_login" <c:if test="${naver_email ne null}">style="display:none"</c:if>></li>
	      	<c:if test="${naver_email ne null}">
	      	<li id="naver_id_logout">
	      		<a href="#none" onclick="logout();"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>${naver_nickname}님  로그아웃</a>
	      	</li>
	     	</c:if>	
	      
	      <c:choose>
	      	<c:when test="${sessionID eq null}">	
	        	<li id="login"><a href="${pageContext.request.contextPath}/admin/login.do"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 관리자 login</a></li>
	      	</c:when>
	      	<c:otherwise>
	      		<li id="login"><a href="${pageContext.request.contextPath}/admin/logout.do">${sessionID}님 접속<span style="margin-left:10px" class="glyphicon glyphicon-log-out" aria-hidden="true"></span> logout</a></li>
	        </c:otherwise>
	      </c:choose>
	     
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
</header>

<!-- 네이버아디디로로그인 초기화 Script -->
   <script type="text/javascript">
    var naver_id_login = new naver_id_login("${naverID}", "${root}/callback.do");
    var state = naver_id_login.getUniqState();
    naver_id_login.setButton("green", 3, 30);
    naver_id_login.setDomain("${root}");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();
    
    function logout() {
   	  // 로그아웃 아이프레임 naver로그아웃, 세션 로그아웃
   	  $("body").append("<iframe id='logoutIframe' style='display: none;'></iframe>");
   	  $("#logoutIframe").attr("src", "http://nid.naver.com/nidlogin.logout");
	  setTimeout("location.href='${root}/naverLogout.do'", 1000);
   	}
    
    $("select[name=keyWord]").change(function(){
    	var selected=$("select[name=keyWord] option:selected").val();
    	console.log(selected);
    	if(selected == "m_title"){
    		$("#m_kind, #m_grade").removeAttr('name').hide();
    		$("#m_title").attr("name","keyValue").show();
    	}else if(selected == "m_kind"){
    		$("#m_title, #m_grade").removeAttr('name').hide();
    		$("#m_kind").attr("name","keyValue").show();
    	}else if(selected == "m_grade"){
    		$("#m_title, #m_kind").removeAttr('name').hide();
    		$("#m_grade").attr("name","keyValue").show();
    	}
    });
</script>