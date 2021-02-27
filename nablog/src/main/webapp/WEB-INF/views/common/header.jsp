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
<c:set var="tagList" value="${tagList}"/>
<c:set var="pagingList" value="${pagingList}"/>

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
				<form action="/search.do" id="form">
				<input type="text" class="input_text" name="search" value=""  placeholder="검색내용을 입력하세요" onfocus="this.placeholder=''" 
					onblur="this.placeholder='검색내용을 입력하세요'">
					<input type="hidden" name="menuCateNo" value="${menu.menuCateNo}">
				<button type="button" onclick="showText();">
					<img src="resources/images/icons8-search.png" alt="검색">
				</button>
				</form>


				
			</div>

		</div>

	</div>


	<script> 
    // 실행 순서 (java-jstl-html-javascript)
	
    //메뉴 상태 저장을 위한 전역변수 배열 생성
   var statusArr = [];
    
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
 		
				  //메인페이지 아니라면 저장된 메뉴 상태 정보 적용할 것 
				/* if (main != 'main') {  */
				/*	 if(statusArr.length>0){
						for(int i=0 ; i<statusArr.length ; i++){
						//	var subhidestatus = $('#sub_hide_' + statusArr[i]);
						//	console.log(statusArr[i]);
							document.write(statusArr[i]+"<br>");
						}
					} 
					
					
			/* 	}  */
		
			
		
		/* 	} */
		  
		});
		
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
			//	status =status.replace(seq,""); //해당 seq가 포함되어 있다면 제거
			//	statusArr.splice(seq-1,1);
			//	statusArr[seq-1] = 0 ;
				statusArr = statusArr.filter((element) => element !== seq);
				console.log("쿠키 status에 저장된 값: "+statusArr);

			} else {

				subhide.slideDown();
				$('#img_'+seq).attr("src", "resources/images/icons8-minus.png");
				statusArr.push(seq);
				//	statusArr.splice(seq,0,seq);
				//	statusArr[seq] = seq ;
			//	status += seq;
				console.log("쿠키 status에 저장된 값: "+statusArr);
			
			}
			

		}
		
		//메뉴상태 저장을 위한 쿠키 생성
		var setCookie = function(name, value, exp) {
			var date = new Date();
			date.setTime(date.getTime() + exp*24*60*60*1000);
			document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
			};

		
		setCookie("status", status, 1); // setCookie(변수이름, 변수값, 기간);
		
		var getCookie = function(name) {
			var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
			return value? value[2] : null;
			};

		
		var status = getCookie("status"); // getCookie(변수이름)
		console.log("쿠키 status에 저장된 값: "+status);




		

	</script>
</header>


</html>