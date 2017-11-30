<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/listcars" />

<table>
	<tr>
		<th>Year</th>
		<th>Make</th>
	</tr>
	<c:forEach var="car" items="${cars}">
		<tr>
			<td><c:out value="${car.year}"/></td>
			<td><c:out value="${car.make}"/></td>
		</tr>
	</c:forEach>
</table>