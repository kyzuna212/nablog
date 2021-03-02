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

<script type="text/javascript" src="resources/editor/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>


</head>
<body>
<div id="all_wrap">

		<!-- 콘텐츠 -->
		<div id="mainbody">
			<textarea name="ir1" id="ir1" rows="10" cols="100" style="margin-top:-180px;">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
		</div>
</div>

<script type="text/javascript">

	//smartEditor2 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "ir1",  //textarea ID
		sSkinURI : "resources/editor/dist/SmartEditor2Skin.html", //skin경로
		fCreator : "createSEditor2",
		htParams : { 
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseToolbar : true, 
			
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : false, 
			
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : true 
		}

			
	});
		
	// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
	function submitContents(elClickedObj) {
	 // 에디터의 내용이 textarea에 적용된다.
	 oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	
	 // 에디터의 내용에 대한 값 검증은 이곳에서
	 // document.getElementById("ir1").value를 이용해서 처리한다.
	
	 try {
	     elClickedObj.form.submit();
	 } catch(e) {}
	
	}

	$(document).ready(function() {
		//main페이지를 제외한 나머지 페이지에서는 목록을 항상 보이게 한다
		$(".sub_hide").show();
		$(".hide").show();
		$(".left_side_bar").show();
		
		
	});
	

	

</script>

<!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
<script type="text/javascript" src = "resources/js/notice-write.js"></script>


