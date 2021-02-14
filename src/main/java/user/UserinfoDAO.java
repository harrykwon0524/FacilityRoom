package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
 
public class UserinfoDAO {
    
    private Connection conn;            // DB에 접근하는 객체
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static UserinfoDAO instance;
    
    public UserinfoDAO(){
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
    
    public static Connection getConnection() {
		Connection conn = null;
		String dbURL = "jdbc:mysql://localhost:3306/managefacility";
        String dbID = "root";
        String dbPassword = "Hyungtaek!123";
		try {
			//드라이버 로드
			Class.forName("com.mysql.jdbc.Driver");
			//커넥션 가져오기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return conn;
	}
    
    public static UserinfoDAO getInstance() {
    	if(instance == null)
    		instance = new UserinfoDAO();
    	return instance;
    }
    
    public int login(String userID, String userPassword) {
        String SQL = "SELECT pwd FROM userinfo WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(userPassword))
                    return 1;    // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
           
            return -1; // ID가 없음
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return -2; // DB 오류
        
    }
    
    public int join(String id, String pwd1, String name, String gender, String state, String email, String phone, String salt, String email_domain, boolean emailcheck) {
    	StringBuffer br = new StringBuffer();
    	br.append("INSERT INTO userinfo VALUES (" + maxArticleNo() + ",?,NOW(), ?, ?, ?, ?, ?, NOW(), ?, ?, ?, 1, 0)");
    	try {
    		  String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, name);
			 pstmt.setString(2, pwd1);
			 pstmt.setString(3, phone);
			 pstmt.setString(4, email);
			 pstmt.setString(5, state);
			 pstmt.setString(6, gender);
			 pstmt.setString(7, id);
			 pstmt.setString(8, salt);
			 pstmt.setString(9, email_domain);
			 return pstmt.executeUpdate();
		} catch (Exception e) {
            e.printStackTrace();
        } 
        	
		return -1;
    }
    public int maxArticleNo() {
    	
    	StringBuffer buffer = new StringBuffer();
		buffer.append("SELECT * FROM userinfo order by length(user_no) DESC, user_no DESC; ");
		try {
			String sql = buffer.toString();
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
    
    public void modify(userinfo info) {
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE userinfo ");
		br.append(" SET user_name =?, user_modate = NOW(),  phone =?, email = ?, state = ?, gender =?,email_domain = ?");
		br.append("WHERE id = ?");
		try {
  		  String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, info.getUser_name());
			 pstmt.setString(2, info.getPhone());
			 pstmt.setString(3, info.getEmail());
			 pstmt.setString(4, info.getState());
			 pstmt.setString(5, info.getGender());
			 pstmt.setString(6, info.getEmail_domain());
			 pstmt.setString(7, info.getid());
			 pstmt.executeUpdate();
    }catch (Exception e) {
        e.printStackTrace();
    } 
    
 
}
    
    public userinfo getUserinfo(String id) {
    	userinfo info = null;
    	StringBuffer br = new StringBuffer();
		br.append("SELECT user_no, user_name, user_modate, pwd, phone, email, state, gender, user_indate, id, email_domain ");
		br.append(" FROM userinfo");
		br.append(" WHERE id = ? ");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, id);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new userinfo();
				 info.setUser_no(rs.getInt("user_no"));
				 info.setUser_name(rs.getString("user_name"));
				 info.setUser_modate(rs.getString("user_modate"));
				 info.setPwd(rs.getString("pwd"));
				 info.setPhone(rs.getString("phone"));
				 info.setEmail(rs.getString("email"));
				 info.setState(rs.getString("state"));
				 info.setGender(rs.getString("gender"));
				 info.setUser_indate(rs.getString("user_indate"));
				 info.setid(rs.getString("id"));
				 info.setEmail_domain(rs.getString("email_domain"));
				
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info;
    }
    
    public int registerCheck(String id) {
    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	String sql = "SELECT * FROM userinfo WHERE id = ?";
    	try {
    		pst = conn.prepareStatement(sql);
    		pst.setString(1, id);
    		rs = pst.executeQuery();
    		String pattern = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[A-Z])(?=.*[a-z]).{6,12}$";
    		Matcher mat = Pattern.compile(pattern).matcher(id);
    		if(rs.next() || id.equals("") || !mat.matches()) {
    			return 0;
    		}else {
        		return 1;
    			
    	}
    
    } catch (Exception e) {
    	e.printStackTrace();
    } finally {
    	try {
    		if(rs != null) rs.close();
    		if(pst != null) pst.close();
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    }
     return -1;
    
     
    }
    
    public String getSaltById(String id) {
    	userinfo info = null;
    	String salt = null;
    	StringBuffer br = new StringBuffer();
		br.append("SELECT salt ");
		br.append(" FROM userinfo");
		br.append(" WHERE id = ? ");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, id);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new userinfo();
				 info.setSalt(rs.getString("salt"));
//				 
//				 info.setUser_no(rs.getInt("user_no"));
//				 info.setUser_name(rs.getString("user_name"));
//				 info.setUser_modate(rs.getString("user_modate"));
//				 info.setPwd(rs.getString("pwd"));
//				 info.setPhone(rs.getString("phone"));
//				 info.setEmail(rs.getString("email"));
//				 info.setState(rs.getString("state"));
//				 info.setGender(rs.getString("gender"));
//				 info.setUser_indate(rs.getString("user_indate"));
//				 info.setid(rs.getString("id"));
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info.getSalt();
    }
    
    public int getUserEmailChecked(String userID) {
    	String SQL = "SELECT emailcheck FROM userinfo WHERE id = ?";

    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	try {

    		pst = conn.prepareStatement(SQL);
    		pst.setString(1, userID);
    		rs = pst.executeQuery();
    		while(rs.next()) {
    			return rs.getInt(1);
    		}
     	} catch (Exception e) {
     		e.printStackTrace();
     	} 
    	return 0;
     		}
     	
     		
    public String getEmail(String userID) {
    	String SQL = "SELECT email,  email_domain FROM userinfo WHERE id = ?";
    	userinfo info = null;
    	try {
    		pstmt = conn.prepareStatement(SQL);
			 pstmt.setString(1, userID);
			 rs = pstmt.executeQuery();
    		while(rs.next()) {
    			 info = new userinfo();
    			 info.setEmail(rs.getString("email"));
    			 info.setEmail_domain(rs.getString("email_domain"));
    		}
     	} catch (Exception e) {
     		e.printStackTrace();
     	} 
    	return info.getEmail() + "@" + info.getEmail_domain();
     		}
    
    
    
    public boolean setUserEmailChecked(String userID) {
    	String SQL = "UPDATE userinfo SET emailcheck = 1 WHERE id = ?";
    
    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	try {
    	
    		pst = conn.prepareStatement(SQL);
    		pst.setString(1, userID);
    		 pst.executeUpdate();
        		return true;
     	} catch (Exception e) {
     		e.printStackTrace();
     	} finally {
     		try {if(conn != null) conn.close();} catch(Exception e) {  e.printStackTrace();			}
     		try {if(pst != null) pst.close(); }catch(Exception e) {  e.printStackTrace();			}
     		try {if(rs != null) rs.close(); }catch(Exception e) {  e.printStackTrace();			}
     		}
    	return false;
     		}
    
    public boolean setReset(String userID) {
    	String SQL = "UPDATE userinfo SET pwdreset = true WHERE id = ?";
    	Connection conn = null;
    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	try {
    		conn = getConnection();
    		pst = conn.prepareStatement(SQL);
    		pst.setString(1, userID);
    		pst.executeUpdate();
    		return true;
    		
     	} catch (Exception e) {
     		e.printStackTrace();
     	} finally {
     		try {if(conn != null) conn.close();} catch(Exception e) {  e.printStackTrace();			}
     		try {if(pst != null) pst.close(); }catch(Exception e) {  e.printStackTrace();			}
     		try {if(rs != null) rs.close(); }catch(Exception e) {  e.printStackTrace();			}
     		}
    	return false;
     		}
    
    public boolean getPwdReset(String userID) {
    	String SQL = "SELECT pwdreset FROM userinfo WHERE id = ?";
    	Connection conn = null;
    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	try {
    		conn = getConnection();
    		pst = conn.prepareStatement(SQL);
    		pst.setString(1, userID);
    		rs = pst.executeQuery();
    		while(rs.next()) {
    			return rs.getBoolean(1);
    		}
     	} catch (Exception e) {
     		e.printStackTrace();
     	} 
    	return false;
     		}
    
    public String getId(String name, String state, String gender, String phone, String email, String domain) {
    	userinfo info = null;
    	StringBuffer br = new StringBuffer();
		br.append("SELECT id ");
		br.append(" FROM userinfo");
		br.append(" WHERE user_name = ? AND state = ? AND gender = ? AND phone = ? AND email = ? AND email_domain = ?");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, name);
			 pstmt.setString(2, state);
			 pstmt.setString(3, gender);
			 pstmt.setString(4, phone);
			 pstmt.setString(5, email);
			 pstmt.setString(6, domain);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new userinfo();
				 info.setid(rs.getString("id"));
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info.getid();
    }
    
    public int resetPwd(String id, String pwd) {
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE userinfo ");
		br.append(" SET  user_modate = NOW(),  pwd = ?");
		br.append("WHERE id = ?");
		try {
  		  String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, pwd);
			 pstmt.setString(2, id);
			 return pstmt.executeUpdate();
    }catch (Exception e) {
        e.printStackTrace();
    } 
		return -1;
    }
    
    public void updateSalt(String id, String salt) {
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE userinfo ");
		br.append(" SET salt = ?");
		br.append("WHERE id = ?");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, salt);
			 pstmt.setString(2, id);
			 pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
    }
    
    public boolean deleteUser(String id) {
    	
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE userinfo ");
		br.append(" SET useravailable = 0");
		br.append(" WHERE id = ?");
		try {
			String sql = br.toString();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
return true;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
     		try {if(conn != null) conn.close();} catch(Exception e) {  e.printStackTrace();			}
     		try {if(pstmt != null) pstmt.close(); }catch(Exception e) {  e.printStackTrace();			}
     		try {if(rs != null) rs.close(); }catch(Exception e) {  e.printStackTrace();			}
     		}
		return false;
}
    
    public int getUserAvailable(String id) {
    	
    	StringBuffer br = new StringBuffer();
		br.append("SELECT useravailable ");
		br.append(" FROM userinfo ");
		br.append("WHERE id = ?");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, id);
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
