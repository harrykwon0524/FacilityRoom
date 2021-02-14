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

public class FacilityDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static FacilityDAO instance;
    
    public FacilityDAO(){
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
    
    public static FacilityDAO getInstance() {
    	if(instance == null)
    		instance = new FacilityDAO();
    	return instance;
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
    	
    	String sql = "SELECT facility_no FROM facility ORDER BY facility_no DESC";
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
    
    public Facility getFacility(String fa_name){
 	   String sql = "SELECT * FROM facility WHERE fa_name = ?";
 	   try {
    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
    		pstmt.setString(1, fa_name); 
    		    rs = pstmt.executeQuery();
    		   if(rs.next()) {
    			   Facility fa = new Facility(); 
 		    	fa.setFacility_no(rs.getInt(1));
 		    	fa.setType(rs.getString(2));
 		    	fa.setAmount(rs.getInt(3));
 		    	fa.setSerial(rs.getString(4));
 		    	fa.setModel(rs.getString(5));
 		    	fa.setCompany(rs.getString(6));
 		    	fa.setRemarks(rs.getString(7));
 		    	fa.setFa_name(rs.getString(7));
 		    	fa.setBuy_date(rs.getString(8));
 		    	fa.setIn_date(rs.getString(9));
 		    	
 		    	return fa;
    		    }
    } catch (Exception e) {
    	
    	e.printStackTrace();
    }
 	   return null;
    }
    
    public Facility getFacilityType(String type){
  	   String sql = "SELECT * FROM facility WHERE type = ?";
  	   try {
     		  PreparedStatement pstmt = conn.prepareStatement(sql); 
     		pstmt.setString(1, type); 
     		    rs = pstmt.executeQuery();
     		   if(rs.next()) {
     			   Facility fa = new Facility(); 
  		    	fa.setFacility_no(rs.getInt(1));
  		    	fa.setType(rs.getString(2));
  		    	fa.setAmount(rs.getInt(3));
  		    	fa.setSerial(rs.getString(4));
  		    	fa.setModel(rs.getString(5));
  		    	fa.setCompany(rs.getString(6));
  		    	fa.setRemarks(rs.getString(7));
  		    	fa.setFa_name(rs.getString(7));
  		    	fa.setBuy_date(rs.getString(8));
  		    	fa.setIn_date(rs.getString(9));
  		    	
  		    	return fa;
     		    }
     } catch (Exception e) {
     	
     	e.printStackTrace();
     }
  	   return null;
     }
    
    public int add(String type, int amount, String serial, String model, String company, String remarks, String name) {
    	String sql = "INSERT INTO facility VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), 1)";
       	try {
       		  PreparedStatement pstmt = conn.prepareStatement(sql); 
       		pstmt.setInt(1, maxNum());
       		pstmt.setString(2, type);
       		pstmt.setInt(3, amount);
       		pstmt.setString(4, serial);
       		pstmt.setString(5,model );
       		pstmt.setString(6,company );
       		pstmt.setString(7,remarks );
     		pstmt.setString(8,name);
       		   return pstmt.executeUpdate();
       		    
       } catch (Exception e) {
       	
       	e.printStackTrace();
       }
       	return -1;
       
    }
    public ArrayList<Facility> getList(int pageNum) {
 	   String sql = "SELECT * FROM facility WHERE facility_no < ? AND facility_available = 1 ORDER BY facility_no DESC LIMIT 5";
 	   ArrayList<Facility> list = new ArrayList<Facility>();
 	   try {
    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
    		pstmt.setInt(1, maxNum() - (pageNum -1) * 5); 
    		    rs = pstmt.executeQuery();
    		    while (rs.next()) {
    		    	 Facility fa = new Facility(); 
    	 		    	fa.setFacility_no(rs.getInt(1));
    	 		    	fa.setType(rs.getString(2));
    	 		    	fa.setAmount(rs.getInt(3));
    	 		    	fa.setSerial(rs.getString(4));
    	 		    	fa.setModel(rs.getString(5));
    	 		    	fa.setCompany(rs.getString(6));
    	 		    	fa.setRemarks(rs.getString(7));
    	 		    	fa.setFa_name(rs.getString(8));
    	 		    	fa.setBuy_date(rs.getString(9));
    	 		    	fa.setIn_date(rs.getString(10));
    		    	list.add(fa);
    		    }
    } catch (Exception e) {
    	
    	e.printStackTrace();
    }
    	return list;
    }
    
    public Facility getF(int facility_no) {
    	Facility fa = null;
    	StringBuffer br = new StringBuffer();
 		br.append("SELECT facility_no, type, amount, serial, model, company, remarks, fa_name, buy_date, in_date ");
 		br.append(" FROM facility");
 		br.append(" WHERE facility_no = ? ");
 		try {
 		 fa = new Facility();
 			String sql = br.toString();
 			PreparedStatement pstmt = conn.prepareStatement(sql); 
 			 pstmt.setInt(1, facility_no);
 			 rs = pstmt.executeQuery();
 			 while(rs.next()) {
 				fa.setFacility_no(rs.getInt("facility_no"));
 				fa.setType(rs.getString("type"));
 				fa.setAmount(rs.getInt("amount"));
 				fa.setSerial(rs.getString("serial"));
 				fa.setModel(rs.getString("model"));
 				fa.setCompany(rs.getString("company")); 				
 				fa.setRemarks(rs.getString("remarks")); 				
 				fa.setFa_name(rs.getString("fa_name")); 				
 				fa.setBuy_date(rs.getString("buy_date")); 		
 				fa.setIn_date(rs.getString("in_date")); 		
 			 }
 		}
 		catch (Exception e) {
 	        e.printStackTrace();
 	    } 
 		return fa;
    }
    
    public int update(String type, int amount, String serial, String model, String company, String remarks, String fa_name, int no) {
 	   String sql = "UPDATE facility SET type = ?,  amount= ?, serial = ?, model = ?, company = ?, remarks = ?, fa_name = ?, in_date = NOW() WHERE facility_no = ?";
 	   	try {
 	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
 	   		pstmt.setInt(8, no);
 	   		pstmt.setString(1, type);
 	   		pstmt.setInt(2, amount);
 	   	pstmt.setString(3, serial);
 	   		pstmt.setString(4, model);
 	   		pstmt.setString(5, company);
 	   	pstmt.setString(6, remarks);
 	   pstmt.setString(7, fa_name);
 	   
 	   		   return pstmt.executeUpdate();
 	   		    
 	   } catch (Exception e) {
 	   	
 	   	e.printStackTrace();
 	   }
 	   	return -1;
 	   }
    
    public int delete(String fa_name) {
 	   String sql = "UPDATE facility SET facility_available = 0 WHERE fa_name = ?";
 	   	try {
 	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
 	   		pstmt.setString(1, fa_name);
 	   		
 	   		   return pstmt.executeUpdate();
 	   		    
 	   } catch (Exception e) {
 	   	
 	   	e.printStackTrace();
 	   }
 	   	return -1;
 	   }
    
    public ArrayList<Facility> getBrief(int size) {
  	   String sql = "SELECT * FROM facility WHERE facility_no < ? AND facility_available = 1 ORDER BY facility_no DESC";
  	   ArrayList<Facility> list = new ArrayList<Facility>();
  	   try {
     		  PreparedStatement pstmt = conn.prepareStatement(sql); 
     		pstmt.setInt(1, size); 
     		    rs = pstmt.executeQuery();
     		    while (rs.next()) {
     		    	 Facility fa = new Facility(); 
     	 		    	fa.setFacility_no(rs.getInt(1));
     	 		    	fa.setType(rs.getString(2));
     	 		    	fa.setAmount(rs.getInt(3));
     	 		    	fa.setSerial(rs.getString(4));
     	 		    	fa.setModel(rs.getString(5));
     	 		    	fa.setCompany(rs.getString(6));
     	 		    	fa.setRemarks(rs.getString(7));
     	 		    	fa.setFa_name(rs.getString(8));
     	 		    	fa.setBuy_date(rs.getString(9));
     	 		    	fa.setIn_date(rs.getString(10));
     		    	list.add(fa);
     		    }
     } catch (Exception e) {
     	
     	e.printStackTrace();
     }
     	return list;
     }
    
    public boolean nextPage(int pageNum){
 	   String sql = "SELECT * FROM facility WHERE facility_no < ?";
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
    
    public ArrayList<Facility> getQnaArray(String type, String sort, String search, int pageNum) {
    	if(type.equals("전체")) {
    		type = "";
    	}
    	ArrayList<Facility> faclist = null;
    	String SQL = "";
    	
        try { 
        	if(sort.equals("번호순")) {
        		SQL = "SELECT * FROM facility  WHERE type LIKE ?  AND facility_available = 1 AND CONCAT(type, amount, serial, model, company, remarks, fa_name, buy_date, in_date) LIKE" + 
        	"? ORDER BY facility_no DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
        	} else if(sort.equals("수량순")) {
        		SQL = "SELECT * FROM facility WHERE type LIKE ? AND facility_available = 1 AND CONCAT(type, amount, serial, model, company, remarks, fa_name, buy_date, in_date) LIKE" + 
        	"? ORDER BY amount DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
        	}
        	
        	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
            pstmt.setString(2, "%" + search + "%");
            pstmt.setString(1, "%" + type + "%");
            rs = pstmt.executeQuery();
            faclist = new ArrayList<Facility>();
            while(rs.next()){
            	Facility fac = new Facility();
    		    	fac.setFacility_no(rs.getInt(1));
    		    	fac.setType(rs.getString(2));
    		    	fac.setAmount(rs.getInt(3));
    		    	fac.setSerial(rs.getString(4));
    		    	fac.setModel(rs.getString(5));
    		    	fac.setCompany(rs.getString(6));
    		    	fac.setRemarks(rs.getString(7));
    		    	fac.setFa_name(rs.getString(8));
    		    	fac.setBuy_date(rs.getString(9));
    		    	fac.setIn_date(rs.getString(10));
       		    	faclist.add(fac);
            }
           
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return faclist; // DB 오류
        
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
    
    public int delete(int no) {
 	   String sql = "UPDATE facility SET facility_available = 0 WHERE facility_no = ?";
 	   	try {
 	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
 	   		pstmt.setInt(1, no);
 	   		
 	   		   return pstmt.executeUpdate();
 	   		    
 	   } catch (Exception e) {
 	   	
 	   	e.printStackTrace();
 	   }
 	   	return -1;
 	   }
    
    public int getAvailable(int no) {
    	
    	StringBuffer br = new StringBuffer();
		br.append("SELECT facility_available ");
		br.append(" FROM facility");
		br.append("WHERE facility_no = ?");
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
    
   public List<Facility> getAllFacility() {
	   StringBuffer br = new StringBuffer();
	   List<Facility> boards = new ArrayList<Facility>();
	   br.append("SELECT facility_no, type, amount, serial, model, company, remarks, fa_name, buy_date, in_date ");
		br.append(" FROM facility WHERE facility_available = 1");
		br.append(" ORDER BY facility_no DESC ");
		try {
			String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 Facility fac = new Facility();
				 fac.setFacility_no(rs.getInt("facility_no"));
				 fac.setType(rs.getString("type"));
				 fac.setAmount(rs.getInt("amount"));
				 fac.setSerial(rs.getString("serial"));
				 fac.setModel(rs.getString("model"));
				 fac.setCompany(rs.getString("company"));
				 fac.setRemarks(rs.getString("remarks"));
				 fac.setFa_name(rs.getString("fa_name"));
				 fac.setBuy_date(rs.getString("buy_date"));
				 fac.setIn_date(rs.getString("in_date"));
				 boards.add(fac);
			 }
		} catch(Exception e) {
			e.printStackTrace();
		}
		return boards;
   }
}
