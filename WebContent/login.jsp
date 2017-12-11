<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
	Error if the login info failed
--%>
<c:if test="${error == true}">
	Error
</c:if>

<%--
	If the state of the index.jsp page username is undefined,
	show the input prompt and submit to the Login.java servlet
--%>
<c:if test="${empty param.username}">
	<form action="Login" method="POST">
		Username <input type="text" name="username"/><br/>
		Password <input type="password" name="password"/><br/>
		<input type="submit" name="op" value="Login"/>
	</form>
</c:if>

<%--
	If the state of the index.jsp page username is defined,
	show who's logged in and the input to log out with
	the Login.java servlet
--%>
<c:if test="${not empty param.username}">
	<form action="Login" method="POST">
		${param.username} logged in<br/>
		<input type="submit" name="op" value="Logout"/>
	</form>
</c:if>