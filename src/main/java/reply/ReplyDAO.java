package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;




public class ReplyDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static ReplyDAO instance;


public ReplyDAO() {
	try {
        String dbURL = "jdbc:mysql://localhost:3306/managefacility";
        String dbID = "root";
        String dbPassword = "Hyungtaek!123";
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
}

public static ReplyDAO getInstance() {
	if(instance == null)
		instance = new ReplyDAO();
	return instance;
}

public static Connection getConnection() {
		Connection conn = null;
		String dbURL = "jdbc:mysql://localhost:3306/managefacility";
      String dbID = "root";
      String dbPassword = "Hyungtaek!123";
		try {
			//드라이버 로드
			Class.forName("com.mysql.jdbc.Driver");
			//커넥션 가져오기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return conn;
	}

public String getDate() {
	String SQL = "SELECT NOW()";
try {
PreparedStatement pstmt = conn.prepareStatement(SQL); 
rs = pstmt.executeQuery();
if(rs.next()) {
	return rs.getString(1);
}
} catch(Exception e) {
	e.printStackTrace();
}
return "";
}

public int maxNum() {
	String sql = "SELECT rep_no FROM qna_reply ORDER BY rep_no DESC";
	try {
		  PreparedStatement pstmt = conn.prepareStatement(sql); 
		    rs = pstmt.executeQuery();
		    if(rs.next()) {
		    	return rs.getInt(1) + 1;
		    }
} catch (Exception e) {
	
	e.printStackTrace();
}
	return 0;
}

public ArrayList<Reply> getRepList(String title, String content, String date, String writer, int whatpage) {
	String sql = "SELECT * FROM qna_reply WHERE qna_qna_no = ? AND qna_available = 1 ORDER BY rep_no DESC";
     
	ArrayList<Reply> list = new ArrayList<Reply>();
	try {
		 PreparedStatement pstmt = conn.prepareStatement(sql); 
		 pstmt.setInt(1, whatpage);
		 rs = pstmt.executeQuery();
	 while (rs.next()){
		 Reply rep = new Reply();
//		 rep.
	 }
	}catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return list;
	   }
}
