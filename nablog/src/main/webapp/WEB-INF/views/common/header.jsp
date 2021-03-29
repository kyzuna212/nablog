<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="main" value="${main}"/>	
<c:set var="menuMainList" value="${menuMainList}"/>	
<c:set var="menuList" value="${menuList}"/>	
<c:set var="menu" value="${menu}"/>
<c:set var="boardList" value="${boardList}"/>
<c:set var="recentList" value="${recentList}"/>
<c:set var="popularList" value="${popularList}"/>
<c:set var="tagList" value="${tagList}"/>
<c:set var="pagingList" value="${pagingList}"/>
<c:set var="pg" value="${pg}"/>
<c:set var="menuCateNo" value="${menuCateNo}"/>

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
							<a href="javascript:void(0);" onclick="goCateList(${no.menuCateNo});">${no.menuTit}(${fn:length(menuMainList)})</a>
							<img src="resources/images/icons8-plus.png" id="img_${index.index+1}" onclick="showSubHide(${index.index+1});">
							
							<ul class="sub_hide" id="sub_hide_${index.index+1}">
								<c:forEach var="subno" items="${menuList}">
									
									<c:if test="${subno.menuCateRef eq no.menuCateNo }">
										<li class="${subno.menuCateNo}">
											<a href="javascript:void(0);" onclick="goCateList(${subno.menuCateNo});">${subno.menuTit}(${fn:length(menuList)})</a>
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
				<a href="${pageContext.servletContext.contextPath}/about.do"
					class="about">about me</a>

				<a href="${pageContext.servletContext.contextPath}/mlogin.do" class="contact">admin</a>  
			</div>
				
				<div class="search">
				<form action="${pageContext.servletContext.contextPath}/search.do?" id="form">
				<input type="text" class="input_text" name="search" value=""  placeholder="검색내용을 입력하세요" onfocus="this.placeholder=''" 
					onblur="this.placeholder='검색내용을 입력하세요'">
					<input type="hidden" name="menuCateNo" value="${menu.menuCateNo}">
					<input type="hidden" name="pg" value="1">
				<button type="button" onclick="showText();">
					<img src="resources/images/icons8-search.png" alt="검색">
				</button>
				</form>


				
			</div>

		</div>

	</div>


	<script> 
    // 실행 순서 (java-jstl-html-javascript)
   
		$(document).ready(function() {
			//input박스 숨기기
			$("input.input_text").hide();
			//카테고리 하위 메뉴 숨기기
			$(".sub_hide").hide();
			//왼쪽 사이드바 숨기기
			$(".left_side_bar").hide();
			
			//저장된 메뉴 상태로 보여지기
			if(sessionStorage.length > 0){
				
				for(var i =0; i<sessionStorage.length; i++){
					$('#sub_hide_' + sessionStorage.key(i) ).show();
					$('#img_'+ sessionStorage.key(i) ).attr("src", "resources/images/icons8-minus.png");
				}
				openMenu();
				
			}
			
			// menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
			$(".menu>a").click(function() {
				$(this).next("ul").slideToggle(); // slideUp/Down 기능 모두 포함 */
					
			});
		  
		});
		
		//왼쪽 카테고리 오픈 
		function openMenu(){
			 $(".menu>a").next("ul").show();
		}
		
		//돋보기 사진 클릭시, 검색 박스 보이기
		function showText() {

			$("input.input_text").fadeIn();
			 if( $(".input_text").val() !=''){
				
				 $('#form').submit();
			}

		}

		//+클릭시  하위 메뉴 나오기	
		function showSubHide(seq) {
		
			var subhide = $('#sub_hide_' + seq);

			
			if (subhide.is(":visible")) {

				subhide.slideUp(); // subhide 가 화면상에 보일때는 위로 부드럽게 접고 아니면 아래로 부드럽게 펼치기
				$('#img_'+seq).attr("src", "resources/images/icons8-plus.png");

				//세션 스토리지에 메뉴 상태 저장
				if(sessionStorage.getItem(seq)!=null){
					sessionStorage.removeItem(seq);
				}
				
			} else {

				subhide.slideDown();
				$('#img_'+seq).attr("src", "resources/images/icons8-minus.png");
				
				//세션 스토리지에 메뉴 상태 저장
				if(sessionStorage.getItem(seq)==null){
					sessionStorage.setItem(seq,seq);
				}
			
			}
			

		}
			
		 //카테고리의 첫번째 목록페이지로 이동
	     function goCateList(CateNo){     	
	     	location.href="${pageContext.servletContext.contextPath}/list.do?menuCateNo="+CateNo+"&pg=1"; 
	     }


	</script>
</header>


</html>