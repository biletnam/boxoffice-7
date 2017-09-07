<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>insertMovieForm -BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section>
		<div class="container">
			<div class="center">
			<h2>영화 등록</h2>
			<form action="${pageContext.request.contextPath}/movie/insert.do" class="form-horizontal" 
			method="post" enctype="multipart/form-data" name="movieForm" onsubmit="return check();">
			  <div class="form-group">
			    <label for="m_title2" class="col-sm-2 control-label">제목</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="m_title2" name="m_title">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="m_kind2" class="col-sm-2 control-label">장르</label>
			    <div class="col-sm-10">
				    <label class="checkbox-inline"><input type="checkbox" name="m_kind" id="m_kind2" value="1">드라마</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="2">판타지</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="3">애니메이션</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="4">액션</label>
				    <label class="checkbox-inline"><input type="checkbox" name="m_kind" value="5">코미디</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="6">공포</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="7">SF</label>
					<label class="checkbox-inline"><input type="checkbox" name="m_kind" value="8">기타</label>
				</div>
			  </div>			    
			  <div class="form-group"> 
			    <label for="m_grade2" class="col-sm-2 control-label">상영등급</label>
			    <div class="col-sm-4">
				  <select class="form-control" id="m_grade2" name="m_grade">
					  <option value="1">전체 관람가</option>
					  <option value="2">12세 관람가</option>
					  <option value="3">15세 관람가</option>
					  <option value="4">청소년 관람불가</option>
					  <option value="5">기타</option>
					</select>
			    </div>
			    <label for="m_count" class="col-sm-2 control-label">관객수</label>
			    <div class="col-sm-4">
				  <input type="text" class="form-control" id="m_count" name="m_count">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="m_date" class="col-sm-2 control-label">상영기간</label>
			    <div class="col-sm-10 pr">
			    	<div class="dateicon">
				    	<input type="text" name="m_date" id="m_date" class="form-control" />
				    	<label for="m_date"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></label>
			    	</div>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="m_youtube" class="col-sm-2 control-label">예고편링크</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="m_youtube" name="m_youtube" value="https://www.youtube.com/embed/">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="m_contents" class="col-sm-2 control-label">줄거리</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="10" id="m_contents" name="m_contents"></textarea>	
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="m_file" class="col-sm-2 control-label">포스터이미지</label>
			    <div class="col-sm-10">
			    	<input type="file" id="m_file" name="m_file">
			    	<p class="help-block">파일업로드크기:최대 5Mb <span id="filesize" style="color:red;"></span></p>
			    	<img id="preImage" class="poster_small" src="${pageContext.request.contextPath}/saveFile/${movieVO.m_file}" alt="your image" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
			    </div>
			  </div>
			  <div class="btn_area">
			    <div class="fr">
			      <button type="submit" class="btn btn-primary">등록</button>
			      <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/movie/select.do'">취소</button>
			    </div>
			  </div>
			</form>
			</div>
		</div>
	</section>
	<%@ include file="/common/footer.jsp" %>
	<script type="text/javascript">
		var filesize=0;
		var filetype="";
		
		// 파일 용량 체크
		function bytesToSize(bytes) {
			var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
			if (bytes == 0) return '0 Byte';
			var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
			return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
		};

		// 파일사이즈 체크
		$('#m_file').bind('change', function() {
			filesize=this.files[0].size;
			filesize=bytesToSize(filesize);
			var point=this.files[0].name.lastIndexOf('.');
			filetype=this.files[0].name.substring(point+1,this.lenght).toLowerCase();
			console.log(filesize);
			$('#filesize').text("("+filesize +")");
			if(filetype != 'gif' && filetype != 'jpg' && filetype != 'jpeg' && filetype != 'png'){
				$('img').hide();
				$('#filetype').show();
			}else{
				$('img').show();
				$('#filetype').hide();
			}
			setTimeout(function() {setHeight()}, 0);
	    });
		
		function check() {	
		 var num_check=/^[0-9]*$/;//정규표현식 숫자만
		 var url_check=/(http(s?))\:\/\/www.youtube.com\/embed\/([a-zA-Z0-9-_]{11})/;//youtube체크
		 var m_kind_count=0;//장르수 체크	
		 console.log("장르수:"+movieForm.m_kind.length);
		 for(var i=0; i<movieForm.m_kind.length; i++){
			  if(movieForm.m_kind[i].checked == true) {
				  m_kind_count++;
			}		
		 }
		 console.log("장르체크:"+m_kind_count);
		 console.log("숫자여부:"+num_check.test(movieForm.m_count.value));
		  if(movieForm.m_title.value == "") {
		    alert("제목을 입력해주세요.");
		    movieForm.m_title.focus();
		    return false;
		  } 
		  else if(m_kind_count == 0) {
		    alert("장르를 하나 이상 체크해주세요.");
		    movieForm.m_kind2.focus();
		    return false;
		  }
		  else if(!num_check.test(movieForm.m_count.value)){
			alert("숫자만 가능합니다.");
			movieForm.m_count.focus();
		    return false;
		  }
		  else if(movieForm.m_count.value == "") {
		    alert("관객수를 입력해주세요.");
		    movieForm.m_count.focus();
		    return false;
		  }
		  else if(!url_check.test(movieForm.m_youtube.value)) {
		    alert("링크 형식이 잘못되었습니다.\n예시)https://www.youtube.com/embed/(코드값11자리)");
		    movieForm.m_youtube.focus();
		    return false;
		  }
		  else if(movieForm.m_youtube.value == "") {
		    alert("동영상 링크 주소를 넣어주세요.");
		    movieForm.m_youtube.focus();
		    return false;
		  }
		  else if(movieForm.m_contents.value == "") {
		    alert("줄거리를 입력해주세요.");
		    movieForm.m_contents.focus();
		    return false;
		  }
		  else if(filesize > 5 ) {
		    alert("파일 사이즈가 5MB를 넘었습니다.");
		    movieForm.m_file.focus();
		    return false;
		  }
		  else if(filetype == '' || filetype == null){
		    alert("포스터이미지를 넣어주세요.");
		    movieForm.m_file.focus();
		    return false;
		  }
		  else if(filetype != 'gif' && filetype != 'jpg' && filetype != 'jpeg' && filetype != 'png'){
			console.log("파일타입"+filetype);
		    alert("업로드 할 수 없는 파일입니다.");
		    movieForm.m_file.focus();
		    return false;
		  }
		  else return true;
		}
		
		//이미지 미리보기
		$(function() {
            $("#m_file").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#preImage').attr('src', e.target.result);
                }
              reader.readAsDataURL(input.files[0]);
            }
        }
	</script>
	<script type="text/javascript">
    $(function () {
    	/* $('#m_date').daterangepicker({
    	    "startDate": "11/16/2016",
    	    "endDate": "11/16/2016"
    	}, function(start, end, label) {
    	  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
    	}); */
    	
    	$('#m_date').daterangepicker({
    	    "locale": {
    	        "format": "YYYY/MM/DD",
    	        "separator": " - ",
    	        "applyLabel": "완료",
    	        "cancelLabel": "취소",
    	        "fromLabel": "상영시작",
    	        "toLabel": "상영종료",
    	        "customRangeLabel": "Custom",
    	        "weekLabel": "W",
    	        "daysOfWeek": [
    	            "일","월","화","수","목", "금","토"
    	        ],
    	        "monthNames": [
    	            "1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"
    	        ],
    	        "firstDay": 1
    	    },
    	    "startDate": "2016/11/16",
    	    "endDate": "2016/11/30"
    	}, function(start, end, label) {
    	  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
    	});
    });
</script>
</body>
</html>