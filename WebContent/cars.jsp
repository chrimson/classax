<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
	Include reference in web.xml to Cars.java Data Access Object
--%>
<jsp:include page="/headers" />

<%--
	The form action is Table.java, a launcher for the index.jsp
	with set form parameters for the specifications
--%>
<form id="table" action="Cars" method="POST">
	<table id="cars">
		<%-- Headers --%>
		<tr>
			<%-- Iterate over item index to simplify sorting --%>
			<c:forEach begin="0" end="${fn:length(headers) - 1}" var="index">
			<td onclick="sort(${index})" class="header">
				<span><c:out value="${headers[index]}"/></span>
			</td>
			</c:forEach>
		</tr>

		<%-- Listings found --%>
		<c:forEach var="car" items="${cars}">
		<tr>
			<%-- Iterate over item index to simplify collapsing --%> 
			<c:forEach begin="0" end="${fn:length(headers) - 1}" var="index">
			<td onclick="collapsible(${index})">
				<span style="white-space:nowrap"><c:out value="${car.specs[index]}"/></span>
			</td>
			</c:forEach>
		</tr>
		</c:forEach>
	
		<%-- Search/Add input fields --%>
		<tr>
			<%-- Iterate over item index to exclude Matches column --%>
			<c:forEach begin="0" end="${fn:length(headers) - 2}" var="specIndex">
			<td class="search">
				<span>
				<input class="nb" name="${headers[specIndex]}" type="text" style="width:40px" value="${specReq[specIndex]}" onkeypress="checkFields(event)"/>
				</span>
			</td>
			</c:forEach>
		</tr>
	</table>

	<%-- Operational input submit buttons --%>
	<div style="text-align:center">
		<input id="search" type="submit" name="op" value="Search"/>
		<input id="clear" type="button" onclick="clearFields()" value="Clear" />

		<%-- Only show editing operational buttons if logged in --%>
		<c:if test="${not empty sessionScope.loggedIn}">
			<c:choose>
				<c:when test="${op == 'Add'}">
					<input id="confirm" type="submit" name="op" value="Confirm"/>
				</c:when>
				<c:otherwise>
					<input id="add" type="submit" name="op" value="Add"/>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
</form>


<script type="text/javascript">

<%-- Sort Matches column descending by default--%>
var specs = '${fn:length(headers) - 1}';
sort(specs);

<%-- Stretch fields cosmetically to occupy cells --%>
maximizeFields();

<%--
	On loading page, determine if any Fields have default
	values and reflect properly with operational buttons
--%>
initFields();


<%-- Toggle ascending/descending sort of the nth particular column's specifications --%>
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
			
			<%--
				Compare numerical values in cells,
				setting empty cells to 0
			--%>
			if (!isNaN(x) && !isNaN(y)) {
				x = parseFloat(x);
				y = parseFloat(y);
				
				if (isNaN(x)) {
					x = 0;
				}

				if (isNaN(y)) {
					y = 0;
				}
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

<%-- Toggle un/collapse of column for readibility--%>
function collapsible(n) {
	var table, rows, i, cell, content;
	table = document.getElementById("cars");
	rows = table.getElementsByTagName("tr");

	for (i = 0; i < rows.length; i++) {
		cell = rows[i].getElementsByTagName("td")[n];
		content = cell.firstElementChild;
		
		if (cell.style.maxWidth == "10px") {
			content.style.visibility = "visible";

			<%-- More than wide enough --%>
			cell.style.maxWidth = "200px";
		} else {
			content.style.visibility = "collapse";
			cell.style.maxWidth = "10px";
		}
	}
}

<%-- Stretch fields cosmetically to occupy cells --%>
function maximizeFields() {
	var search, i;
	search = document.getElementsByClassName("search");

	for (i = 0; i < search.length; i++) {
		search[i].firstElementChild.firstElementChild.style.width =
			search[i].clientWidth + "px";
	}
}

<%-- Clear realtime input data as well as default parameters --%>
function clearFields() {
	var search, i;
	search = document.getElementsByClassName("search");
	for (i = 0; i < search.length; i++) {
		search[i].firstElementChild.firstElementChild.setAttribute("value", "");
	}
	
	document.getElementById("table").reset();
	initFields();
}

<%--
	Determine key that is pressed in realtime in input field
	and check if all fiends are empty
--%>
function checkFields(event) {
	var empty = true, i, all = "", key = event.which;
	search = document.getElementsByClassName("search");
	
	if (key > 31 && key < 127) {
		<%-- Any of the text ASCII--%>
		empty = false;
	} else {
		<%-- Count how much text is in all input fields --%>
		for (i = 0; i < search.length; i++) {
			all += search[i].firstElementChild.firstElementChild.value;
		}
		
		if (all.length > 1) {
			empty = false;
		}
	}
	
	setFields(empty);
}

<%-- Determine if all fields are empty --%>
function initFields() {
	var search, i, empty = true;
	search = document.getElementsByClassName("search");

	for (i = 0; i < search.length; i++) {
		if (search[i].firstElementChild.firstElementChild.value != "") {
			empty = false;
		}
	}

	setFields(empty);
}

<%-- Dis/Enable operation buttons depending on emptiness of all fields --%>
function setFields(empty) {
	document.getElementById("search").disabled = empty;
	document.getElementById("clear").disabled = empty;

	if (document.getElementById("confirm") != null) {
		document.getElementById("confirm").disabled = empty;
	}
	if (document.getElementById("add") != null) {
		document.getElementById("add").disabled = empty;
	}
}
</script>