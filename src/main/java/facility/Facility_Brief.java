package facility;

public class Facility_Brief {
    private int roomlist_room_no;
    private int facility_no;
    private String type;
    private String name;
    private String insertdate;
    public String getInsertdate() {
		return insertdate;
	}
	public void setInsertdate(String insertdate) {
		this.insertdate = insertdate;
	}
	private int amount;
	public int getRoomlist_room_no() {
		return roomlist_room_no;
	}
	public void setRoomlist_room_no(int roomlist_room_no) {
		this.roomlist_room_no = roomlist_room_no;
	}
	public int getFacility_no() {
		return facility_no;
	}
	public void setFacility_no(int facility_no) {
		this.facility_no = facility_no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	

}