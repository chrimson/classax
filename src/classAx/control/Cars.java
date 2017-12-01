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
	    List<String> specNames = new ArrayList<String>();
	    List<Car> cars = new ArrayList<Car>();

	    try {
			Database db = new Database();
			Statement query = db.sql.createStatement();
			ResultSet results = query.executeQuery(
					"DESCRIBE Cars"
			);
	 
			while (results.next()) {
				specNames.add(results.getString("Field"));
			}

			db.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    String where = "";
	    for (int i = 0; i < specNames.size(); i++) {
		    String specName = specNames.get(i);
		    String spec = request.getParameter(specName);
		    if (spec != null && !spec.equals("")) {
		    	if (!where.equals("")) {
		    		where += " AND ";
		    	}
		    	where += specName + "='" + spec + "'";
		    }
	    }
	    if (!where.equals("")) {
	    	where = "WHERE " + where;
	    }
	    
	    try {
			Database db = new Database();
			Statement query = db.sql.createStatement();
			ResultSet results = query.executeQuery(
					"SELECT * " +
					"FROM Cars " +
					where
			);
	 
			while (results.next()) {
				List<Object> specs = new ArrayList<Object>();
				for (int i = 0; i < specNames.size(); i++) {
					specs.add(i, results.getObject(i + 1));
				}
				
				cars.add(new Car(specs));
			}

			db.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("specNames", specNames);
		request.setAttribute("cars", cars);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		doPost(request, response);
	}
}
