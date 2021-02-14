<%@page import="util.SHA256Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
    <%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
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
    if(user_id != null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('이미 로그인이 되어 있습니다.')");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
    }
    UserinfoDAO dao = UserinfoDAO.getInstance();
    if(request.getParameter("email") == null || request.getParameter("gender") == null
    	    || request.getParameter("phone") == null ||
    	    		request.getParameter("user_name") == null ||  request.getParameter("state") == null || request.getParameter("email_domain") == null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('정보가 누락되었습니다.')");
         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
         script.println("</script>");
    
    } else {
    	
    	 String id = dao.getId(request.getParameter("user_name"), request.getParameter("state"), request.getParameter("gender"), request.getParameter("phone"), 
    			 request.getParameter("email"), request.getParameter("email_domain"));
 		
         if (id != null){
             PrintWriter script = response.getWriter();
             script.println("<script>");
             script.println("alert('아이디는  " +  id + "입니다')");
             script.println("location.href = 'main.jsp'");
             script.println("</script>");
         } else {
        	 PrintWriter script = response.getWriter();
             script.println("<script>");
             script.println("alert('아이디가 존재하지 않습니다')");
             script.println("history.back()'");
             script.println("</script>");
         }
    }
	   
   
    
       
      
   
        
       
    %>
 
</body>
</html>
