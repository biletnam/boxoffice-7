<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/docType.jspf" %>
<html>
<head>
	<title>insertNoticeForm - BoxOffice</title>
	<%@ include file="/common/common.jspf" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/smart_editor/js/HuskyEZCreator.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/smart_editor/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"></script>
	<script type="text/javascript">
		var oEditors = [];
		$(function(){
		      nhn.husky.EZCreator.createInIFrame({
		          oAppRef: oEditors,
		          elPlaceHolder: "n_contents", //textarea에서 지정한 id와 일치해야 합니다. 
		          //SmartEditor2Skin.html 파일이 존재하는 경로
		          sSkinURI: "${pageContext.request.contextPath}/smart_editor/SmartEditor2Skin.html",  
		          htParams : {
		              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseToolbar : true,             
		              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseVerticalResizer : true,     
		              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseModeChanger : true,         
		              fOnBeforeUnload : function(){
		                   
		              }
		          }, 
		          fOnAppLoad : function(){
		              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
		              //oEditors.getById["n_contents"].exec("PASTE_HTML", []);
		          },
		          fCreator: "createSEditor2"
		      });
		});
		
		//textArea에 이미지 첨부
		function pasteHTML(filepath){
		    var sHTML = '<img src="${pageContext.request.contextPath}/saveFile/'+filepath+'">';
		    oEditors.getById["n_contents"].exec("PASTE_HTML", [sHTML]);
		}
	 
	</script>
</head>
<body>
	<jsp:include page="/common/menu.jsp"/>
	<section>
		<div class="container">
			<div class="center">
			<h2>공지사항 등록</h2>
			<form action="${pageContext.request.contextPath}/notice/insert.do" class="form-horizontal" 
			method="post" enctype="multipart/form-data" name="noticeForm" onsubmit="return check();">
			  <div class="form-group">
			    <label for="n_title" class="col-sm-2 control-label">제목</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="n_title" name="n_title">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="n_contents" class="col-sm-2 control-label">내용</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="15" id="n_contents" name="n_contents"></textarea>	
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="n_file" class="col-sm-2 control-label">파일 업로드</label>
			    <div class="col-sm-10">
			    	<input type="file" id="n_file" name="n_file">
			    	<p class="help-block">파일업로드크기:최대 5Mb <span id="filesize" style="color:red;"></span></p>
			    	<img id="preImage" src="${pageContext.request.contextPath}/saveFile/${noticeVO.n_file}" style="max-width:700px;" alt="your image" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
			    </div>
			  </div>
			  <div class="btn_area">
			    <div class="fr">
			      <button type="submit" class="btn btn-primary">등록</button>
			      <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/notice/select.do'">취소</button>
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
		$('#n_file').bind('change', function() {
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
			console.log("파일체크"+filetype);
		  //에디터의 내용이 textarea에 적용
		  oEditors.getById["n_contents"].exec("UPDATE_CONTENTS_FIELD", []);
		  if(noticeForm.n_title.value == "") {
		    alert("값을 입력해 주세요.");
		    noticeForm.n_title.focus();
		    return false;
		  }
		  else if(noticeForm.n_contents.value == "") {
		    alert("값을 입력해 주세요.");
		    noticeForm.n_contents.focus();
		    return false;
		  }
		  else if(filesize > 5 ) {
		    alert("파일 사이즈가 5MB를 넘었습니다.");
		    noticeForm.n_file.focus();
		    return false;
		  }
		  else if(filetype != 'gif' && filetype != 'jpg' && filetype != 'jpeg' && filetype != 'png' && filetype != 'pdf' && filetype != 'hwp' && filetype != "" && filetype != null ){
			console.log("파일타입"+filetype);
		    alert("업로드 할 수 없는 파일입니다.");
		    noticeForm.n_file.focus();
		    return false;
		  }
		  else return true;
		}
		
		//이미지 미리보기
		$(function() {
            $("#n_file").on('change', function(){
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
</body>
</html>