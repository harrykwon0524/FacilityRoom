<%@page import="util.SHA256Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
    <%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

    <jsp:useBean id="userinfo" class="user.userinfo" scope="page"></jsp:useBean>
<jsp:setProperty name="userinfo" property="id"/>
<jsp:setProperty name="userinfo" property="pwd"/>
 <jsp:setProperty name="userinfo" property="gender"/>
<jsp:setProperty name="userinfo" property="state"/>
<jsp:setProperty name="userinfo" property="user_name"/>
<jsp:setProperty name="userinfo" property="email"/>
<jsp:setProperty name="userinfo" property="email_domain"/>
<jsp:setProperty name="userinfo" property="phone"/>  
<jsp:setProperty name="userinfo" property="salt"/>
<!DOCTYPE html>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 관리 페이지</title>
</head>
<body>
    <% String user_id = null;
    if(session.getAttribute("sessionID") != null) {
    	user_id = (String) session.getAttribute("sessionID");
    }

    UserinfoDAO dao = UserinfoDAO.getInstance();
    userinfo info = dao.getUserinfo(user_id);
    if(!user_id.equals(info.getid())) {
      	 PrintWriter script = response.getWriter();
      	    script.println("<script>");
      	    script.println("alert('동일인이여야 합니다.')");
      	    script.println("location.href = 'bbs.jsp'");
      	    script.println("</script>");
       }
    
    if(userinfo.getEmail() == null || userinfo.getGender() == null
    	    || userinfo.getPhone() == null ||
    	    userinfo.getUser_name() == null ||  userinfo.getState() == null || userinfo.getEmail_domain() == null) {
    	    	 PrintWriter script = response.getWriter();
    	         script.println("<script>");
    	         script.println("alert('입력이 안된 사항이 있습니다.')");
    	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
    	         script.println("</script>");
    } else {
        dao.modify(userinfo);
    	   session.setAttribute("sessionID", userinfo.getid());
    	    PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('수정되었습니다.')");
    	    script.println("location.href = 'main.jsp'");
    	    script.println("</script>");
    }
 

    %>
 
</body>
</html>
