package facility;

public class Facility {

	private int facility_no;
	public int getFacility_no() {
		return facility_no;
	}
	public void setFacility_no(int facility_no) {
		this.facility_no = facility_no;
	}
	private String type;
	private int amount;
	private String serial;
	private String model;
	private String company;
	private String remarks;
	private String fa_name;
	private String buy_date;
	private int facility_available;
	
	
	public int getFacility_available() {
		return facility_available;
	}
	public void setFacility_available(int facility_available) {
		this.facility_available = facility_available;
	}
	public String getBuy_date() {
		return buy_date;
	}
	public void setBuy_date(String buy_date) {
		this.buy_date = buy_date;
	}
	private String in_date;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getFa_name() {
		return fa_name;
	}
	public void setFa_name(String fa_name) {
		this.fa_name = fa_name;
	}
	public String getIn_date() {
		return in_date;
	}
	public void setIn_date(String in_date) {
		this.in_date = in_date;
	}
}
