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
    if(session.getAttribute("sessionID") != null) {
    	user_id = (String) session.getAttribute("sessionID");
    }
    if(user_id != null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('이미 로그인이 되어 있습니다.')");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
    }
   
    UserinfoDAO dao = new UserinfoDAO();
    if(userinfo.getid() == null) {
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디를 입력하세요.')");
        script.println("location.href = 'login.jsp'");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
    } else {
    	if(userinfo.getPwd() == null) {
    		PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호를 입력하세요.')");
            script.println("location.href = 'login.jsp'");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
    	} else {
        		      UserinfoDAO userDAO = new UserinfoDAO();
        		        if(userDAO.getUserinfo(userinfo.getid()) == null) {
        		        	PrintWriter script = response.getWriter();
        		            script.println("<script>");
        		            script.println("alert('아이디가 존재하지 않습니다.')");
        		            script.println("location.href = 'login.jsp'");    // 이전 페이지로 사용자를 보냄
        		            script.println("</script>");
        		        } else {
        		        	int chk = userDAO.getUserEmailChecked(userinfo.getid());
        		        	if(chk == 0) {
        		        		PrintWriter script = response.getWriter();
            		            script.println("<script>");
            		            script.println("alert('인증이 필요합니다.')");
            		            script.println("location.href = 'emailSendAction.jsp'");    // 이전 페이지로 사용자를 보냄
            		            script.println("</script>");
        		        	} else {
        		        		int available = userDAO.getUserAvailable(userinfo.getid());
        		        		if(available == 0) {
        		        			PrintWriter script = response.getWriter();
                		            script.println("<script>");
                		            script.println("alert('탈퇴한 아이디입니다.')");
                		            script.println("location.href = 'login.jsp'");    // 이전 페이지로 사용자를 보냄
                		            script.println("</script>");
        		        		} else {
        		        			String salt = userDAO.getSaltById(userinfo.getid());
                    		        String newp = SHA256Util.getEncrypt(userinfo.getPwd(), salt);
                    		        int result = userDAO.login(userinfo.getid(), newp);
                    		        
                    		        if (result ==1){
                    		        	session.setAttribute("sessionID", userinfo.getid());
                    		            PrintWriter script = response.getWriter();
                    		            script.println("<script>");
                    		            script.println("location.href = 'main.jsp'");
                    		            script.println("</script>");
                    		        }
                    		        else if (result == 0){
                    		            PrintWriter script = response.getWriter();
                    		            script.println("<script>");
                    		            script.println("alert('비밀번호가 틀립니다.')");
                    		            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                    		            script.println("</script>");
                    		        }
                    		        else if (result == -1){
                    		            PrintWriter script = response.getWriter();
                    		            script.println("<script>");
                    		            script.println("alert('존재하지 않는 아이디입니다.')");
                    		            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                    		            script.println("</script>");
                    		        }
                    		        else if (result == -2){
                    		            PrintWriter script = response.getWriter();
                    		            script.println("<script>");
                    		            script.println("alert('DB 오류가 발생했습니다.')");
                    		            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                    		            script.println("</script>");
                    		        }
                    
                    
                	   }
                		        }
            		        	}
        		        		}
        		        		
        		        	
        		        
        		        
        		        
        		        
        		      
       
    	
    	
  
        
   }
        
       
    %>
 
</body>
</html>
