<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<jsp:include page="/listcars" />

<table id="cars">
	<tr>
		<c:forEach begin="0" end="${fn:length(specNames) - 1}" var="index">
		<th onclick="sort(${index})"><c:out value="${specNames[index]}"/></th>
		</c:forEach>
	</tr>

	<c:forEach var="car" items="${cars}">
	<tr>
		<c:forEach begin="0" end="${fn:length(car.specs) - 1}" var="index">
		<td><c:out value="${car.specs[index]}"/></td>
		</c:forEach>
	</tr>
	</c:forEach>

	<tr>
		<c:forEach var="specName" items="${specNames}">
		<td><input type="text" class="searchbox"></td>
		</c:forEach>
	</tr>
</table>

<script type="text/javascript">
function sort(n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("cars");
  switching = true;

  dir = "asc"; 

  while (switching) {
    switching = false;
    rows = table.getElementsByTagName("TR");

    for (i = 1; i < (rows.length - 2); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];

      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          shouldSwitch= true;
          break;
        }
      }
    }

    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;      
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
</script>