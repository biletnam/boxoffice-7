<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>네이버로그인-콜백</title>
<%@ include file="/common/common.jspf" %>
</head>
<body>
	<div id="naver_id_login" style="display: none"></div>
	<!-- 네이버아디디로로그인 초기화 Script -->
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("${naverID}", "${root}/callback.do");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("green", 3, 30);
		naver_id_login.setDomain("${root}");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
	<!-- 네이버아디디로로그인 Callback페이지 처리 Script -->
	<script type="text/javascript">
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
            location.href = "${root}/naverLogin.do?state=".concat(naver_id_login.getAccessToken(),
		            		"&email=",naver_id_login.getProfileData('email'),
		            		"&nickname=",naver_id_login.getProfileData('nickname'),
		            		"&age=",naver_id_login.getProfileData('age'));
		}
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
	</script>
</body>
</html>