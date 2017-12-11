package classAx.control;

import java.sql.*;
import com.mysql.jdbc.Driver;

/*
 * 	The SQL connection
 */

public class Database {
	public Connection sql;
	
	public Database() throws Exception {
		DriverManager.registerDriver(new Driver());
		sql = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/ClassAx", "root", "");
	}
	
	public void close() throws Exception {
		sql.close();
		DriverManager.deregisterDriver(new Driver());
	}
}
