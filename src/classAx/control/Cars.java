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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		List<String> headers = new ArrayList<String>();
	    List<String> specReq = new ArrayList<String>();
	    List<Car> cars = new ArrayList<Car>();

	    try {
			Database db = new Database();
			Statement query = db.sql.createStatement();
			ResultSet results = query.executeQuery(
					"DESCRIBE Cars"
			);
	 
			while (results.next()) {
				headers.add(results.getString("Field"));
			}

			headers.add("Matches");
			
			db.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
		if (request.getParameter("op") != null) {
			if (request.getParameter("op").equals("Confirm")) {
			    String specs = "";
			    for (int i = 0; i < headers.size() - 1; i++) {
				    if (!specs.equals("")) {
			    		specs += ",";
			    	}
				    
				    System.out.println(request.getParameter(headers.get(i)));
				    
				    String spec = request.getParameter(headers.get(i));
//			    	if (spec == null) {
//			    		spec = "";
//			    	}
				    
				    specs += "'" + spec + "'";
			    }

				System.out.println(specs);

				try {
					Database db = new Database();
					Statement update = db.sql.createStatement();
					update.executeUpdate(
						"INSERT INTO Cars " +
						"VALUES ( " +
						specs +
						")"
					);

					db.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		    String where = "";
		    for (int i = 0; i < headers.size() - 1; i++) {
			    String specName = headers.get(i);
			    specReq.add(request.getParameter(specName));
			    if (specReq.get(i) != null && !specReq.get(i).equals("")) {
			    	if (!where.equals("")) {
			    		where += " OR ";
			    	}
			    	where += specName + "='" + specReq.get(i) + "'";
			    }
		    }
		    if (!where.equals("")) {
		    	where = "WHERE " + where;
			    
			    try {
					Database db = new Database();
					Statement query = db.sql.createStatement();
					ResultSet results = query.executeQuery(
							"SELECT * " +
							"FROM Cars " +
							where
					);
			 
					while (results.next()) {
						List<String> specs = new ArrayList<String>();
						int specMatch = 0;
						
						for (int i = 0; i < headers.size() - 1; i++) {
							String spec = results.getString(i + 1);
							specs.add(i, spec);
	
							if (spec != null && !spec.equals("") && spec.equalsIgnoreCase(specReq.get(i))) {
								specMatch = specMatch + 1;
							}
						}
						
						specs.add(headers.size() - 1, Integer.toString(specMatch));
						cars.add(new Car(specs));
					}
	
					db.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		    }
		}

		request.setAttribute("headers", headers);
		request.setAttribute("cars", cars);
		request.setAttribute("specReq", specReq);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		doPost(request, response);
	}
}
