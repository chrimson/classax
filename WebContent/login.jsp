<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<%--
		If the state of the session username loggedIn is defined, show
		who's logged in and the input to log out with the Login.java servlet
	--%>
	<c:when test="${not empty sessionScope.loggedIn}">
		<form action="Login" method="POST">
			<c:out value="${sessionScope.loggedIn}"/> logged in
			<input type="submit" name="op" value="Logout"/>
		</form>
	</c:when>
	
	<%--
		Otherwise, show if the session login failed, and
		show the input prompt and submit to the Login.java servlet
	--%>
	<c:otherwise>
		<c:if test="${sessionScope.loginFail}">
			Login failed
			<% session.removeAttribute("loginFail"); %>
		</c:if>
		<form action="Login" method="POST">
			<table class="nb">
				<tr class="nb"><td class="nb">Username</td><td class="nb"><input type="text" name="username"/></td></tr>
				<tr class="nb"><td class="nb">Password</td><td class="nb"><input type="password" name="password"/></td></tr>
			</table>
			<input type="submit" name="op" value="Login"/>
		</form>
	</c:otherwise>
</c:choose>