package classAx.control;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

/*
 * The Headers DAO
 */

@WebServlet("/Headers")
public class Headers extends HttpServlet {
    private static final long serialVersionUID = 5L; 

    public static final int MATCHES_COL = 1;
    public static final int RANK_COL = 1;
    
    // System operations will all use POST method for consistency
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		// All headers for general table, including Specifications, Rank, Matches, etc
		List<String> headers = new ArrayList<String>();
		
	    // Always determine the SQL table structure, make headers aggregate
	    try {
			// Call the Database.java helper class for a SQL connection
			Database db = new Database(getServletContext());
			Statement query = db.sql.createStatement();
			ResultSet results = query.executeQuery(
					"DESCRIBE Cars"
			);
	 
			while (results.next()) {
				headers.add(results.getString("Field"));
			}

			// Alongside specific saved data, add dynamic Matches
			headers.add("Matches");
			
			db.close();
		} catch (Exception e) { }
	    
		// Set all the table headers, table data and User's requested specifications
		request.setAttribute("headers", headers);
	}
	
	// Still access data if simple GET method from initial URL load in browser  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		doPost(request, response);
	}
}
