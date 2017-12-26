package classAx.control;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

import javax.servlet.ServletContext;

import com.mysql.jdbc.Driver;

/*
 * 	The SQL connection
 */

public class Database {
	public Connection sql;
	
	public Database(ServletContext servlet) throws Exception {
		InputStream input = servlet.getResourceAsStream("/WEB-INF/classAx.properties");
		Properties props = new Properties();
		props.load(input);
		
		DriverManager.registerDriver(new Driver());
		sql = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + props.getProperty("db"),
				props.getProperty("acct"),
				props.getProperty("auth", ""));
	}
	
	public void close() throws Exception {
		sql.close();
		DriverManager.deregisterDriver(new Driver());
	}
}
