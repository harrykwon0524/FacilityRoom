package facility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import qna.Qna;
import room.RoomDAO;
import room.Roomlist;

public class Facility_BriefDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static Facility_BriefDAO instance;
    
    public Facility_BriefDAO(){
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
    
    public static Facility_BriefDAO getInstance() {
    	if(instance == null)
    		instance = new Facility_BriefDAO();
    	return instance;
    }
    
 public int maxNum(int no) {
    	
    	String sql = "SELECT facility_no FROM facility_brief WHERE roomlist_room_no = ? ORDER BY facility_no DESC";
    	try {
    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
    		  pstmt.setInt(1,  no); 
    		    rs = pstmt.executeQuery();
    		    if(rs.next()) {
    		    	return rs.getInt(1) + 1;
    		    }
    } catch (Exception e) {
    	
    	e.printStackTrace();
    }
    	return 0;
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
    
 
    
    public Facility_Brief getFacility(int no){
 	   String sql = "SELECT * FROM facility_brief WHERE roomlist_room_no = ?";
 	   try {
    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
    		pstmt.setInt(1,  no); 
    		    rs = pstmt.executeQuery();
    		   if(rs.next()) {
    			   Facility_Brief fa = new Facility_Brief(); 
 		    	fa.setRoomlist_room_no(no);
 		    	fa.setFacility_no(rs.getInt(2));
 		    	fa.setAmount(rs.getInt(5));
 		    	fa.setType(rs.getString(3));
 		    	fa.setName(rs.getString(4));
 		    	return fa;
    		    }
    } catch (Exception e) {
    	
    	e.printStackTrace();
    }
 	   return null;
    }
    
    public int add(String type, int amount, String name, int no, int fa_no) {
    	String sql = "INSERT INTO facility_brief VALUES (?, ?, ?, ?, ?, NOW())";
       	try {
       		  PreparedStatement pstmt = conn.prepareStatement(sql); 
       		pstmt.setInt(1, no);
       		pstmt.setInt(2, fa_no);
       		pstmt.setString(3, type);
       		pstmt.setString(4, name);
       		pstmt.setInt(5,amount );
       	
       		   return pstmt.executeUpdate();
       		    
       } catch (Exception e) {
       	
       	e.printStackTrace();
       }
       	return -1;
       
    }
//    public ArrayList<Facility> getList(int pageNum) {
// 	   String sql = "SELECT * FROM facility WHERE facility_no < ? AND facility_available = 1 ORDER BY facility_no DESC LIMIT 10";
// 	   ArrayList<Facility> list = new ArrayList<Facility>();
// 	   try {
//    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
//    		pstmt.setInt(1, maxNum() - (pageNum -1) * 10); 
//    		    rs = pstmt.executeQuery();
//    		    while (rs.next()) {
//    		    	 Facility fa = new Facility(); 
//    	 		    	fa.setFacility_no(rs.getInt(1));
//    	 		    	fa.setType(rs.getString(2));
//    	 		    	fa.setAmount(rs.getInt(3));
//    	 		    	fa.setSerial(rs.getString(4));
//    	 		    	fa.setModel(rs.getString(5));
//    	 		    	fa.setCompany(rs.getString(6));
//    	 		    	fa.setRemarks(rs.getString(7));
//    	 		    	fa.setFa_name(rs.getString(8));
//    	 		    	fa.setBuy_date(rs.getString(9));
//    	 		    	fa.setIn_date(rs.getString(10));
//    		    	list.add(fa);
//    		    }
//    } catch (Exception e) {
//    	
//    	e.printStackTrace();
//    }
//    	return list;
//    }
//    
    public ArrayList<Facility_Brief> getF(int no) {
    	ArrayList<Facility_Brief> list = new ArrayList<Facility_Brief>();
    	StringBuffer br = new StringBuffer();
 		br.append("SELECT facility_no, type, amount, name, insertdate FROM ");
 		br.append(" facility_brief");
 		br.append(" WHERE roomlist_room_no = ?");
 		try {
 			String sql = br.toString();
 			PreparedStatement pstmt = conn.prepareStatement(sql); 
 			 pstmt.setInt(1, no);
 			 rs = pstmt.executeQuery();
 			 while(rs.next()) {
 				Facility_Brief fa = new Facility_Brief();
 				fa.setRoomlist_room_no(no);
	 		    	fa.setFacility_no(rs.getInt("facility_no"));
	 		    	fa.setType(rs.getString("type"));
	 		    	fa.setName(rs.getString("name"));
	 		    	fa.setAmount(rs.getInt("amount"));
	 		    	fa.setInsertdate(rs.getString("insertdate"));
 				list.add(fa);
 			 }
 		}
 		catch (Exception e) {
 	        e.printStackTrace();
 	    } 
 		return list;
    }
    
    public int update(int amount, int fa_no, int no) {
 	   String sql = "UPDATE facility_brief SET amount= ?, insertdate = NOW() WHERE facility_no = ? AND roomlist_room_no = ?";
 	   	try {
 	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
 	   		
 	   		pstmt.setInt(1, amount);
 	   		pstmt.setInt(2, fa_no);
 	   		pstmt.setInt(3, no);
 	   	
 	   
 	   		   return pstmt.executeUpdate();
 	   		    
 	   } catch (Exception e) {
 	   	
 	   	e.printStackTrace();
 	   }
 	   	return -1;
 	   }
    
    
    public ArrayList<Facility_Brief> getBrief(int size) {
  	   String sql = "SELECT * FROM facility_brief WHERE facility_no < ? ORDER BY facility_no DESC";
  	   ArrayList<Facility_Brief> list = new ArrayList<Facility_Brief>();
  	   try {
     		  PreparedStatement pstmt = conn.prepareStatement(sql); 
     		pstmt.setInt(1, size); 
     		    rs = pstmt.executeQuery();
     		    while (rs.next()) {
     		    	Facility_Brief fa = new Facility_Brief(); 
     	 		    	fa.setRoomlist_room_no(rs.getInt("1"));
     	 		    	fa.setFacility_no(rs.getInt("2"));
     	 		    	fa.setType(rs.getString("3"));
     	 		    	fa.setName(rs.getString("4"));
     	 		    	fa.setAmount(rs.getInt("5"));
     	 		    	fa.setInsertdate(rs.getString("6"));
     		    	list.add(fa);
     		    }
     } catch (Exception e) {
     	
     	e.printStackTrace();
     }
     	return list;
     }
    
   
    
    
//    public int update(String type, int amount, String serial, String model, String company, String remarks, String name) { 
//    String sql = "UPDATE facility SET type = ?,  amount= ?,serial = ?,  model = ?, company = ?, remarks = ?, name = ?, in_date = NOW() WHERE qna_no = ? ";
//   	try {
//   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
//   		
//   		pstmt.setString(1, type);
//   		pstmt.setInt(2, amount);
//   		pstmt.setString(3, serial);
//   		pstmt.setString(4, model);
//   		pstmt.setString(5, company);
//   		pstmt.setString(6, remarks);
//   		   return pstmt.executeUpdate();
//   		    
//   } catch (Exception e) {
//   	
//   	e.printStackTrace();
//   }
//   	return -1;
//}
    
    public int delete(int room_no, int no) {
 	   String sql = "DELETE FROM facility_brief WHERE facility_no = ? AND roomlist_room_no = ?";
 	   	try {
 	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
 	   		pstmt.setInt(1, no);
 	   	pstmt.setInt(2, room_no);
 	   	
 	   		   return pstmt.executeUpdate();
 	   		    
 	   } catch (Exception e) {
 	   	
 	   	e.printStackTrace();
 	   }
 	   	return -1;
 	   }
    
   
    
   public List<Facility_Brief> getAllFacility() {
	   StringBuffer br = new StringBuffer();
	   List<Facility_Brief> boards = new ArrayList<Facility_Brief>();
	   br.append("SELECT roomlist_room_no, type, amount, name, insertdate ");
		br.append(" FROM facility");
		br.append(" ORDER BY facility_no DESC ");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 Facility_Brief fac = new Facility_Brief();
				 fac.setName(rs.getString("name"));
				 fac.setType(rs.getString("type"));
				 fac.setAmount(rs.getInt("amount"));
				fac.setRoomlist_room_no(rs.getInt("roomlist_room_no"));
				fac.setInsertdate(rs.getString("insertdate"));
				
				 boards.add(fac);
			 }
		} catch(Exception e) {
			e.printStackTrace();
		}
		return boards;
   }
}
