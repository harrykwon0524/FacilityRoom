package announcement;

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

public class AnnouncementDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static AnnouncementDAO instance;
    
    public AnnouncementDAO(){
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
    
    public static AnnouncementDAO getInstance() {
    	if(instance == null)
    		instance = new AnnouncementDAO();
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
    
    public void updateViewcnt(int announcement_no) {
		StringBuffer br = new StringBuffer();
		br.append("UPDATE announcement ");
		br.append(" SET announcement_view = announcement_view + 1");
		br.append(" WHERE announcement_no = ? ");
		try {
			 String sql = br.toString();
			 PreparedStatement pstm = conn.prepareStatement(sql);
			 pstm.setInt(1, announcement_no); 
			 pstm.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}
    }
    
    public int maxNum() {
    	String sql = "SELECT announcement_no FROM announcement ORDER BY announcement_no DESC";
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
	   String sql = "INSERT INTO announcement VALUES (?, ?, NOW(), NOW(), ?, 0, 1, ?, ?, 0)";
   	try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum());
   		pstmt.setString(2, title);
   		pstmt.setString(3, content);
   		pstmt.setString(4, qna_writer);
   		pstmt.setString(5, category);
   		
   		   return pstmt.executeUpdate();
   		    
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return -1;
   }
   
   public ArrayList<Announcement> getList(int pageNum) {
	   String sql = "SELECT * FROM announcement WHERE announcement_no < ? AND announcement_available = 1 ORDER BY announcement_no DESC LIMIT 5";
	   ArrayList<Announcement> list = new ArrayList<Announcement>();
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum() - (pageNum -1) * 5); 
   		    rs = pstmt.executeQuery();
   		    while (rs.next()) {
   		    Announcement ann = new Announcement(); 
   		    	ann.setAnnouncement_no(rs.getInt(1));
   		    	ann.setAnnouncement_title(rs.getString(2));
   		    	ann.setAnnouncement__modate(rs.getString(3));
   		    	ann.setAnnouncement_content(rs.getString(5));
   		    	ann.setAnnouncement_view(rs.getInt(6));
   		    	ann.setAnnouncement__available(rs.getInt(7));
   		    	ann.setAnnouncement__writer(rs.getString(8));
   		    	ann.setCategory(rs.getString(9));
   		    	list.add(ann);
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return list;
   }
   public boolean nextPage(int pageNum){
	   String sql = "SELECT * FROM announcement WHERE announcement_no < ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum()- (pageNum -1) * 5); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   		    	return true;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return false;
   }
   
   public Announcement getAnnList(String title){
	   String sql = "SELECT * FROM announcement WHERE announcement_title = ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setString(1, title); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   			Announcement ann = new Announcement(); 
		    	ann.setAnnouncement_no(rs.getInt(1));
		    	ann.setAnnouncement_title(rs.getString(2));
		    	ann.setAnnouncement__modate(rs.getString(3));
		    	ann.setAnnouncement_indate(rs.getString(4));
		    	ann.setAnnouncement_content(rs.getString(5));
		    	ann.setAnnouncement_view(rs.getInt(6));
		    	ann.setAnnouncement__available(rs.getInt(7));
		    	ann.setAnnouncement__writer(rs.getString(8));
		    	ann.setCategory(rs.getString(9));
		    	return ann;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return null;
   }
   
   public Announcement getAnn(int announcement_no) {
	   Announcement ann = null;
   	StringBuffer br = new StringBuffer();
		br.append("SELECT announcement_title, announcement_view, announcement_writer, announcement_content, category ");
		br.append(" FROM announcement");
		br.append(" WHERE announcement_no = ? ");
		try {
			 
			String sql = br.toString();
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			 pstmt.setInt(1, announcement_no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 ann = new Announcement();
				 ann.setAnnouncement_no(announcement_no);
				 ann.setAnnouncement_title(rs.getString("announcement_title"));		
				 ann.setAnnouncement_content(rs.getString("announcement_content"));
				 ann.setAnnouncement__writer(rs.getString("announcement_writer"));
				 ann.setAnnouncement_view(rs.getInt("announcement_view"));
				 ann.setCategory(rs.getString("category"));
				 return ann;
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
	
		return null;
   }
   
   public int update(String title, String writer, String content, String category, int no) {
	   String sql = "UPDATE announcement SET announcement_title = ?,  announcement_modate= ?,announcement_content = ?,  announcement_writer = ?, category = ? WHERE announcement_no = ? ";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		
	   		pstmt.setString(1, title);
	   		pstmt.setString(2, getDate());
	   		pstmt.setString(3, content);
	   		pstmt.setString(4, writer);
	   		pstmt.setString(5, category);
	   		pstmt.setInt(6, no);
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public int delete(int no) {
	   String sql = "UPDATE announcement SET announcement_available = 0 WHERE announcement_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, no);
	   		
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public ArrayList<Announcement> getAnnArray(String category, String sort, String search, int pageNum) {
	if(category.equals("전체")) {
		category = "";
	}
	ArrayList<Announcement> annlist = null;
	String SQL = "";
	
    try { 
    	if(sort.equals("번호순")) {
    		SQL = "SELECT * FROM announcement  WHERE category LIKE ?  AND CONCAT(announcement_title, announcement_content, announcement_view, announcement_writer) LIKE" + 
    	"? ORDER BY announcement_no DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
    	} else if(sort.equals("조회순")) {
    		SQL = "SELECT * FROM announcement WHERE category LIKE ? AND CONCAT(announcement_title, announcement_content, announcement_view, announcement_writer) LIKE" + 
    	"? ORDER BY announcement_view DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
    	}
    	
    	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
        pstmt.setString(2, "%" + search + "%");
        pstmt.setString(1, "%" + category + "%");
        rs = pstmt.executeQuery();
        annlist = new ArrayList<Announcement>();
        while(rs.next()){
        	Announcement ann = new Announcement(); 
		    	ann.setAnnouncement_no(rs.getInt(1));
		    	ann.setAnnouncement_title(rs.getString(2));
		    	ann.setAnnouncement_content(rs.getString(5));
		    	ann.setAnnouncement_view(rs.getInt(6));	
		    	ann.setAnnouncement__modate(rs.getString(3));
   		    	ann.setAnnouncement__writer(rs.getString(8));	
   		    	ann.setCategory(rs.getString(9));	
   		    	annlist.add(ann);
        }
       
        
    } catch (Exception e) {
        e.printStackTrace();
    } 
    return annlist; // DB 오류
    
}
   
   public Announcement getA(String writer) {
	   
	   String sql = "SELECT * FROM announcement WHERE announcement_writer = ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setString(1, writer); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   			Announcement ann = new Announcement(); 
		    	ann.setAnnouncement_no(rs.getInt(1));
		    	ann.setAnnouncement_title(rs.getString(2));
		    	ann.setAnnouncement__modate(rs.getString(3));
		    	ann.setAnnouncement_indate(rs.getString(4));
		    	ann.setAnnouncement_content(rs.getString(5));
		    	ann.setAnnouncement_view(rs.getInt(6));
   		    	ann.setAnnouncement__available(rs.getInt(7));
   		    	ann.setAnnouncement__writer(rs.getString(8));
   		    	ann.setCategory(rs.getString(9));
		    	return ann;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return null;
   }
   
   public boolean reported(int no) {
	   String sql = "UPDATE announcement SET reported = 1 WHERE announcement_no = ? ";

	   	try {
	   		PreparedStatement pst = conn.prepareStatement(sql); 
	   		pst.setInt(1, no);
	   		pst.executeUpdate();
	   		    return true;
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   } finally {
    		try {if(conn != null) conn.close();} catch(Exception e) {  e.printStackTrace();			}
    	
    		}
	   	return false;
	   }
   
   
   public int getreported(int no) {
	   String sql = "SELECT reported FROM announcement WHERE announcement_no = ? ";

	   	try {
	   		conn = getConnection();
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
   public int getAnnouncementAvailable(int no) {
	   	
	   	StringBuffer br = new StringBuffer();
			br.append("SELECT announcement_available ");
			br.append(" FROM announcement ");
			br.append("WHERE announcement_no = ?");
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
     	
   
}

