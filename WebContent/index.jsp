<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="style.css" rel="stylesheet" type="text/css">
		<title>ClassAx</title>
	</head>
	<body>
		<%--
			An existing username indicates who is currently logged in,
			so clicking the link does not log one out - Is a security
			hole that MUST BE FIXED
		--%>
		<a href="/ClassAx/index.jsp?username=${param.username}">ClassAx</a>
		
		<p />
	
		<jsp:include page="login.jsp" />

		<p />

		<jsp:include page="cars.jsp" />
	</body>
</html>