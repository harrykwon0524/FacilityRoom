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
		request.getSession().setAttribute("messageType", "���� �޼���");
		request.getSession().setAttribute("messageContent", "��� ������ �Է��ϼ���.");
		 addr = "join.jsp";
		 response.sendRedirect(addr);
		 System.out.println("�Է� �ȵ�");
		    return;
	} else {
		String pattern = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[A-Z])(?=.*[a-z]).{6,12}$";
		Matcher mat = Pattern.compile(pattern).matcher(id);
		if(!mat.matches()) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "���̵� ������ �߸��Ǿ����ϴ�.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("���̵�");
		    return;
		}
		if(!pwd1.equals(pwd2)) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "��й�ȣ�� ���� ��ġ���� �ʽ��ϴ�.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("��й�ȣ�� �ȵ�");
		    return;
		} else {
			String regex = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{6,12}$";
			Matcher matcher = Pattern.compile(regex).matcher(pwd1);
	        if(!matcher.matches()) {
	        	request.getSession().setAttribute("messageType", "���� �޼���");
	    		request.getSession().setAttribute("messageContent", "��й�ȣ�� ����(��ҹ��� ����)�� ���ڷ� 6~12�ڸ��� ������ �մϴ�.");
	    		
	    		addr = "join.jsp";
	    		response.sendRedirect(addr);
	    		System.out.println("��й�ȣ ���� �ȵ�");
	    	    return;
	        }
	        	if(pwd1.contains(id)) {
	        		request.getSession().setAttribute("messageType", "���� �޼���");
	        		request.getSession().setAttribute("messageContent", "��й�ȣ�� ���̵� ���Խ�Ű�� �ȵ˴ϴ�.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("��й�ȣ ���̵� ���� �ȵ�");
	        	    return;
	        }
	        	if(pwd1.contains(" ")) {
	        		request.getSession().setAttribute("messageType", "���� �޼���");
	        		request.getSession().setAttribute("messageContent", "��й�ȣ�� ������ ���Խ�ų �� �����ϴ�.");
	        		
	        		addr = "join.jsp";
	        		response.sendRedirect(addr);
	        		System.out.println("��й�ȣ ���� �ȵ�");
	        	    return;
	        	}
		}
		if(pwd1.length() < 7) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "��й�ȣ�� ª���ϴ�.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("��й�ȣ ���� �ȵ�");
		    return;
		}
		
		if(!name.matches(".*[��-����-�Ӱ�-�R]+.*")) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "�̸��� �ѱ۸� �Է����ּ���.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			return;
		}
		
		if(!isValidPhone(phone)) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "��ȭ��ȣ�� �ٽ� �Է����ּ���.");
			
			addr = "'history.back()'";
			response.sendRedirect(addr);
			System.out.println("��ȭ��ȣ ���� �ȵ�");
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
			 System.out.println("�Ϸ�");
		    return;
		} else if(result == -1){

			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "�̹� �����ϴ� ȸ���Դϴ�.");
			
			addr = "join.jsp";
			response.sendRedirect(addr);
			System.out.println("data ����");
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
