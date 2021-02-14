package user;



public class userinfo {

	private int user_no;
	private String user_name;
	private String user_indate;
	private String user_modate;
	
	private String pwd;
	private String phone;
	private String email;
	private String email_domain;
	
	private String emailhash;
	
	private int emailcheck;
	private int useravailable;
	
	public int getUseravailable() {
		return useravailable;
	}
	public void setUseravailable(int useravailable) {
		this.useravailable = useravailable;
	}
	public int getEmailcheck() {
		return emailcheck;
	}
	public void setEmailcheck(int emailcheck) {
		this.emailcheck = emailcheck;
	}
	public String getEmailhash() {
		return emailhash;
	}
	public void setEmailhash(String emailhash) {
		this.emailhash = emailhash;
	}
	public String getEmail_domain() {
		return email_domain;
	}
	public void setEmail_domain(String email_domain) {
		this.email_domain = email_domain;
	}
	private String state;
	private String gender;
	private String id;
	private String salt;
	
	
	
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getid() {
		return id;
	}
	public void setid(String id) {
		this.id = id;
	}
	
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_indate() {
		return user_indate;
	}
	public void setUser_indate(String user_indate) {
		this.user_indate = user_indate;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUser_modate() {
		return user_modate;
	}
	public void setUser_modate(String user_modate) {
		this.user_modate = user_modate;
	}
	
	
}
