package lesson;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import user.UserinfoDAO;

public class LessonDAO {
	private Connection conn;            // DB�� �����ϴ� ��ü   // 
    private ResultSet rs;                // DB data�� ���� �� �ִ� ��ü  (Ctrl + shift + 'o') -> auto import
    private static UserinfoDAO instance;
    
    public LessonDAO(){
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
    
    
    
}
