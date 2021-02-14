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

public class QnaDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static QnaDAO instance;
    
    public QnaDAO(){
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
    
    public static QnaDAO getInstance() {
    	if(instance == null)
    		instance = new QnaDAO();
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
    
    public void updateViewcnt(int qna_no) {
		StringBuffer br = new StringBuffer();
		br.append("UPDATE qna ");
		br.append(" SET viewcnt = viewcnt + 1");
		br.append(" WHERE qna_no = ? ");
		try {
			 String sql = br.toString();
			 PreparedStatement pstm = conn.prepareStatement(sql);
			 pstm.setInt(1, qna_no); 
			 pstm.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}
    }
    
    public int maxNum() {
    	String sql = "SELECT qna_no FROM qna ORDER BY qna_no DESC";
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
    
   public int add(String title, String qna_writer, String content, String category) {
	   String sql = "INSERT INTO qna VALUES (?, ?, NOW(), NOW(), ?, 0, 1, ?, ?, 0, ?, ?)";
   	try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum());
   		pstmt.setString(2, title);
   		pstmt.setString(3, content);
   		pstmt.setString(4, qna_writer);
   		pstmt.setString(5, category);
   		pstmt.setString(6, null);
   		pstmt.setString(7, null);
   		
   		   return pstmt.executeUpdate();
   		    
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return -1;
   }
   
   public ArrayList<Qna> getList(int pageNum) {
	   String sql = "SELECT * FROM qna WHERE qna_no < ? AND qna_available = 1 ORDER BY qna_no DESC LIMIT 10";
	   ArrayList<Qna> list = new ArrayList<Qna>();
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum() - (pageNum -1) * 10); 
   		    rs = pstmt.executeQuery();
   		    while (rs.next()) {
   		    	Qna qna = new Qna(); 
   		    	qna.setQna_no(rs.getInt(1));
   		    	qna.setTitle(rs.getString(2));
   		    	qna.setQna_modate(rs.getString(3));
   		    	qna.setQna_content(rs.getString(5));
   		    	qna.setViewcnt(rs.getInt(6));
   		    	qna.setQna_available(rs.getInt(7));
   		    	qna.setQna_writer(rs.getString(8));
   		    	qna.setCategory(rs.getString(9));
   		    	list.add(qna);
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return list;
   }
   public boolean nextPage(int pageNum){
	   String sql = "SELECT * FROM qna WHERE qna_no < ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum()- (pageNum -1) * 10); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   		    	return true;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return false;
   }
   
   public Qna getRoomList(String title){
	   String sql = "SELECT * FROM qna WHERE title = ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setString(1, title); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   			Qna qna = new Qna(); 
		    	qna.setQna_no(rs.getInt(1));
		    	qna.setTitle(rs.getString(2));
		    	qna.setQna_modate(rs.getString(3));
		    	qna.setQna_indate(rs.getString(4));
		    	qna.setQna_content(rs.getString(5));
		    	qna.setViewcnt(rs.getInt(6));
   		    	qna.setQna_available(rs.getInt(7));
   		    	qna.setQna_writer(rs.getString(8));
   		    	qna.setCategory(rs.getString(9));
		    	return qna;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return null;
   }
   
   public Qna getQna(int qna_no) {
	   Qna qna = null;
   	StringBuffer br = new StringBuffer();
		br.append("SELECT title, viewcnt, qna_writer, qna_content, category ");
		br.append(" FROM qna");
		br.append(" WHERE qna_no = ? ");
		try {
			 
			String sql = br.toString();
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			 pstmt.setInt(1, qna_no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 qna = new Qna();
				 qna.setQna_no(qna_no);
				 qna.setTitle(rs.getString("title"));		
				 qna.setQna_content(rs.getString("qna_content"));
				 qna.setQna_writer(rs.getString("qna_writer"));
				 qna.setViewcnt(rs.getInt("viewcnt"));
				 qna.setCategory(rs.getString("category"));
				 return qna;
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
	
		return null;
   }
   
   public int update(String title, String writer, String qna_content, String category, int qna_no) {
	   String sql = "UPDATE qna SET title = ?,  qna_modate= ?,qna_content = ?,  qna_writer = ?, category = ? WHERE qna_no = ? ";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		
	   		pstmt.setString(1, title);
	   		pstmt.setString(2, getDate());
	   		pstmt.setString(3, qna_content);
	   		pstmt.setString(4, writer);
	   		pstmt.setString(5, category);
	   		pstmt.setInt(6, qna_no);
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public int delete(int qna_no) {
	   String sql = "UPDATE qna SET qna_available = 0 WHERE qna_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, qna_no);
	   		
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public ArrayList<Qna> getQnaArray(String category, String sort, String search, int pageNum) {
	if(category.equals("전체")) {
		category = "";
	}
	ArrayList<Qna> qnalist = null;
	String SQL = "";
	
    try { 
    	if(sort.equals("번호순")) {
    		SQL = "SELECT * FROM qna  WHERE category LIKE ?  AND CONCAT(title, qna_content, viewcnt, qna_writer) LIKE" + 
    	"? ORDER BY qna_no DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
    	} else if(sort.equals("조회순")) {
    		SQL = "SELECT * FROM qna WHERE category LIKE ? AND CONCAT(title, qna_content, viewcnt, qna_writer) LIKE" + 
    	"? ORDER BY viewcnt DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
    	}
    	
    	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
        pstmt.setString(2, "%" + search + "%");
        pstmt.setString(1, "%" + category + "%");
        rs = pstmt.executeQuery();
        qnalist = new ArrayList<Qna>();
        while(rs.next()){
        	Qna qna = new Qna(); 
		    	qna.setQna_no(rs.getInt(1));
		    	qna.setTitle(rs.getString(2));
		    	qna.setQna_content(rs.getString(5));
		    	qna.setViewcnt(rs.getInt(6));	
		    	qna.setQna_modate(rs.getString(3));
   		    	qna.setQna_writer(rs.getString(8));	
   		    	qna.setCategory(rs.getString(9));	
   		    	qnalist.add(qna);
        }
       
        
    } catch (Exception e) {
        e.printStackTrace();
    } 
    return qnalist; // DB 오류
    
}
   
   public Qna getq(int no) {
	   
	   String sql = "SELECT * FROM qna WHERE qna_no = ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, no); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   			Qna qna = new Qna(); 
		    	qna.setQna_no(rs.getInt(1));
		    	qna.setTitle(rs.getString(2));
		    	qna.setQna_modate(rs.getString(3));
		    	qna.setQna_indate(rs.getString(4));
		    	qna.setQna_content(rs.getString(5));
		    	qna.setViewcnt(rs.getInt(6));
   		    	qna.setQna_available(rs.getInt(7));
   		    	qna.setQna_writer(rs.getString(8));
   		    	qna.setCategory(rs.getString(9));
		    	return qna;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return null;
   }
   
   public int reported(int no) {
	   String sql = "UPDATE qna SET reported = 1 WHERE qna_no = ? ";

	   	try {
	   		PreparedStatement pst = conn.prepareStatement(sql); 
	   		pst.setInt(1, no);
	   		return pst.executeUpdate();
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   } 
	   	return -1;
	   }
   
   public int setReport(String title, String content, int no) {
	   StringBuffer br = new StringBuffer();
		br.append("UPDATE qna SET reportTitle = ?, reportContent =?");
		br.append("WHERE qna_no = ?");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, title);
			 pstmt.setString(2, content);
			 pstmt.setInt(3, no);
			 return pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
 
		return -1;
 }
   
   
   public int getreported(int no) {
	   String sql = "SELECT reported FROM qna WHERE qna_no = ? ";

	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, no);
	   	 rs = pstmt.executeQuery();
	   	 if(rs.next()) {
			 return rs.getInt(1);
	   	 }
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   
		return -1;
   
   
}
   
   
	   	
   public int getQnaAvailable(int no) {
	   	
	   	StringBuffer br = new StringBuffer();
			br.append("SELECT qna_available ");
			br.append(" FROM qna ");
			br.append("WHERE qna_no = ?");
			try {
				String sql = br.toString();
				 PreparedStatement pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, no);
				 rs = pstmt.executeQuery();
				 while(rs.next()) {
					 return rs.getInt(1);
				 }
				
			}catch(Exception e) {
				e.printStackTrace();
			}
	   return 0;
	   
	   }
   
   public String getReportTitle(int no) {
	   
	   StringBuffer br = new StringBuffer();
		br.append("SELECT reportTitle ");
		br.append(" FROM qna ");
		br.append("WHERE qna_no = ?");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 return rs.getString(1);
			 }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
  return null;
  
  }
   
 public String getReportContent(int no) {
	   
	   StringBuffer br = new StringBuffer();
		br.append("SELECT reportContent ");
		br.append(" FROM qna ");
		br.append("WHERE qna_no = ?");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 return rs.getString(1);
			 }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
  return null;
  
  }
 
 public int cancelReport(int no) {
	 StringBuffer br = new StringBuffer();
		br.append("UPDATE qna SET reported = 0 ");
		br.append("WHERE qna_no = ?");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, no);
			 return pstmt.executeUpdate();
			 
		}catch(Exception e) {
			e.printStackTrace();
		}
return -1;

}
 
 public ArrayList<Qna> getQnaReportArray(String category, String sort, String search, int pageNum) {
	if(category.equals("전체")) {
		category = "";
	}
	ArrayList<Qna> qnalist = null;
	String SQL = "";
	
  try { 
  	if(sort.equals("번호순")) {
  		SQL = "SELECT * FROM qna  WHERE category LIKE ? AND reported LIKE 1 AND CONCAT(title, qna_content, viewcnt, qna_writer) LIKE " + 
  	"? ORDER BY qna_no DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
  	} else if(sort.equals("조회순")) {
  		SQL = "SELECT * FROM qna WHERE category LIKE ? AND reported LIKE 1 AND CONCAT(title, qna_content, viewcnt, qna_writer) LIKE " + 
  	"? ORDER BY viewcnt DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
  	}
  	
  	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
      pstmt.setString(2, "%" + search + "%");
      pstmt.setString(1, "%" + category + "%");
      rs = pstmt.executeQuery();
      qnalist = new ArrayList<Qna>();
      while(rs.next()){
      	Qna qna = new Qna(); 
		    	qna.setQna_no(rs.getInt(1));
		    	qna.setTitle(rs.getString(2));
		    	qna.setQna_content(rs.getString(5));
		    	qna.setViewcnt(rs.getInt(6));	
		    	qna.setQna_modate(rs.getString(3));
 		    	qna.setQna_writer(rs.getString(8));	
 		    	qna.setCategory(rs.getString(9));	
 		    	qnalist.add(qna);
      }
     
      
  } catch (Exception e) {
      e.printStackTrace();
  } 
  return qnalist; // DB 오류
  
}
   
}

