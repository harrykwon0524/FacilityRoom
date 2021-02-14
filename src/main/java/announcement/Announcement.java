package announcement;

public class Announcement {
private int announcement_no;
private String announcement_title;
private int reported;


private String announcement_modate;
private String announcement_indate;
private String announcement_writer;
private String announcement_content;
private int announcement_available;
private int announcement_view;
public int getAnnouncement_no() {
	return announcement_no;
}
public void setAnnouncement_no(int announcement_no) {
	this.announcement_no = announcement_no;
}
public String getAnnouncement_title() {
	return announcement_title;
}
public void setAnnouncement_title(String announcement_title) {
	this.announcement_title = announcement_title;
}
public int getReported() {
	return reported;
}
public void setReported(int reported) {
	this.reported = reported;
}
public String getAnnouncement_modate() {
	return announcement_modate;
}
public void setAnnouncement__modate(String announcement_modate) {
	this.announcement_modate = announcement_modate;
}
public String getAnnouncement_indate() {
	return announcement_indate;
}
public void setAnnouncement_indate(String announcement_indate) {
	this.announcement_indate = announcement_indate;
}
public String getAnnouncement__writer() {
	return announcement_writer;
}
public void setAnnouncement__writer(String announcement_writer) {
	this.announcement_writer = announcement_writer;
}
public String getAnnouncement_content() {
	return announcement_content;
}
public void setAnnouncement_content(String announcement_content) {
	this.announcement_content = announcement_content;
}
public int getAnnouncement_available() {
	return announcement_available;
}
public void setAnnouncement__available(int announcement__available) {
	this.announcement_available = announcement__available;
}
public int getAnnouncement_view() {
	return announcement_view;
}
public void setAnnouncement_view(int announcement_view) {
	this.announcement_view = announcement_view;
}
public String getCategory() {
	return category;
}
public void setCategory(String category) {
	this.category = category;
}
private String category;

}