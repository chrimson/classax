package classAx.control;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");

			Database db = new Database();
			PreparedStatement query = db.sql.prepareStatement(
					"SELECT * " + 
					"FROM Users " +
					"WHERE Username=? AND Password=ENCRYPT(?,'autocross')"
			);
			query.setString(1, request.getParameter("username"));
			query.setString(2, request.getParameter("password"));
	 
			ResultSet result = query.executeQuery();
			if (result.next()) {
				request.setAttribute("username", result.getString("Username"));
			}
			else
			{
				request.setAttribute("error", true);
			}
			db.close();
			
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		request.setAttribute("username", null);
		request.setAttribute("error", null);
		dispatcher.forward(request, response);
	}
}
