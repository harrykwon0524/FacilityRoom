<%@ page import = "util.SHA256Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserinfoDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

 
<jsp:useBean id="userinfo" class="user.userinfo" scope="page"></jsp:useBean>
<jsp:setProperty name="userinfo" property="id"/>
<jsp:setProperty name="userinfo" property="pwd"/>
<jsp:setProperty name="userinfo" property="salt"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 관리 페이지</title>
</head>
<body>
<%

    String user_id = null;
    if(session.getAttribute("newID") != null) {
    	user_id = (String) session.getAttribute("newID");
    }
    String pwd = null;
    if(request.getAttribute("pwd1") != null) {
    	pwd = (String) request.getAttribute("pwd1");
    }
    if(session.getAttribute("sessionID") != null) {
   	 PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어 있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
   }
    
	   SHA256Util util = new SHA256Util();
	   UserinfoDAO userDAO = new UserinfoDAO();
	   
	   String osalt = userDAO.getSaltById(user_id);

	   String opwd = userDAO.getUserinfo(user_id).getPwd();
	   String newp = util.getEncrypt(request.getParameter("newpwd1"), osalt);
	   
	 
	  if(opwd.equals(newp)) {
		  PrintWriter script = response.getWriter();
          script.println("<script>");
          script.println("alert('옛날 비밀번호는 재사용 불가능합니다')");
          script.println("history.back()");    // 이전 페이지로 사용자를 보냄
          script.println("</script>");
	  } else {
		  String salt =util.generateSalt();
		  String newpwd = util.getEncrypt(request.getParameter("newpwd1"), salt);
		   userDAO.updateSalt(user_id, salt);
		  int result= userDAO.resetPwd(user_id, newpwd);
		  if (result ==1){
		      	session.setAttribute("sessionID", user_id);
		          PrintWriter script = response.getWriter();
		          script.println("<script>");
		          script.println("alert('변경되ㅓㅆ습니다.')");
		          script.println("location.href = 'main.jsp'");
		          script.println("</script>");
		      } else if(result == 0) {
		    	  PrintWriter script = response.getWriter();
		          script.println("<script>");
		          script.println("alert('다시.')");
		          script.println("history.back()");    // 이전 페이지로 사용자를 보냄
		          script.println("</script>");
		      }else if (result == -1){
		          PrintWriter script = response.getWriter();
		          script.println("<script>");
		          script.println("alert('이상.')");
		          script.println("history.back()");    // 이전 페이지로 사용자를 보냄
		          script.println("</script>");
		      }
	  }
	
   
    
   
    
   
    %>
    
</body>
</html>