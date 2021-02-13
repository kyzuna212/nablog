<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="UTF-8"> -->
<!-- 디자인  -->
<%-- <c:import url="/WEB-INF/views/common/meta.jsp" /> --%>
<!-- 헤더 -->
<%-- <c:import url="/WEB-INF/views/common/header.jsp" /> --%>
</head>
<body>
	<div class="sidebar">
		<div class="left_side">
			<h2>
				<a href="javascript:changeMenu(1);" class="recent">최근글</a>
				<a href="javascript:changeMenu(2);" class="popular">인기글</a>
			</h2>
			<div id="recent" class="tab-list" style="display: block;"> 

				<ul>

					<li>
						<a href="#">
					 		<img src="#" alt=""> 
					 		<span class="title">최근에 쓰여진 글의 제목 첫번째</span> 
					 		<span class="date">2020.08.13</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<span class="title">최근에 쓰여진 글의 제목 두번째</span> 
							<span class="date">2020.05.22</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<span class="title">최근에 쓰여진 글의 제목 세번째</span> 
							<span class="date">2020.04.27</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<img src="#" alt=""> 
							<span class="title">최근에 쓰여진 글의 제목 네번째</span> 
							<span class="date">2020.04.22</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<span class="title">최근에 쓰여진 글의 제목 다섯번째</span> 
							<span class="date">2020.04.22</span>
						</a>
					</li>

				</ul>
			</div>
			<div id="popular" class="tab-list" style="display: none;">

				<ul>

					<li>
						<a href="#"> 
							<span class="title">인기글 첫번째 제목</span> 
							<span class="date">2019.09.17</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<span class="title">인기글 두번째 제목</span> 
							<span class="date">2019.11.13</span>
						</a>
					</li>

					<li>
						<a href="#"> 
							<img src="#" alt=""> 
							<span class="title">인기글 세번째 제목</span> 
							<span class="date">2019.08.09</span>
						</a>
					</li>

					<li>
						<a href="#"> 
							<img src="#" alt=""> 
							<span class="title">인기글 네번째 제목</span> 
							<span class="date">2019.09.30</span>
						</a>
					</li>


					<li>
						<a href="#"> 
							<span class="title">인기글 다섯번째 제목</span> 
							<span class="date">2020.01.01</span>
						</a>
					</li>

				</ul>
			</div>
			<div class="tags">
				<h2>태그</h2>
					<div class="tag_a">
						<a href="#">개발자</a> <a href="#">웹개발</a> <a href="#">스프링</a> <a
						href="#">java</a> <a href="#">javascript</a>
					</div>
			</div>
 		</div> 
	</div>
	<script type="text/javascript">
	//최근글, 인기글 tap이동
	function changeMenu(seq) {
			
			if(seq==1){
	
					$("#recent").css("display","block");
					$("#popular").css("display","none");
					$(".popular").css("color","#333333a1");
					$(".recent").css("color","#333");	

			}else{
			
					$("#popular").css("display","block");
					$("#recent").css("display","none");
					$(".recent").css("color","#333333a1");	
					$(".popular").css("color","#333");

			}
		}


	</script>
</body>
</html>