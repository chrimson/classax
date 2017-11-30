<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<jsp:include page="/listcars" />

<table>
	<tr>
		<c:forEach var="specName" items="${specNames}">
		<th><c:out value="${specName}" /></th>
		</c:forEach>
	</tr>
	<c:forEach var="car" items="${cars}">
	<tr>
		<c:forEach begin="0" end="${fn:length(car.specs) - 1}" var="index">
		<td><c:out value="${car.specs[index]}"/></td>
		</c:forEach>
	</tr>
	</c:forEach>
</table>