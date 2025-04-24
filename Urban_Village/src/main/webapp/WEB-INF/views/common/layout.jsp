<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
	<div id="container">
		<header id="header">
			<tiles:insertAttribute name="header" /> 
		</header>
		<main id="content">
			<tiles:insertAttribute name="body" />
		</main>
		<footer id="footer">
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>
