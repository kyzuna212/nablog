<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header id="header">
	<div class="header">
		<h1>
			<a href="#"> 나츠키의 개발 블로그 </a>
		</h1>
		<div class="util">
			<div class="search">

				<input type="text" name="search" value=""  onkeypress="#"> <!-- placeholder="검색내용을 입력하세요" -->
				<button type="submit" onclick="#">검색</button>

			</div>
			
			<div class="profile">
				<button type="button">
					<img src="#" alt="블로그 이미지">
				</button>
				<nav>
					<ul>
						<li><a href="#">관리</a></li>
						<li><a href="#">글쓰기</a></li>
						<li class="login"><a href="#">로그인</a></li>
						<li class="logout" style="display: none;"><a href="#">로그아웃</a></li>
					</ul>
				</nav>
			</div>
			<button type="button" class="menu">
				<span>메뉴</span>
			</button>
		</div>
		
		<nav id="gnb">
			<ul style="width: 570px;">
				<li class="t_menu_home first current"><a href="#">홈</a></li>
				<li class="t_menu_page"><a href="#">카테로그1</a></li>
				<li class="t_menu_link_1"><a href="#">카테로그2</a></li>
				<li class="t_menu_page last"><a href="#">카테로그3</a></li>
			</ul>
		</nav>
	</div>

</header>
</body>
</html>