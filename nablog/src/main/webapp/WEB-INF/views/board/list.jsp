<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나츠키's 블로그</title>

<!-- 디자인  -->
<c:import url="/WEB-INF/views/common/meta.jsp" />
<!-- 헤더 -->
<c:import url="/WEB-INF/views/common/header.jsp" /> 

</head>
<body>

	<div id="all_wrap">

		<!-- 콘텐츠 -->
		<div id="mainbody">
			<article id="content">

				<div class="post-header">
					<h1>
						<span>${menu.menuTit eq null ? '전체' : menu.menuTit}</span><em>${fn:length(boardList)}</em> 
						<a href="${pageContext.servletContext.contextPath}/edit.do">글쓰기</a>
					</h1>
				</div>
				<!-- 한 페이지에 썸네일 9개씩  -->
		
				<c:forEach var="board" items="${boardList}" begin="0" end="${pagingList.pgSize-1}" >
					<div class="post-item" >
						<a href="${pageContext.servletContext.contextPath}/detail.do?bno=${board.bno}"> 
							<span class="thum"> 
								<img src="#" alt="">
							</span> 
							<span class="title">${board.bTitle}</span> 
							<span class="excerpt">${board.bCnt}</span> 
							<span class="meta"> 
								<span class="date">${board.bDate}</span>
							</span>
						</a>
					</div>
				</c:forEach>


				<div class="pagination">
					<c:if test="${pagingList.prev}">
						<a class="prev no-more-prev">이전</a>  <a><span class="selected">이전</span></a> 
					</c:if>
					<c:forEach  varStatus="num"  begin="${pagingList.startPage}" end="${pagingList.endPage}">
						<a href="#"><span>${num.index}</span></a>
					<%-- 	<a href="#"><span>${pagingList.startPage}</span></a>
						<a href="#"><span>${pagingList.endPage}</span></a> --%>
						 
					</c:forEach>
					<c:if test="${pagingList.next}">	
						<a href="#" class="next ">다음</a> <%-- <a><span class="selected">${pagingList.next}</span></a> --%>
					</c:if>
				 </div>

			</article>
		</div>


	</div>
	<script> 
   
     $(document).ready(function(){
    	//main페이지를 제외한 나머지 페이지에서는 목록을 항상 보이게 한다
    /* 	$(".sub_hide").show();*/
    	$(".hide").show(); 
    	$(".left_side_bar").show();
    	
/* 	if(statusHide !=''){
		
	}
	
	if(statusShow !=''){
		console.log(statusShow);
		$(".sub_hide_"+statusShow).show();
	} */

    });
     function goList(){
    	// ${pageContext.servletContext.contextPath}/list.do?menuCateNo=${menuCateNo}&pg=${pg}
     }
    </script>

<!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>