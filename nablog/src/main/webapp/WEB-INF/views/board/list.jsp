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
						<a href="javascript:void(0)" onclick="goWrite();">글쓰기</a>
					</h1>
				</div>
				<!-- 한 페이지에 썸네일 9개씩  -->
				<c:if test="${!empty boardList}">
					<c:forEach var="board" items="${boardList}" begin="0" end="${pagingList.pgSize-1}" >
						<div class="post-item" >
							<a href="javascript:void(0);" onclick="goView(${board.bno})"> 
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
				</c:if>
				
				<c:if test="${empty boardList}">
					<hr>
						<span class="no_data">게시물이 없습니다</span>
					<hr>
				</c:if>

				<c:if test="${pagingList.totalSize >0}">
					<div class="pagination">
						<c:if test="${pagingList.prev}"> 
							<a href="javascript:void(0);" onclick="goList(${pagingList.startPage-1});" class="prev"><img src="resources/images/icons8-back.png"></a> 
						</c:if> 
						<c:forEach  varStatus="num"  begin="${pagingList.startPage}" end="${pagingList.endPage}">
							<c:if test="${num.index eq pagingList.pg}">
								<a href="javascript:void(0);" onclick="goList(${num.index});"><span class="on">${num.index}</span></a>
							</c:if>
							<c:if test="${num.index ne pagingList.pg}">
								<a href="javascript:void(0);" onclick="goList(${num.index});"><span>${num.index}</span></a>
							</c:if>										 
						</c:forEach>
						<c:if test="${pagingList.next}">
							<a href="javascript:void(0);" onclick="goList(${pagingList.endPage+1});" class="next"><img src="resources/images/icons8-next.png"></a> <%-- <a><span class="selected">${pagingList.next}</span></a> --%>
						</c:if>
					 </div>
				 </c:if>

			</article>
		</div>


	</div>
<script type="text/javascript">
   
     $(document).ready(function(){

    	$(".hide").show(); 
    	$(".left_side_bar").show();
    	       
    });
   
     //목록 이동
     function goList(pg){ 
     	location.href="${pageContext.servletContext.contextPath}/list.do?menuCateNo=${menu.menuCateNo}&pg=" + pg; 
     }
     
     //상세페이지 이동
	 function goView(bno){
    	location.href="${pageContext.servletContext.contextPath}/detail.do?menuCateNo=${menu.menuCateNo}&bno=" + bno;
     }
     
     //글쓰기 페이지로 이동
     function goWrite(){
    	 location.href="${pageContext.servletContext.contextPath}/edit.do?menuCateNo=${menu.menuCateNo eq null ? 1 :menu.menuCateNo}"
     }
     
    </script>

<!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>