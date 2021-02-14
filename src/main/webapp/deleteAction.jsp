<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 

 
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
    int room_no = -1;
    if(request.getParameter("room_no") != null) {
    	room_no = Integer.parseInt(request.getParameter("room_no"));
    }
    RoomDAO dao = RoomDAO.getInstance();
    Roomlist room =  dao.getRoom(room_no);
    if(room_no == -1) {
    	 PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('유효하지 않습니다.')");
    	    script.println("location.href = 'bbs.jsp'");
    	    script.println("</script>");
    }
    if(!user_id.equals(room.getUser_id())) {
    	 PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('권한이 필요합니다.')");
    	    script.println("location.href = 'bbs.jsp'");
    	    script.println("</script>");
    }
    else {
   

        	    	RoomDAO userDAO = new RoomDAO();
        	    	
        	    			int result = userDAO.delete(room_no);
        	    			room.setRoom_available(0);
                	    	if(result == -1) {
                	    		PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('글 삭제에 실패했습니다.')");
                	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	            script.println("</script>");
                	           
                	            
                	    	} 
                	    	else {
                	            PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('성공적으로 삭제하였습니다.')");
                	            script.println("location.href = 'bbs.jsp'");
                	            script.println("</script>");
                	        }
                	    }
        	    		
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
