package room;

import java.sql.Timestamp;

public class Roomlist {
  
	
	private String room_name;
	private int room_no;
	private String user_id;
	private int size;
	private int capacity;
	private String user_indate;
	private String user_modate;
	private int room_available;
	private String building;
	private String buildingroom;
	public String getBuildingroom() {
		return buildingroom;
	}
	public void setBuildingroom(String buildingroom) {
		this.buildingroom = buildingroom;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getUser_indate() {
		return user_indate;
	}
	public void setUser_indate(String user_indate) {
		this.user_indate = user_indate;
	}
	public String getUser_modate() {
		return user_modate;
	}
	public void setUser_modate(String user_modate) {
		this.user_modate = user_modate;
	}
	public int getRoom_available() {
		return room_available;
	}
	public void setRoom_available(int room_available) {
		this.room_available = room_available;
	}
//	public Roomlist(int room_no, String room_name,  String user_id, int size, int capacity, String user_indate,
//			String user_modate, int room_available, String building) {
//		
//		this.room_name = room_name;
//		this.room_no = room_no;
//		this.user_id = user_id;
//		this.size = size;
//		this.capacity = capacity;
//		this.user_indate = user_indate;
//		this.user_modate = user_modate;
//		this.room_available = room_available;
//		this.building = building;
//	}
//	
	
}
