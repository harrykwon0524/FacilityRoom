package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import room.Roomlist;
import user.UserinfoDAO;
import user.userinfo;

public class ReplyDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static ReplyDAO instance;
    
    public ReplyDAO(){
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
    	String sql = "SELECT reply_no FROM qna_reply ORDER BY reply_no DESC";
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
    
   public int add(int no, String writer, String content) {
	   String sql = "INSERT INTO qna VALUES (?, ?, ?, NOW(), ?, 1)";
   	try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, no);
   		pstmt.setInt(2, maxNum());
   		pstmt.setString(3, content);
   		pstmt.setString(4, writer);
   	
   		
   		   return pstmt.executeUpdate();
   		    
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return -1;
   }
   
   public ArrayList<Reply> getList(int pageNum) {
	   String sql = "SELECT * FROM qna_reply WHERE reply_no < ? AND rep_available = 1 ORDER BY reply_no DESC LIMIT 3";
	   ArrayList<Reply> list = new ArrayList<Reply>();
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum() - (pageNum -1) * 3); 
   		    rs = pstmt.executeQuery();
   		    while (rs.next()) {
   		    	Reply rep = new Reply(); 
   		    	rep.setQna_qna_no(rs.getInt(1));
   		    	rep.setReply_no(rs.getInt(2));
   		    	rep.setRep_content(rs.getString(3));
   		    	rep.setRep_date(rs.getString(4));
   		    	rep.setRep_writer(rs.getString(5));
   		    	list.add(rep);
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return list;
   }
   public boolean nextPage(int pageNum){
	   String sql = "SELECT * FROM qna_reply WHERE reply_no < ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum()- (pageNum -1) * 3); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   		    	return true;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return false;
   }
   
   
   public Reply getReply(int qna_no, int rep_no) {
	   Reply reply = null;
   	StringBuffer br = new StringBuffer();
		br.append("SELECT qna_qna_no, rep_content, rep_date, rep_writer");
		br.append(" FROM qna_reply");
		br.append(" WHERE reply_no = ? AND qna_qna_no = ?");
		try {
			 
			String sql = br.toString();
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			 pstmt.setInt(1, rep_no);
			 pstmt.setInt(2, qna_no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 reply = new Reply();
				 reply.setQna_qna_no(qna_no);
				 reply.setReply_no(rep_no);
				 reply.setRep_content(rs.getString("rep_content"));
				 reply.setRep_date(rs.getString("rep_date"));
				 reply.setRep_writer(rs.getString("rep_writer"));
				 return reply;
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
	
		return null;
   }
   
   public int update(String writer, String rep_content, int qna_qna_no, int reply_no) {
	   String sql = "UPDATE qna_reply SET rep_content = ?, rep_date= ?, rep_writer = ? WHERE qna_qna_no = ? AND reply_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		
	   		pstmt.setString(1, rep_content);
	   		pstmt.setString(2, getDate());
	   		pstmt.setString(3, writer);
	   		pstmt.setInt(4, qna_qna_no);
	   		pstmt.setInt(5, reply_no);
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public int delete(int qna_no, int rep_no) {
	   String sql = "UPDATE qna_reply SET rep_available = 0 WHERE reply_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, qna_no);
	   		
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   
   public int reported(int qna_no, int rep_no) {
	   String sql = "UPDATE qna_reply SET reported = 1 WHERE qna_qna_no = ? AND reply_no = ? ";

	   	try {
	   		PreparedStatement pst = conn.prepareStatement(sql); 
	   		pst.setInt(1, qna_no);
	   		pst.setInt(2, rep_no);
	   		return pst.executeUpdate();
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   } 
	   	return -1;
	   }
   
   
   public int getreported(int qna_no, int rep_no) {
	   String sql = "SELECT reported FROM qna_reply WHERE reply_no = ? AND qna_qna_no = ? ";

	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, rep_no);
	   		pstmt.setInt(2, qna_no);
	   	 rs = pstmt.executeQuery();
	   	 if(rs.next()) {
			 return rs.getInt(1);
	   	 }
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   
		return -1;
   
   
}
	   	
   public int getQnaAvailable(int rep_no, int qna_no) {
	   	
	   	StringBuffer br = new StringBuffer();
			br.append("SELECT rep_available ");
			br.append(" FROM qna_reply ");
			br.append("WHERE qna_qna_no = ? AND rep_no = ?");
			try {
				String sql = br.toString();
				 PreparedStatement pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, qna_no);
				 pstmt.setInt(2, rep_no);
				 rs = pstmt.executeQuery();
				 while(rs.next()) {
					 return rs.getInt(1);
				 }
				
			}catch(Exception e) {
				e.printStackTrace();
			}
	   return 0;
	   
	   }
   
}

