<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>Event - BoxOffice</title>
	<meta property="og:url" content="${url}" >
	<meta property="og:title"         content="BoxOffice" >
	<meta property="og:description"   content="Event " >
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section>
		<div class="container">
			<div class="center">
			<h2>Event</h2>
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			         	 미씽 개봉기념 이벤트
			        </a>
			      </h4>
			    </div>
			    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
			      <div class="panel-body">
			     	 <img src="${pageContext.request.contextPath}/images/banner_3.jpg" style="width:100%;">
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingTwo">
			      <h4 class="panel-title">
			        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          Collapsible Group Item #2
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
			      <div class="panel-body">
			        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingThree">
			      <h4 class="panel-title">
			        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			          Collapsible Group Item #3
			        </a>
			      </h4>
			    </div>
			    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
			      <div class="panel-body">
			        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
			      </div>
			    </div>
			  </div>
			</div>	
		</div>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script>
		$(".nav li").removeClass("active");
		$("#event").addClass("active");
		$("a").click(function(){
			setHeight();
		});
	</script>
</body>
</html>