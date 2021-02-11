<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<header id="header">
		<div class="header">
			<h1 class="logo">
				<a href="${ pageContext.servletContext.contextPath}/main.do">
					<img src="resources/images/title_001.png"> </a><!-- 나츠키's 개발 블로그 -->
			</h1>
			<div class="util">
				<div class="menu">
					<button type="button">
						<img src="resources/images/icons8-menu.png" alt="카테고리">
					</button>
				</div>

				<div class="right_menubar">
					<a href="${ pageContext.servletContext.contextPath}/about.do" class="about">about me</a> 
				<%-- 	<a href="${ pageContext.servletContext.contextPath}/contact.do" class="contact">contact me</a> --%>
				</div>

				<div class="search">

					<!-- <input type="text" name="search" value=""  placeholder="검색내용을 입력하세요  onkeypress="#"> -->
					<button type="submit" onclick="#">
						<img src="resources/images/icons8-search.png" alt="검색">
					</button>

				</div>

			</div>

		</div>
	<div class="sub_bg"></div> 
	</header>

</html>