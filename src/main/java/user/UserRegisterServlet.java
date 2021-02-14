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
		request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
		request.getSession().setAttribute("messageContent", "¸ðµç ³»¿ëÀ» ÀÔ·ÂÇÏ¼¼¿ä.");
		 addr = "join.jsp";
		 response.sendRedirect(addr);
		 System.out.println("ÀÔ·Â ¾ÈµÊ");
		    return;
	} else {
		String pattern = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[A-Z])(?=.*[a-z]).{6,12}$";
		Matcher mat = Pattern.compile(pattern).matcher(id);
		if(!mat.matches()) {
			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "¾ÆÀÌµð Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("¾ÆÀÌµð");
		    return;
		}
		if(!pwd1.equals(pwd2)) {
			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "ºñ¹Ð¹øÈ£°¡ ¼­·Î ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("ºñ¹Ð¹øÈ£°¡ ¾ÈµÊ");
		    return;
		} else {
			String regex = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{6,12}$";
			Matcher matcher = Pattern.compile(regex).matcher(pwd1);
	        if(!matcher.matches()) {
	        	request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
	    		request.getSession().setAttribute("messageContent", "ºñ¹Ð¹øÈ£´Â ¿µ¾î(´ë¼Ò¹®ÀÚ Æ÷ÇÔ)¿Í ¼ýÀÚ·Î 6~12ÀÚ¸®·Î ¸¸µé¾î¾ß ÇÕ´Ï´Ù.");
	    		
	    		addr = "join.jsp";
	    		response.sendRedirect(addr);
	    		System.out.println("ºñ¹Ð¹øÈ£ Á¶°Ç ¾ÈµÊ");
	    	    return;
	        }
	        	if(pwd1.contains(id)) {
	        		request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
	        		request.getSession().setAttribute("messageContent", "ºñ¹Ð¹øÈ£´Â ¾ÆÀÌµð¸¦ Æ÷ÇÔ½ÃÅ°¸é ¾ÈµË´Ï´Ù.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("ºñ¹Ð¹øÈ£ ¾ÆÀÌµð Á¶°Ç ¾ÈµÊ");
	        	    return;
	        }
	        	if(pwd1.contains(" ")) {
	        		request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
	        		request.getSession().setAttribute("messageContent", "ºñ¹Ð¹øÈ£´Â °ø¹éÀ» Æ÷ÇÔ½ÃÅ³ ¼ö ¾ø½À´Ï´Ù.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("ºñ¹Ð¹øÈ£ °ø¹é ¾ÈµÊ");
	        	    return;
	        	}
		}
		if(pwd1.length() < 7) {
			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "ºñ¹Ð¹øÈ£°¡ Âª½À´Ï´Ù.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("ºñ¹Ð¹øÈ£ ±æÀÌ ¾ÈµÊ");
		    return;
		}
		
		if(!name.matches(".*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*")) {
			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "ÀÌ¸§¿£ ÇÑ±Û¸¸ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			return;
		}
		
		if(!isValidPhone(phone)) {
			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "ÀüÈ­¹øÈ£¸¦ ´Ù½Ã ÀÔ·ÂÇØÁÖ¼¼¿ä.");
			
			addr = "'history.back()'";
			response.sendRedirect(addr);
			System.out.println("ÀüÈ­¹øÈ£ ±æÀÌ ¾ÈµÊ");
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
			 System.out.println("¿Ï·á");
		    return;
		} else if(result == -1){

			request.getSession().setAttribute("messageType", "¿À·ù ¸Þ¼¼Áö");
			request.getSession().setAttribute("messageContent", "ÀÌ¹Ì Á¸ÀçÇÏ´Â È¸¿øÀÔ´Ï´Ù.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("data ¿À·ù");
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
