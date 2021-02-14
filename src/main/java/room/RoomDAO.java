package room;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import user.UserinfoDAO;
import user.userinfo;

public class RoomDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static RoomDAO instance;
    
    public RoomDAO(){
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
    
    public static RoomDAO getInstance() {
    	if(instance == null)
    		instance = new RoomDAO();
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
    	String sql = "SELECT room_no FROM roomlist ORDER BY room_no DESC";
    	try {
    		  PreparedStatement pstmt = conn.prepareStatement(sql); 
    		    rs = pstmt.executeQuery();
    		    if(rs.next()) {
    		    	return rs.getInt(1)+1;
    		    }
    } catch (Exception e) {
    	
    	e.printStackTrace();
    }
    	return 0;
    }
    
   public int add(String room_name, String user_id, int size, int capacity, String building, String buildingroom) {
	   String sql = "INSERT INTO roomlist VALUES (?, ?, ?, ?, ?, NOW(), ?, 1, ?, ?)";
   	try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum());
   		pstmt.setString(2, room_name);
   		pstmt.setString(3, user_id);
   		pstmt.setInt(4, size);
   		pstmt.setInt(5, capacity);
   		pstmt.setString(6, getDate());
   		pstmt.setString(7, building);
   		pstmt.setString(8, buildingroom);
   		   return pstmt.executeUpdate();
   		    
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return -1;
   }
   
   public ArrayList<Roomlist> getList(int pageNum) {
	   String sql = "SELECT * FROM roomlist WHERE room_no < ? AND room_available = 1 ORDER BY room_no DESC LIMIT 5";
	   ArrayList<Roomlist> list = new ArrayList<Roomlist>();
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setInt(1, maxNum() - (pageNum -1) * 5); 
   		    rs = pstmt.executeQuery();
   		    while (rs.next()) {
   		    	Roomlist room = new Roomlist(); 
   		    	room.setRoom_no(rs.getInt(1));
   		    	room.setRoom_name(rs.getString(2));
   		    	room.setUser_id(rs.getString(3));
   		    	room.setSize(rs.getInt(4));
   		    	room.setCapacity(rs.getInt(5));
   		    	room.setUser_modate(rs.getString(7));
   		    	room.setBuilding(rs.getString(9));
   		    	room.setBuildingroom(rs.getString(10));
   		    	list.add(room);
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
   	return list;
   }
   public boolean nextPage(int pageNum){
	   String sql = "SELECT * FROM roomlist WHERE room_no < ? AND room_available = 1";
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
   
   public Roomlist getRoomList(String room_name){
	   String sql = "SELECT * FROM roomlist WHERE room_name = ?";
	   try {
   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
   		pstmt.setString(1, room_name); 
   		    rs = pstmt.executeQuery();
   		   if(rs.next()) {
   			Roomlist room = new Roomlist(); 
		    	room.setRoom_no(rs.getInt(1));
		    	room.setRoom_name(rs.getString(2));
		    	room.setUser_id(rs.getString(3));
		    	room.setSize(rs.getInt(4));
		    	room.setCapacity(rs.getInt(5));
		    	room.setUser_modate(rs.getString(7));
		    	room.setBuilding(rs.getString(9));
		    	room.setBuildingroom(rs.getString(10));
		    	return room;
   		    }
   } catch (Exception e) {
   	
   	e.printStackTrace();
   }
	   return null;
   }
   
   public Roomlist getRoom(int room_no) {
	   Roomlist info = null;
   	StringBuffer br = new StringBuffer();
		br.append("SELECT room_no, room_name, user_id, size, capacity, room_indate, room_modate, building, building_room ");
		br.append(" FROM roomlist");
		br.append(" WHERE room_no = ? ");
		try {
			 
			String sql = br.toString();
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			 pstmt.setInt(1, room_no);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new Roomlist();
				 info.setRoom_no(rs.getInt("room_no"));
				 info.setRoom_name(rs.getString("room_name"));
				 info.setUser_modate(rs.getString("room_modate"));
				 info.setSize(rs.getInt("size"));
				 info.setCapacity(rs.getInt("capacity"));
				 info.setUser_indate(rs.getString("room_indate"));
				 info.setUser_id(rs.getString("user_id"));
				 info.setBuilding(rs.getString("building"));
				 info.setBuildingroom(rs.getString("building_room"));
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info;
   }
   
   public int update(String room_name, int size, int capacity, String user_id, int room_no, String building, String buildingroom) {
	   String sql = "UPDATE roomlist SET room_name = ?,  room_modate= ?, size = ?, capacity = ?, user_id = ?, building = ?, building_room = ? WHERE room_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(8, room_no);
	   		pstmt.setString(1, room_name);
	   		pstmt.setString(2, getDate());
	   		pstmt.setInt(3, size);
	   		pstmt.setInt(4, capacity);
	   		pstmt.setString(7, buildingroom);
	   		pstmt.setString(6, building);
	   		pstmt.setString(5, user_id);
	   		
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public int delete(int room_no) {
	   String sql = "UPDATE roomlist SET room_available = 0 WHERE room_no = ?";
	   	try {
	   		  PreparedStatement pstmt = conn.prepareStatement(sql); 
	   		pstmt.setInt(1, room_no);
	   		   return pstmt.executeUpdate();
	   		    
	   } catch (Exception e) {
	   	
	   	e.printStackTrace();
	   }
	   	return -1;
	   }
   
   public ArrayList<Roomlist> getRoomArray(String building, String searchType, String search, int pageNum) {
	if(building.equals("전체")) {
		building = "";
	}
	
	ArrayList<Roomlist> roomlist = null;
	String SQL = "";
	
    try { 
    	if(searchType.equals("번호순")) {
    		SQL = "SELECT * FROM roomlist WHERE building LIKE ? AND CONCAT(room_name, user_id, size, capacity) LIKE" + 
    	"? ORDER BY room_no DESC LIMIT " + pageNum * 5 + ", " + pageNum * 5 + 6;
    	} else if(searchType.equals("수용인원순")) {
    		SQL = "SELECT * FROM roomlist WHERE building LIKE ? AND CONCAT(room_name, user_id, size, capacity) LIKE" + 
    	"? ORDER BY capacity DESC LIMIT "+ pageNum * 5 + ", " + pageNum * 5 + 6;
    	}
    	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
    	pstmt.setString(1, "%" + building + "%");
        pstmt.setString(2, "%" + search + "%");
        rs = pstmt.executeQuery();
        roomlist = new ArrayList<Roomlist>();
        while(rs.next()){
        	Roomlist room = new Roomlist(); 
		    	room.setRoom_no(rs.getInt(1));
		    	room.setRoom_name(rs.getString(2));
		    	room.setUser_id(rs.getString(3));
		    	room.setSize(rs.getInt(4));
		    	room.setCapacity(rs.getInt(5));
		    	room.setUser_modate(rs.getString(7));
   		    	room.setBuilding(rs.getString(9));
   		    	room.setBuildingroom(rs.getString(10));
   		    	roomlist.add(room);
        }
       
        
    } catch (Exception e) {
        e.printStackTrace();
    } 
    return roomlist; // DB 오류
    
}
   
   public int getRoomAvailable(int no) {
   	
   	StringBuffer br = new StringBuffer();
		br.append("SELECT room_available ");
		br.append(" FROM roomlist ");
		br.append("WHERE room_no = ?");
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
