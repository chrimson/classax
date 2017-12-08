<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${error == true}">
	Error
</c:if>

<c:if test="${empty param.username}">
	<form action="Login" method="POST">
		Username <input type="text" name="username"/><br/>
		Password <input type="password" name="password"/><br/>
		<input type="submit" name="user" value="Login"/>
	</form>
</c:if>

<c:if test="${not empty param.username}">
	<form action="Login" method="POST">
		${param.username} logged in<br/>
		<input type="submit" name="user" value="Logout"/>
	</form>
</c:if>