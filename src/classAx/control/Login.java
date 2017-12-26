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
		HttpSession session = request.getSession();
		
		if (request.getParameter("op").equals("Login")) {
			// The operation chosen is to login, given by the input submit button
			try {
				// Call the Database.java helper class for a SQL connection
				Database db = new Database(getServletContext());
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
					// If he exists, set username to session loggedIn attribute
					session.setAttribute("loggedIn", result.getString("Username"));
				}
				else
				{
					// Fail, set the session Login Fail attribute
					session.setAttribute("loginFail", true);
				}
				db.close();
				
			} catch (Exception e) { }
		} else {
			// The operation is to logout, so clear the session state
				session.invalidate();
		}
		
		// Forward the request with the relevant attributes to the index.jsp dispatcher
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
