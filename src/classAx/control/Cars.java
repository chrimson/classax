package classAx.control;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import classAx.model.*;

/*
 * The Cars Data Access Object (DAO)
 */

@WebServlet("/Cars")
public class Cars extends HttpServlet {
    private static final long serialVersionUID = 2L; 

    // System operations will all use POST method for consistency
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		// All headers for general table, including Specifications, Rank, Matches, etc
		Enumeration<String> params = (Enumeration<String>)request.getParameterNames();
		List<String> headers = new ArrayList<String>();
		while (params.hasMoreElements()) {
			headers.add((String) params.nextElement());
		}

		// Values entered into input text fields in request
	    List<String> specReq = new ArrayList<String>();
	    
	    // Each row of model classes
	    List<Car> cars = new ArrayList<Car>();

		if (request.getParameter("op").equals("Confirm")) {
			// A request to Confirm input text fields will add new row
			
		    String specs = "";
		    // Make statement only for number of specifications, not Matches
		    for (int i = 0; i < headers.size() - Headers.MATCHES_COL; i++) {
			    
		    	// Logic to put commas only in between values or null
		    	if (!specs.equals("")) {
		    		specs += ",";
		    	}
			    
		    	// Generate string of SQL VALUES to add
			    String spec = request.getParameter(headers.get(i));
			    if (spec.equals("")) {
				    // SQL needs NULL literally specified
		    		spec = "NULL";
		    	} else {
		    		// Otherwise, put the specified string in SQL quote syntax 
		    		spec = String.format("'%s'", spec);
		    	}
			    
			    // Next specification
			    specs += spec;
		    }

		    // Run the Insert statement for the new Row of values
			try {
				// Call the Database.java helper class for a SQL connection
				Database db = new Database();
				Statement update = db.sql.createStatement();
				update.executeUpdate(
					"INSERT INTO Cars " +
					"VALUES ( " +
					specs +
					")"
				);

				db.close();
			} catch (Exception e) { }
		}
		
	    // Whenever button is pressed to get to table screen,
	    // always do a search for each specification given in the text fields
	    String where = "";
	    // Generate Where clause only for number of specifications, not Matches
	    for (int i = 0; i < headers.size() - Headers.MATCHES_COL; i++) {

	    	// Get each specification by the header names 
	    	String specName = headers.get(i);
		    
	    	// Build collection of input text fields in request
	    	specReq.add(request.getParameter(specName));
	    	
	    	// If something is entered for the specification
		    if (specReq.get(i) != null && !specReq.get(i).equals("")) {
		    	
		    	// Logic to put OR only in between assignments
	    		if (!where.equals("")) {
		    		where += " OR ";
		    	}
		    	where += specName + "='" + specReq.get(i) + "'";
		    }
	    }
	    
	    if (!where.equals("")) {
		    // At least a specification is entered,
	    	// so query with a Where clause
	    	where = "WHERE " + where;
		    try {
				// Call the Database.java helper class for a SQL connection
				Database db = new Database();
				Statement query = db.sql.createStatement();
				ResultSet results = query.executeQuery(
						"SELECT * " +
						"FROM Cars " +
						where
				);
		 
				// For all rows returned by SQL
				while (results.next()) {
					List<String> specs = new ArrayList<String>();
					// Start counting the number of specifications that are matched
					int specMatch = 0;
					
					// And each specification
					for (int i = 0; i < headers.size() - Headers.MATCHES_COL; i++) {
						String spec = results.getString(i + 1);

						// Build the collection of all specifications returned by SQL
						specs.add(i, spec);

						// If specification exists and is the same as what was requested
						if (spec != null && !spec.equals("") && spec.equalsIgnoreCase(specReq.get(i))) {
							// Add it to the number of specification matches
							specMatch = specMatch + 1;
						}
					}
					
					// Indicated the number of matches tallied for this row 
					specs.add(headers.size() - Headers.MATCHES_COL, Integer.toString(specMatch));
					cars.add(new Car(specs));
				}

				db.close();
			} catch (Exception e) { }
	    }

		// Set all the table headers, table data and User's requested specifications
		request.setAttribute("cars", cars);
		request.setAttribute("specReq", specReq);
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
	
	// Still access data if simple GET method from initial URL load in browser  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		doPost(request, response);
	}
}
