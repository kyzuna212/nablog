<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			<form id="inputForm" action="/insert.do" method="post">
				<label for="menuCateNo" >카테고리 *</label>
				<select name="menuCateNo" id="menuCateNo">
					<c:forEach var="no" items="${menuList}" varStatus="index">
						<option value="${no.menuCateNo}" ${no.menuCateNo==menu.menuCateNo ? 'selected=selected' :''}  >${no.menuTit}</option>
					</c:forEach>
				</select>
				
				<label for="bTitle" >제목 *</label>
				<input type="text" id="bTitle" name="bTitle" placeholder="제목을 입력해주세요" required>
				

				<textarea name="bCnt" id="editor" rows="10" cols="100" ></textarea>
				
				<label for="editor" >첨부파일</label>
				<input type="file" id="bOrfile" name="uploadFile" multiple>
				<button id="uploadBtn">Upload</button>
				
				<label for="editor" >태그</label>
				<input type="text" id="bTage" name="bTage">
			</form>
		</div>
</div>

<script type="text/javascript">

	//smartEditor2 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "editor",  //textarea ID
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
	 oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
	
	 // 에디터의 내용에 대한 값 검증은 이곳에서
	 // document.getElementById("editor").value를 이용해서 처리한다.
	
	 try {
	     elClickedObj.form.submit();
	 } catch(e) {}
	
	}
	
	//exe,sh,zip,alz 확장자 제외시키기
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	//파일 사이즈 제한
	var maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >=maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}

	$(document).ready(function() {
		//main페이지를 제외한 나머지 페이지에서는 목록을 항상 보이게 한다
		$(".sub_hide").show();
		$(".hide").show();
		$(".left_side_bar").show();
		
		//파일 업로드 
		$('#uploadBtn').on("click", function(e){
			
			//FormData라는 객체를 활용하여 필요한 파라미터를 담아 전송
			//브라우저 제한 있음
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			//file 데이터를 formData에 넣기
			for(var i=0; i<files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){				
					return false;
				}
				
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				
				url : 'upload.do',
				processData : false,
				contentType : false,
				data : formData,
				type: 'POST',
				success: function(result){
					alert("첨부파일이 등록 되었습니다");
				}
			})
		});
		
		
	});
	
	
	

	

</script>

<!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
<script type="text/javascript" src = "resources/js/notice-write.js"></script>


