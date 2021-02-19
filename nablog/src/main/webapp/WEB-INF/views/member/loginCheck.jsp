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
	<form action="/login.do" name="login" id="login" method="post">
		<div class="text-form">
			<dl>
				<dt>
					<label for="id"><span class="ti-user"></span></label>
				</dt>
				<dd>
					<input type="text" name="id" id="id" placeholder="ID">
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="password"><span class="ti-unlock"></span></label>
				</dt>
				<dd>
					<input type="password" name="pwd" id="password"
						placeholder="Password">
				</dd>
			</dl>
			<span class="loginBtn"><input type="submit" value="로그인"
				style="opacity: 1; cursor: pointer;"
				onmouseover="this.style.opacity='0.7'"
				onmouseout="this.style.opacity='1'"></span>
		</div>
	</form>
</body>
</html>