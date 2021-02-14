package lesson;

public class Lesson {

	private int roomlist_room_no;
	private int lesson_no;
	private String instructor;
	private String lesson_name;
	private String lesson_time;
	public int getRoomlist_room_no() {
		return roomlist_room_no;
	}
	public void setRoomlist_room_no(int roomlist_room_no) {
		this.roomlist_room_no = roomlist_room_no;
	}
	public int getLesson_no() {
		return lesson_no;
	}
	public void setLesson_no(int lesson_no) {
		this.lesson_no = lesson_no;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public String getLesson_name() {
		return lesson_name;
	}
	public void setLesson_name(String lesson_name) {
		this.lesson_name = lesson_name;
	}
	public String getLesson_time() {
		return lesson_time;
	}
	public void setLesson_time(String lesson_time) {
		this.lesson_time = lesson_time;
	}
}
