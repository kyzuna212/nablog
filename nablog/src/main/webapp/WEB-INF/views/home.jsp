<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page session="false" %>
<html>
<head>
	<title>Main Page</title>
	<!-- 디자인  -->
	<c:import url="/WEB-INF/views/common/meta.jsp" />
	<!-- header -->
	<c:import url="/WEB-INF/views/common/header.jsp" />
</head>
<body>
	
	
	<!-- contents -->
	<div id="mainbody">
	<c:import url="/WEB-INF/views/common/body.jsp"/>
	</div>

	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
 </body>
</html>
