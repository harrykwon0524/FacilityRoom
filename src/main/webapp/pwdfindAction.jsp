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
    if(session.getAttribute("sessionID") != null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('이미 로그인이 되어 있습니다.')");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
    }
    UserinfoDAO dao = new UserinfoDAO();
    userinfo = dao.getUserinfo(userinfo.getid());
    if(userinfo == null) {
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디가 틀립니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
   } else {
	   int chk = dao.getUserEmailChecked(userinfo.getid());
	    if(chk == 0) {
	   	 PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('인증이 필요합니다.')");
	        script.println("location.href = 'emailSendAction.jsp'");    // 이전 페이지로 사용자를 보냄
	        script.println("</script>");
	        return;
	   } else {
		   
	   
	        UserinfoDAO userDAO = new UserinfoDAO();
	     
	        		
	        if (userinfo != null){
	        	
	        	session.setAttribute("newID", userinfo.getid());
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('확인되었습니다. 저장된 메일로 링크가 갑니다 확인 해주세요')");
	            script.println("location.href = 'emailPwdSendAction.jsp'");
	            script.println("</script>");
	        } else {
	        	PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('인증되었습니다. 저장된 메일로 링크가 갑니다 확인 해주세요')");
	            script.println("location.href = 'pwdfind.jsp'");
	            script.println("</script>");
	      
	        
	   }
   }
	    
   }
    
        
       
    %>
 
</body>
</html>
