<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<ul class="hide">
					<li>메뉴 메인카테고리1 (10)<img src="resources/images/icons8-plus.png" onclick="showSubHide(1);">
						<ul class="sub_hide" id="sub_hide_1">
							<li>카테고리1-1 (7)</li>
							<li>카테고리1-2 (5)</li>
							<li>카테고리1-3 (8)</li>
						</ul>
					</li>
					<li>메뉴 메인카테고리2 (2)<img src="resources/images/icons8-plus.png"  onclick="showSubHide(2);">
						<ul class="sub_hide" id="sub_hide_2">
							<li>카테고리2-1 (1)</li>
							<li>카테고리2-2 (2)</li>
							<li>카테고리2-3 (3)</li>
						</ul>
					</li>
					<li>메뉴 메인카테고리3 (3)<img src="resources/images/icons8-plus.png"  onclick="showSubHide(3);">
						<ul class="sub_hide" id="sub_hide_3">
							<li>카테고리3-1 (4)</li>
							<li>카테고리3-2 (5)</li>
							<li>카테고리3-3 (6)</li>
						</ul>
					</li>
				</ul>
				
			</div>

			<div class="right_menubar">
				<a href="${ pageContext.servletContext.contextPath}/about.do"
					class="about">about me</a>

				<%-- 	<a href="${ pageContext.servletContext.contextPath}/contact.do" class="contact">contact me</a> --%>
			</div>
				
			<div class="search">

				<input type="text" class="input_text" name="search" value=""  placeholder="검색내용을 입력하세요" onfocus="this.placeholder=''" 
					onblur="this.placeholder='검색내용을 입력하세요'">
				<button type="submit" onclick="showText();">
					<img src="resources/images/icons8-search.png" alt="검색">
				</button>

			</div>

		</div>

	</div>
<!-- 	<div class="sub_bg"></div> -->

	<script> 
    // html dom 이 다 로딩된 후 실행된다.
    $(document).ready(function(){
    	//input박스 숨기기
    	$("input.input_text").hide();
    	//카테고리 하위 메뉴 숨기기
    	$(".sub_hide").hide();
    	    	
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu>a").click(function(){
            var submenu = $(this).next("ul");

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){

            	submenu.slideUp();
               
          
            }else{

                submenu.slideDown();
            }
        });
		
    });
    
  //돋보기 사진 클릭시, 검색 박스 보이기
    function showText(){
  
    	$("input.input_text").fadeIn();

    }
  
  //+클릭시  하위 메뉴 나오기	
  	function showSubHide(seq){
  		
  		$('#sub_hide_'+seq).slideToggle(); //위의 slideUp/Down 기능 모두 포함
  	
  	}
</script>
</header>


</html>