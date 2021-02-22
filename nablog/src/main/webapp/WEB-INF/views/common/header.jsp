<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="main" value="${main}"/>	
<c:set var="menuMainList" value="${menuMainList}"/>	
<c:set var="menuList" value="${menuList}"/>	
<c:set var="menu" value="${menu}"/>
<c:set var="boardList" value="${boardList}"/>
<c:set var="recentList" value="${recentList}"/>
<c:set var="popularList" value="${popularList}"/>

<!DOCTYPE html>
<html>

<header id="header">
	<div class="header">
		<h1 class="logo">
			<a href="${ pageContext.servletContext.contextPath}/main.do"> <img
				src="resources/images/title_001.png">
			</a>
			<!-- 나츠키's 개발 블로그 -->
		</h1>
		<div class="util">
			<div class="menu">
				<a> <img src="resources/images/icons8-menu.png" alt="카테고리"></a>
			<!-- 	<div class="hide_wrap"> -->
				<ul class="hide">
					
					<c:forEach var="no" items="${menuMainList}" varStatus="index">

						<li>
							<a href="${pageContext.servletContext.contextPath}/list.do?menuCateNo=${no.menuCateNo}">${no.menuTit}(10)</a>
							<img src="resources/images/icons8-plus.png" id="img_${index.index+1}" onclick="showSubHide(${index.index+1});">
							
							<ul class="sub_hide" id="sub_hide_${index.index+1}">
								<c:forEach var="subno" items="${menuList}">
									
									<c:if test="${subno.menuCateRef eq no.menuCateNo }">
										<li class="${subno.menuCateNo}">
											<a href="${pageContext.servletContext.contextPath}/list.do?menuCateNo=${subno.menuCateNo}">${subno.menuTit}(7)</a>
										</li>
									</c:if>
								
								</c:forEach>
								
							</ul>
							
						</li>
				
					</c:forEach>
					

				</ul>
				
				
				<div class="left_side_bar">
				<c:import url="/WEB-INF/views/common/leftSideBar.jsp" />
				</div>
			
				
			</div>

			<div class="right_menubar">
				<a href="${ pageContext.servletContext.contextPath}/about.do"
					class="about">about me</a>

			<%-- 	<a href="${ pageContext.servletContext.contextPath}/mlogin.do" class="contact">admin</a>  --%>
			</div>
				
			<div class="search">
				<form action="#">
				<input type="text" class="input_text" name="search" value=""  placeholder="검색내용을 입력하세요" onfocus="this.placeholder=''" 
					onblur="this.placeholder='검색내용을 입력하세요'">
				<button type="submit" onclick="showText();">
					<img src="resources/images/icons8-search.png" alt="검색">
				</button>
				</form>

			</div>

		</div>

	</div>


	<script> 
    // 실행 순서 (java-jstl-html-javascript)
	
   /*  var statusShow = "";
    var statusHide = ""; */
    
		$(document).ready(function() {
			//input박스 숨기기
			$("input.input_text").hide();
			//카테고리 하위 메뉴 숨기기
			$(".sub_hide").hide();
			//왼쪽 사이드바 숨기기
			$(".left_side_bar").hide();
			
			//메인 페이지 일때만 다음 기능이 실행 되도록 한다 (다른 페이지에서는 목록은 계속 보여진 채로)
		//	var main = '<c:out value="${main}"/>';

		/* 	if (main == 'main') { */
				
				// menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
				$(".menu>a").click(function() {
					 $(this).next("ul").slideToggle(); // slideUp/Down 기능 모두 포함 */
					
					 /*  $(this).next("ul").slideToggle();
					var menu =  $(this).next("ul");
					 
					// subhide 가 화면상에 보일때는 위로 부드럽게 접고 아니면 아래로 부드럽게 펼치기
						if (menu.is(":visible")) {

							menu.slideUp();
							

						} else {
							
							menu.slideDown();
							
						} */
						
				
				});
		/* 	} */

		});
		
		//돋보기 사진 클릭시, 검색 박스 보이기
		function showText() {

			$("input.input_text").fadeIn();
			if( (".input_text").val() !=''){
				
			}

		}

		//+클릭시  하위 메뉴 나오기	
		function showSubHide(seq) {
		
			var subhide = $('#sub_hide_' + seq);

			// subhide 가 화면상에 보일때는 위로 부드럽게 접고 아니면 아래로 부드럽게 펼치기
			if (subhide.is(":visible")) {

				subhide.slideUp();
				$('#img_'+seq).attr("src", "resources/images/icons8-plus.png");
				/* statusHide = seq ; */

			} else {

				subhide.slideDown();
				$('#img_'+seq).attr("src", "resources/images/icons8-minus.png");
				/* statusShow = seq; */
			
			}
			

		}
		
		//쿠기 생성
		function setCookie("menuStatus", value, 1) {  //변수 , 변수값,저장기간
		    
		}


		

	</script>
</header>


</html>