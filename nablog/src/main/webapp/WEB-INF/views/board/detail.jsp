<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<section id="container_wrap">

		<div class="content-wrap">
			<article id="content_detail">
				<div class="inner">

					<div class="post-cover-detail">
						<div class="inner">
							<span class="category">카테고리명</span>
							<h1>콘텐츠 제목</h1>
							<span class="meta"> 
								<!-- <span class="author">by 나츠키</span> -->
								<span class="date">2020. 5. 20.</span>

							</span>
						</div>
					</div>

					<div class="entry-content">
						<div class="tt_article_useless_p_margin">
							<div class="main_contents">
								<p>본문 내용이 나오는 곳</p>
							</div>
							<div class="container_postbtn_detail #post_button_group">
								<div class="postbtn_like">
									<div class="wrap_btn" id="reaction-159">
										<button class="btn_post uoc-icon">
											<div class="uoc-icon">
												<span class="ico_postbtn ico_like">좋아요</span> <span
													class="txt_like uoc-count">공감</span>
											</div>
										</button>
									</div>

									<div class="wrap_btn wrap_btn_share">
										<button type="button" class="btn_post sns_btn btn_share"
											data-thumbnail-url="#"
											data-title="콘텐츠제목"
											data-description=""
											data-profile-image="#"
											data-profile-name="나츠키"
											data-pc-url="#"
											data-relative-pc-url="#seq" data-blog-title="나츠키's 블로그">
											<span class="ico_postbtn ico_share">공유하기</span>
										</button>
									</div>

									<div class="wrap_btn wrap_btn_etc" data-entry-id="#"
										data-entry-visibility="public"
										data-category-visibility="public">
										<button type="button" class="btn_post btn_etc2">
											<span class="ico_postbtn ico_etc">글 요소</span>
										</button>
									</div>
								</div>
								<button type="button"
									class="btn_menu_toolbar btn_subscription  #subscribe"
									data-blog-id="#"
									data-url="#"
									data-device="web_pc">
									<em class="txt_state">구독하기</em> <strong class="txt_tool_id">나츠키's 블로그</strong> 
									<span class="img_common_tistory ico_check_type1"></span>
								</button>

								<div class="postbtn_ccl" data-ccl-type="3">
									<a href="#"
										target="_blank" class="link_ccl"> <span class="bundle_ccl_detail">
											<span class="ico_postbtn ico_ccl1">저작자표시</span>
									</span>
									</a>
								</div>
							</div>

							<div class="another_category_detail another_category_color_gray">
								<h4>
									'<a href="#">카테고리명</a>' 카테고리의 다른 글
								</h4>
								<table>
									<tbody>
										<tr>
											<th><a href="#">다른 글의 제목임</a>&nbsp;&nbsp;<span>(0)</span>
											</th>
										<!-- 	<td>2019.11.10</td> -->
										</tr>
										<tr>
											<th><a href="#" class="current">또 다른 글 제목임</a>&nbsp;&nbsp;<span>(0)</span></th>
											<!-- <td>2020.12.10</td> -->
										</tr>
										<tr>
											<th><a href="#">블로그 글 제목임</a>&nbsp;&nbsp;<span>(0)</span></th>
											<!-- <td>2021.01.07</td> -->
										</tr>
										<tr>
											<th><a href="#">또 다른 블로그 글 제목임</a>&nbsp;&nbsp;<span>(0)</span></th>
											<!-- <td>2021.01.16</td> -->
										</tr>
										<tr>
											<th><a href="#">블로그제목이여</a>&nbsp;&nbsp;<span>(0)</span></th>
											<!-- <td>2021.02.04</td> -->
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<div class="comments_detail">
							<h2>
								댓글<span class="count"><span id="commentCount159_0">0</span></span>
							</h2>
							<div id="entry159Comment">


								<form method="post" action="#"
									onsubmit="return false" style="margin: 0">
									<div class="comment-form-detail">

										<div class="field">

											<input type="text" name="name" placeholder="이름" value="">
											<input type="password" name="password" maxlength="8"
												placeholder="비밀번호" value="">

											<div class="secret">
												<input type="checkbox" name="secret" id="secret"> <label
													for="secret" tabindex="0">비밀글</label>
											</div>
										</div>

										<textarea name="comment" cols="" rows="4"
											placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
										<div class="submit">
											<button type="submit" class="btn_detail"
												onclick="#">등록</button>
										</div>
									</div>
								</form>
							</div>

						</div>
					</div>
					
					<div class="pagination_detail">
						<a href="#" class="prev ">이전</a>
						
							<a href="#"><span>1</span></a>
						
							<a><span>···</span></a>
						
							<a href="#"><span>96</span></a>
						
							<a href="#"><span>97</span></a>
						
							<a href="#"><span>98</span></a>
						
							<a href="#"><span>99</span></a>
						
							<a><span class="selected">100</span></a>
						
							<a href="#"><span>101</span></a>
						
							<a href="#"><span>102</span></a>
						
							<a href="#"><span>103</span></a>
						
							<a href="#"><span>104</span></a>
						
							<a><span>···</span></a>
						
							<a href="#"><span>252</span></a>
						
						<a href="#" class="next ">다음</a>
					</div>
				</div>
			</article>
		</div>
	</section>
	
	<script> 
   
    $(document).ready(function(){
    	//main페이지를 제외한 나머지 페이지에서는 목록을 항상 보이게 한다
    	
    	$(".sub_hide").show();
    	$("#header .util .menu .hide").show();
    	$(".left_side_bar").show();

    });
    </script>
    <!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>