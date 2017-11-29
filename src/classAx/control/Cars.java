package classAx.control;

import java.io.*;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import classAx.model.*;

@WebServlet("/Cars")
public class Cars extends HttpServlet {
    private static final long serialVersionUID = 1L; 
	public List<Car> cars = new ArrayList<Car>();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		request.setAttribute("message", "cars!");
		
//		try {
//			RequestDispatcher dispatcher = request.getRequestDispatcher("cars.jsp");;
//
//			Database db = new Database();
//			Statement query = db.sql.createStatement();
//			ResultSet results = query.executeQuery(
//					"SELECT * " +
//					"FROM Cars"
//			);
//	 
//			while (results.next()) {
//				cars.add(new Car());
//			}
//
//			db.close();
//			
//			dispatcher.forward(request, response);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {            
		doGet(request, response);
	}
}
