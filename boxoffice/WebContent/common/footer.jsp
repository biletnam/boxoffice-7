<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
	<div>
		<div class="container">
			Copyright 2016. BoxOffice all rights reserved.
			<ul class="share">
				<li><a href="#none" id="kakao">카카오톡 공유하기</a></li>
				<li><a href="#none" id="facebook">페이스북 공유하기</a></li>
				<li><a href="#none" id="twitter">트위터 공유하기</a></li>
			</ul>
		</div>
	</div>

	<!-- <button type="button" class="btn btn-default" title="이전페이지" id="back">
	  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	</button> -->
	<button type="button" class="btn btn-default" title="위로가기" id="top">
	  <span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
	</button>
</footer>
<script type='text/javascript'>
	var snsSiteAddr = document.getElementsByTagName('META')[0].content;
	var siteTitle = document.getElementsByTagName('META')[1].content;
	var siteDescription = document.getElementsByTagName('META')[2].content;
	var siteImage = document.getElementsByTagName('META')[3].content;
	var snsSiteNm = siteTitle+"/ "+siteDescription;

  //<![CDATA[
    // // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('4e359b835a9784c10075f5010fd063b5');
    // // 카카오톡 링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
    Kakao.Link.createTalkLinkButton({
      container: '#kakao',
      label: siteDescription,
      image: {
        src: siteImage,
        width: '100',
        height: '100'
      },
      webButton: {
        text: 'BoxOffice 공유하기',
        url: snsSiteAddr // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
      }
    });
    
    $(function(){
		/* 페이스북  */
		$('#facebook').click(function(){
			$.clickBtnSnsFacebook(snsSiteAddr, snsSiteNm);
			return false;});
		
		$.clickBtnSnsFacebook=function(strUrl,strTitle,strText){
			if(!strText) strText=strTitle;
			window.open('http://facebook.com/sharer/sharer.php?u='+encodeURIComponent(strUrl),'facebook','width=200,height=200');
			return false;
		};
		
		/* 트위터 */
		$('#twitter').click(function(){
			$.clickBtnSnsTwitter(snsSiteAddr, snsSiteNm);
			return false;});

		$.clickBtnSnsTwitter=function(strUrl,strText){
			window.open('http://twitter.com/home?status='+encodeURIComponent(strText)+' '+encodeURIComponent(strUrl),'_blank');
			return false;
		};
    });
    
  //]]>
</script>
<script>
	/* top */
	$("#top").click(function() {
		$("html, body").scrollTop(0);
		return false;
	})
	$(window).scroll(function() {
		var height = $(document).scrollTop();
		if (height > 100) {
			$('#top').addClass('on');
		} else {
			$('#top').removeClass('on');
		}
	});
	$("#back").click(function() {
		history.back();
	});
</script>