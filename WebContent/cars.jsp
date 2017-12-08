<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<jsp:include page="/listcars" />

<form id="table" action="Table" method="POST">
	<table id="cars">
		<tr>
			<c:forEach begin="0" end="${fn:length(headers) - 1}" var="index">
			<td onclick="sort(${index})" class="header">
				<span><c:out value="${headers[index]}"/></span>
			</td>
			</c:forEach>
		</tr>
	
		<c:forEach var="car" items="${cars}">
		<tr>
			<c:forEach begin="0" end="${fn:length(headers) - 1}" var="index">
			<td onclick="collapsible(${index})">
				<span style="white-space:nowrap"><c:out value="${car.specs[index]}"/></span>
			</td>
			</c:forEach>
		</tr>
		</c:forEach>
	
		<tr>
			<c:forEach begin="0" end="${fn:length(headers) - 2}" var="specIndex">
			<td class="search">
				<span>
				<input name="${headers[specIndex]}" type="text" style="width:40px" value="${specReq[specIndex]}"/>
				</span>
			</td>
			</c:forEach>
		</tr>
	</table>

	<input type="hidden" name="username" value="${username}"/>
	<p />

	<div style="text-align:center">
		<input type="submit" name="op" value="Search"/>
		<input type="button" onclick="clearFields()" value="Clear" />
		<c:if test="${not empty username}">
			<c:choose>
				<c:when test="${op == 'Add'}">
					<input type="submit" name="op" value="Confirm"/>
				</c:when>
				<c:otherwise>
					<input type="submit" name="op" value="Add"/>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
</form>

<script type="text/javascript">
var specs = '${fn:length(headers) - 1}';
sort(specs);
maximizeFields();

function sort(n) {
	var table, rows, switching=true, i, x, y, shouldSwitch=false, dir="desc", switchcount=0;
	table = document.getElementById("cars");
	
	while (switching) {
		switching = false;
		rows = table.getElementsByTagName("tr");
		
		for (i = 1; i < (rows.length - 2); i++) {
			shouldSwitch = false;
			x = rows[i].getElementsByTagName("td")[n].firstElementChild.innerHTML.toLowerCase();
			y = rows[i + 1].getElementsByTagName("td")[n].firstElementChild.innerHTML.toLowerCase();
			
			if (!isNaN(x) && !isNaN(y)) {
				x = parseFloat(x);
				y = parseFloat(y);
			} 
			
			if (dir == "asc") {
				if (x > y) {
					shouldSwitch = true;
					break;
				}
			} else if (dir == "desc") {
				if (x < y) {
					shouldSwitch = true;
					break;
				}
			}
		}
		
		if (shouldSwitch) {
			rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
			switching = true;
			switchcount ++;      
		} else {
			if (switchcount == 0 && dir == "desc") {
				dir = "asc";
				switching = true;
			}
		}
	}
}

function collapsible(n) {
	var table, rows, i, cell, content;
	table = document.getElementById("cars");
	rows = table.getElementsByTagName("tr");

	for (i = 0; i < rows.length; i++) {
		cell = rows[i].getElementsByTagName("td")[n];
		content = cell.firstElementChild;
		
		if (cell.style.maxWidth == "10px") {
			content.style.visibility = "visible";
			cell.style.maxWidth = "200px";
		} else {
			content.style.visibility = "collapse";
			cell.style.maxWidth = "10px";
		}
	}
}

function maximizeFields() {
	var search, i;
	search = document.getElementsByClassName("search");

	for (i = 0; i < search.length; i++) {
		search[i].firstElementChild.firstElementChild.style.width =
			search[i].clientWidth + "px";
	}
}

function clearFields() {
	var search, i;
	search = document.getElementsByClassName("search");
	for (i = 0; i < search.length; i++) {
		search[i].firstElementChild.firstElementChild.setAttribute("value", "");
	}
	
	document.getElementById("table").reset();
}
</script>