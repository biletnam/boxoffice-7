<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>selectBanner - BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section class="container">
		<div class="center">
			<h2>배너 목록</h2>
			<form action="${pageContext.request.contextPath}/banner/select.do" method="post" name="bannerDel">
				<input type="hidden" name="banner_id"> 
			</form>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>No</th>
						<th>배너이름</th>
						<th>파일이름</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.banner_id}</td>
						<td>${list.banner_name}</td>
						<td>${list.banner_file}</td>
						<td>
							<button type="button" onclick="banner_del('${list.banner_id}');">					
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
							</button>
						</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
			<div class="box1">
				<form action="${pageContext.request.contextPath}/banner/insert.do" 
				name="BannerForm" class="form-horizontal" method="post" enctype="multipart/form-data" onsubmit="return check();">
				  <div class="form-group">
				    <label for="banner_name" class="col-sm-2 control-label">name</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="banner_name" name="banner_name" placeholder="배너이름">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="banner_file" class="col-sm-2 control-label">파일 업로드</label>
				    <div class="col-sm-10">
				    	<input type="file" id="banner_file" name="banner_file">
				    	<p class="help-block">파일업로드크기:최대 5Mb <span id="filesize" style="color:red;"></span></p>
				    	<img id="preImage" src="${pageContext.request.contextPath}/saveFile/${bannerVO.banner_file}" style="max-width:700px;" alt="your image" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="submit" class="btn btn-default">배너등록</button>
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
		$('#banner_file').bind('change', function() {
			filesize=this.files[0].size;
			filesize=bytesToSize(filesize);
			var point=this.files[0].name.lastIndexOf('.');
			filetype=this.files[0].name.substring(point+1,this.lenght).toLowerCase();
			console.log(filesize);
			$('#filesize').text("("+filesize +")");
			if(filetype != 'gif' && filetype != 'jpg' && filetype != 'jpeg' && filetype != 'png'){
				$('img').hide();
			}else{
				$('img').show();
			}
			setTimeout(function() {setHeight()}, 0);
	    });
		
		function check() {
		  console.log("파일체크"+filetype);
		  
		  if(BannerForm.banner_name.value == "") {
		    alert("값을 입력해 주세요.");
		    BannerForm.banner_name.focus();
		    return false;
		  }
		  else if(filesize > 5 ) {
		    alert("파일 사이즈가 5MB를 넘었습니다.");
		    BannerForm.banner_file.focus();
		    return false;
		  }
		  else if(filetype != 'gif' && filetype != 'jpg' && filetype != 'jpeg' && filetype != 'png' && filetype != "" && filetype != null ){
			console.log("파일타입"+filetype);
		    alert("업로드 할 수 없는 파일입니다.");
		    BannerForm.banner_file.focus();
		    return false;
		  }
		  else return true;
		}
		
		//이미지 미리보기
		$(function() {
            $("#banner_file").on('change', function(){
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
        
        function banner_del(id){
        	bannerDel.banner_id.value=id;
        	bannerDel.submit();
        }
	</script>
</body>
</html>