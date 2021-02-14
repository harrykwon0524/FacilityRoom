package qna;

public class Qna {
private int qna_no;
private String title;
private int reported;

public int getReported() {
	return reported;
}
public void setReported(int reported) {
	this.reported = reported;
}
public int getQna_no() {
	return qna_no;
}
public void setQna_no(int qna_no) {
	this.qna_no = qna_no;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getQna_modate() {
	return qna_modate;
}
public void setQna_modate(String qna_modate) {
	this.qna_modate = qna_modate;
}
public String getQna_indate() {
	return qna_indate;
}
public void setQna_indate(String qna_indate) {
	this.qna_indate = qna_indate;
}
public String getQna_writer() {
	return qna_writer;
}
public void setQna_writer(String qna_writer) {
	this.qna_writer = qna_writer;
}
public String getQna_content() {
	return qna_content;
}
public void setQna_content(String qna_content) {
	this.qna_content = qna_content;
}
private String qna_modate;
private String qna_indate;
private String qna_writer;
private String qna_content;
private int qna_available;
private int viewcnt;
private String category;
private String reportTitle;
private String reportContent;

public String getReportTitle() {
	return reportTitle;
}
public void setReportTitle(String reportTitle) {
	this.reportTitle = reportTitle;
}
public String getReportContent() {
	return reportContent;
}
public void setReportContent(String reportContent) {
	this.reportContent = reportContent;
}
public String getCategory() {
	return category;
}
public void setCategory(String category) {
	this.category = category;
}
public int getViewcnt() {
	return viewcnt;
}
public void setViewcnt(int viewcnt) {
	this.viewcnt = viewcnt;
}
public int getQna_available() {
	return qna_available;
}
public void setQna_available(int qna_available) {
	this.qna_available = qna_available;
}
}
