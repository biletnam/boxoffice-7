<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="paging">
	<ul class="pagination">
	<li>
	  <a href="${search}${startPage}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>  
	<c:if test="${endPage > pageCount}">
		<c:set value="${endPage = pageCount}" var="endPage"/>
	</c:if>
	<c:if test="${startPage > pageBlock}">
		 <li><a href="${search}${startPage-1}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}"> 
		<c:choose>
			<c:when test="${pageNum == i}">
				<li class="active"><a href="#">${i}<span class="sr-only">(current)</span></a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${search}${i}">${i}<span class="sr-only">(current)</span></a></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<li><a href="${search}${startPage + pageBlock}">다음</a></li>
	</c:if>
	
	<li>
      <a href="${search}${endPage}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
	</ul>
</nav>	