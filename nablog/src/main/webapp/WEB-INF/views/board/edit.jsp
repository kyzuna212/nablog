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
		<article id="content">
			<div id="mainbody">
				<form id="inputForm" action="${pageContext.servletContext.contextPath}/insert.do" method="post">
				<c:if test="{board.bno eq null}">
					<input type="hidden" id=bno name=bno value="{board.bno}">
				</c:if>
					<div class="category">
						<label for="menuCateNo" >카테고리 *</label>
						<select name="menuCateNo" id="menuCateNo">
							<c:forEach var="no" items="${menuList}" varStatus="index">
								<option value="${no.menuCateNo}" ${no.menuCateNo==menu.menuCateNo ? 'selected=selected' :''}  >${no.menuTit}</option>
							</c:forEach>
						</select>
					</div>
					<div class="title">
						<label for="bTitle" >제목 *</label>
						<input type="text" id="bTitle" name="bTitle" class="btitle" placeholder="제목을 입력해주세요" required>
					</div>
	
					<textarea name="bCnt" id="editor" rows="10" cols="100" ></textarea>
					<div class="form-group uploadDiv">
						<label for="editor" >첨부파일</label>
						<input type="file" id="bOrfile" name="uploadFile" multiple> <!-- input type='file'은 readonly -->
<!-- 						<button id="uploadBtn">Upload</button> -->
					</div>
					<!-- ul태그 내에 업로드된 파일의 이름을 보여주기 -->
					<div class="uploadResult">
						<ul>
						
						</ul>
					</div>
					
					<div class="tags">
						<label for="editor" >태그</label>
						<input type="text" id="bTage" name="bTage">
					</div>
					<!-- 썸네일 클릭시 보여지는 원본이미지  -->
					<div class="bigPictureWrapper">
						<div class="bigPicture">
						</div>
					</div>
					<div class="submit">
<!-- 						<input type="submit" value="저장"> -->
						<button value="저장" onclick="goSubmit()"></button>
					</div>
				</form>
			</div>
		</article>
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
	

	//썸네일 이미지 클릭시 원본 이미지를 보여줌
	function showImage(fileCallPath){
		//alert(fileCallPath);
		//가운데 배치
		$(".bigPictureWrapper").css("display", "flex").show();
		
		//지정된 시간 동안 화면에서 원본 이미지 출력
		$(".bigPicture").html("<img src='display.do?fileName="encodeURI(fileCallPath)+"'>").animate({width:'100%', height: '100%'}, 1000);
	}
	
	//원본 이미지를 클릭하면 사라짐
	$(".bigPictureWrapper").on("click", function(e){
		
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		//ES6의 화살표 함수는 크롬에서는 정상 작동 IE11에서는 작동 하지 않음
		setTimeout(() => {
			$(this).hide();
		}, 1000);
		
		//IE11용
/* 		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		}, 1000); */
	});
	
	//파일 이름 출력
	var uploadResult = $(".uploadResult ul");
	
	//파일 업로드시 보여지는 부분
	function showUploadedFile(uploadResultArr){
		
		var str ="";
		
		$(uploadResultArr).each(function(i,obj) {
			
			if(!obj.image){ //이미지 파일이 아닐경우 일반 첨부파일 이미지
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+obj.fileName);
			
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
				str += "<li><div><a href='/download.do?fileName="+fileCallPath+"'><img src='/resources/images/icons8-file.png'>" +obj.fileName + "</a>"
						+"<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span></div></li>";
				
			}else{ //이미지 파일일 경우 썸네일 이미지
				
				//str += "<li><img src='/resources/images/icons8-image-file.png'>" +obj.fileName + "</li>";
				
				//서버에서 섬네일을 GET방식을 통해 가져올 수 있도록 함 (URI뒤에 파일 이름 추가)
				//(한글 혹은 공백이 들어가면 문제 발생 가능-자바스크립트의 encodeURIComponent()함수를 이용해서  URI에 문제없는 문자열 생성해서 처리
				var fileCallPath = encodeURIComponent(obj.uploadPath+"\s_"+obj.uuid+obj.fileName);
				
				//원본 이미지 이름은 썸네일의 \s_가 \로 변경
				var originPath = obj.uploadPath +"\\"+obj.uuid + "_" +obj.fileName;
				
				// '\'기호의 경우 일반 문자열과 다르게 처리되므로 '/'로 변환한 후 처리
				originPath = originPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display.do?fileName="+fileCallPath+"'></a>"
						+"<span data-file=\'"+fileCallPath"\' data-type='image'> x </span></li>";
				
			}
			
		});
				uploadResult.append(str);
	}
	

	$(document).ready(function() {
		//main페이지를 제외한 나머지 페이지에서는 목록을 항상 보이게 한다
		$(".sub_hide").show();
		$(".hide").show();
		$(".left_side_bar").show();
		
		var cloneObj = $(".uploadDiv").clone();
				
		//input type='file'의 내용이 변경되는 것을 감지하여 파일 업로드 처리
		$("input[type='file']").change(function(e){
			
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
					dataType : json,
					success: function(result){
						console.log(result);
						//alert("첨부파일이 등록 되었습니다");
						
						//파일 이름 출력 -업로드 결과 처리 함수
						showUploadedFile(result); 
						
						//첨부파일 추가하고 버튼을 클릭하면 첨부파일 초기화
					//	$(".uploadDiv").html(cloneObj.html());
					}
			})
		});
		
		//업로드 된 결과를 화면에 썸네일 등을 만들어서 처리
		//Ajax 호출 후에 업로드된 결과를 처리하는 함수
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length ==0){
				return;
			}
			
			var uploadUL = $(".uploadResult ul");
			
			var str="";
			
			//첨부파일에 관련된 정보 (data-uuid, data-filename, data-type)포함
			$(uploadResultArr).each(function(i, obj){
				
				//image type
				if(obj.image){
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName"' ";
					str += "data-type='"+obj.image+"'><div>";
					str += "<span>"+obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display.do?fileName="+fileCallPath"'>";
					str += "</div>";
					str + "</li>";
					
				}else{
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' ";
					str += "data-type='"+obj.image+"'><div>";
					str += "<span>"+obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'"
					str += "data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/images/icons8-file.png'>";
					str += "</div>";
					str + "</li>";
				}
			});
			
			uploadUL.append(str);
		} 
		
		//x 버튼 눌렀을 때 첨부파일 삭제
		$(".uploadResult").on("click", "button", function(e){
			
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			//console.log(targetFile);
			
			var targetLi = $(this).closest("li");
			
			//첨부파일의 경로와 이름, 파일의 종류(이미지 혹은 일반) 정보 전송
	 		$.ajax({
				url : '/deleteFile.do',
				data : {fileName : targetFile , type : type},
				dataType : 'text',
				type : 'POST',
					success : function(result){
						alert(result);
					}
				
			});
		});
		
		//submit button을 클릭시
		var formObj = $("form[role='form']");
		
		$.("button[type='submit']").on("click", function(e)){
			
			e.preventDefault();
			
			console.log("submit clicked");
			
			var str = "";
			
			//파일 정보를 hidden으로 같이 보냄
			$(".uploadResult ul li").each(function(i,obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+job.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+job.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].imageType' value='"+job.data("type")+"'>";
			});
			
			formObj.append(str).submit();
			
		}
		

		
	});
	
	//전송하기
	function goSubmit(){
		var bno =('#bno').val();
		
		//새글 등록
		if(bno != null){
			('#inputForm').action = '/insert.do' 
		}else{//글 수정
			('#inputForm').action = '/modify.do' 		
		}
	}
	
	
	

	

</script>

<!-- 푸터 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
<script type="text/javascript" src = "resources/js/notice-write.js"></script>


