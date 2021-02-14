<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "util.SHA256Util" %>
<%@ page import = "user.UserinfoDAO" %>
    <%@ page import = "user.userinfo" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="userinfo" class="user.userinfo" scope="page"></jsp:useBean>
<jsp:setProperty name="userinfo" property="id"/>
<jsp:setProperty name="userinfo" property="pwd"/>
<jsp:setProperty name="userinfo" property="salt"/>
 

 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 관리 페이지</title>
</head>
<body>
    <%
    String user_id = null;
    if(session.getAttribute("sessionID") != null) {
    	user_id = (String) session.getAttribute("sessionID");
    }
    if(user_id == null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('로그인이 필요합니다.')");
         script.println("location.href = 'login.jsp'");
         script.println("</script>");
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
    
    SHA256Util util = new SHA256Util();

  
    String salt = dao.getSaltById(user_id);
    
    String opwd = dao.getUserinfo(user_id).getPwd();
    String newp = util.getEncrypt(request.getParameter("deletepwd"), salt);
    
    if(!opwd.equals(newp)) {
    	
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호 재입력.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
       
        
	} else {
		boolean result = dao.deleteUser(user_id);
    	if(result == false) {
    		PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('아이디 삭제에 실패했습니다.')");
            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
           
            
    	} 
    	else {
            PrintWriter script = response.getWriter();
            session.setAttribute("sessionID", null);
            script.println("<script>");
            script.println("alert('성공적으로 삭제하였습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
	}
        	    	
        	    			
                	    
        	    		
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
