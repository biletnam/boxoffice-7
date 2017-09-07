function setHeight() {
	$("section .center").css("height", "");
	console.log("리사이징");
	var headerH = $("header").height();
	var sectionH = $("section").height()+20;
	var footerH = $("footer").height();
	var bodyH=headerH + sectionH + footerH;
	var sectionHeight = window.innerHeight - headerH - footerH - 20;
	console.log(innerHeight+":"+bodyH);
	if (innerHeight >= bodyH) {
		$("section .center").css("height", sectionHeight);
	} else {
		$("section .center").css("height", "");
	}
}
$(document).ready(function() {
	setTimeout(function() {setHeight()}, 0);
});
window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", setHeight, false);