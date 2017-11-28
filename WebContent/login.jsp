<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty error}">
	Error
</c:if>

<c:if test="${empty username}">
	<form action="Login" method="POST">
		Username <input type="text" name="username"/><br/>
		Password <input type="password" name="password"/><br/>
		<input type="submit" value="Login"/>
	</form>
</c:if>

<c:if test="${not empty username}">
	<form action="Login" method="GET">
		${username} logged in<br/>
		<input type="submit" value="Logout"/>
	</form>
</c:if>