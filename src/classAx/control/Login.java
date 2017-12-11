package classAx.control;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

/*
 * The Login operation
 */

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("op").equals("Login")) {
			// The operation chosen is to login, given by the input submit button
			try {
				// Call the Database.java helper class for a SQL connection
				Database db = new Database();
				// Find the User with matching credentials
				PreparedStatement query = db.sql.prepareStatement(
						"SELECT * " + 
						"FROM Users " +
						"WHERE Username=? AND Password=ENCRYPT(?,'autocross')"
				);
				query.setString(1, request.getParameter("username"));
				query.setString(2, request.getParameter("password"));

				ResultSet result = query.executeQuery();
				if (result.next()) {
					// If he exists, set him to the username attribute
					request.setAttribute("username", result.getString("Username"));
				}
				else
				{
					// Fail, set the error attribute
					request.setAttribute("error", true);
				}
				db.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			// The operation is to logout, so clear the username and error state
			request.setAttribute("username", null);
			request.setAttribute("error", null);
		}
		
		// Forward the request with the relevant attributes to the index.jsp dispatcher
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
}
