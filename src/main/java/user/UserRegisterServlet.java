package user;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.SHA256Util;

public class UserRegisterServlet extends HttpServlet{
private static final long serialVersionUID = 1L;


public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String id = request.getParameter("id").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String pwd1 = request.getParameter("pwd1").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String pwd2 = request.getParameter("pwd2").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String name = request.getParameter("name").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String gender = request.getParameter("gender").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String state = request.getParameter("state").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String email = request.getParameter("email").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String phone = request.getParameter("phone").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
	String email_domain =  request.getParameter("email_domain").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
    String addr = "";
	
	if(id == null || id.equals("") || pwd1 == null || pwd1.equals("") ||
			pwd2 == null || pwd2.equals("") || name == null || name.equals("") ||
			gender == null || gender.equals("") || state == null || state.equals("") ||
					email == null || email.equals("") || email_domain == null || email_domain.equals("")) {
		request.getSession().setAttribute("messageType", "오류 메세지");
		request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
		 addr = "join.jsp";
		 response.sendRedirect(addr);
		 System.out.println("입력 안됨");
		    return;
	} else {
		String pattern = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[A-Z])(?=.*[a-z]).{6,12}$";
		Matcher mat = Pattern.compile(pattern).matcher(id);
		if(!mat.matches()) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "아이디 형식이 잘못되었습니다.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("아이디");
		    return;
		}
		if(!pwd1.equals(pwd2)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 일치하지 않습니다.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("비밀번호가 안됨");
		    return;
		} else {
			String regex = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{6,12}$";
			Matcher matcher = Pattern.compile(regex).matcher(pwd1);
	        if(!matcher.matches()) {
	        	request.getSession().setAttribute("messageType", "오류 메세지");
	    		request.getSession().setAttribute("messageContent", "비밀번호는 영어(대소문자 포함)와 숫자로 6~12자리로 만들어야 합니다.");
	    		
	    		addr = "join.jsp";
	    		response.sendRedirect(addr);
	    		System.out.println("비밀번호 조건 안됨");
	    	    return;
	        }
	        	if(pwd1.contains(id)) {
	        		request.getSession().setAttribute("messageType", "오류 메세지");
	        		request.getSession().setAttribute("messageContent", "비밀번호는 아이디를 포함시키면 안됩니다.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("비밀번호 아이디 조건 안됨");
	        	    return;
	        }
	        	if(pwd1.contains(" ")) {
	        		request.getSession().setAttribute("messageType", "오류 메세지");
	        		request.getSession().setAttribute("messageContent", "비밀번호는 공백을 포함시킬 수 없습니다.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("비밀번호 공백 안됨");
	        	    return;
	        	}
		}
		if(pwd1.length() < 7) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 짧습니다.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("비밀번호 길이 안됨");
		    return;
		}
		
		if(!name.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "이름엔 한글만 입력해주세요.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			return;
		}
		
		if(!isValidPhone(phone)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "전화번호를 다시 입력해주세요.");
			
			addr = "'history.back()'";
			response.sendRedirect(addr);
			System.out.println("전화번호 길이 안됨");
		    return;
		}
		
		


		
	    String salt = SHA256Util.generateSalt();
	    String newp = SHA256Util.getEncrypt(pwd1, salt);
	    pwd1 = newp;
	    
	    
		int result = new UserinfoDAO().join(id, pwd1, name, gender, state, email, phone, salt, email_domain, false);
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("newID", id);
			request.setAttribute("id", id);
			
			addr = "";
			 try {

			    } catch (Exception e) {
			    	addr = "join.jsp";
			    } finally {
			    	addr = "emailSendAction.jsp";
			    }
			 RequestDispatcher dd=request.getRequestDispatcher(addr);
			 dd.forward(request, response);
			 System.out.println("완료");
		    return;
		} else if(result == -1){

			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "이미 존재하는 회원입니다.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("data 오류");
		    return;
		}
		
		
	}
	}
	



public boolean isValidPhone(String phone) {
	boolean err = false;
	String regex = "^01(?:0|1|[6-9])(?:\\d{4})\\d{4}$";
	Pattern p = Pattern.compile(regex);
	  Matcher m = p.matcher(phone);
	if(m.matches()) {
		   err = true; 
		  }
		  return err;
		 }


}
