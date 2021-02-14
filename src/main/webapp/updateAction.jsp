<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
   <jsp:useBean id="roomlist" class="room.Roomlist" scope="page"></jsp:useBean>
<jsp:setProperty name="roomlist" property="room_name"/>

 
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
    String room_name = null;
    if(request.getParameter("room_name") != null) {
    	room_name = request.getParameter("room_name");
    }
    
    if(room_no == -1) {
   	 PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
   }
    RoomDAO dao = RoomDAO.getInstance();
    		Roomlist room = dao.getRoom(room_no);
   
    
   
  
    if(!user_id.equals(room.getUser_id())) {
    	 PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('권한이 필요합니다.')");
    	    script.println("location.href = 'bbs.jsp'");
    	    script.println("</script>");
    }
    else {
        if(request.getParameter("room_name") == null || Integer.parseInt(request.getParameter("capacity")) == 0 || request.getParameter("id") == null || Integer.parseInt(request.getParameter("size")) == 0||
        		request.getParameter("room_name").equals("") || request.getParameter("id").equals("") || request.getParameter("building") == null || request.getParameter("building").equals("") || request.getParameter("buildingroom") == null) {
        	    	 PrintWriter script = response.getWriter();
        	         script.println("<script>");
        	         script.println("alert('입력이 안된 사항이 있습니다.')");
        	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        	         script.println("</script>");
        	    }

        	    else {
        	    	
        	    	   
        	    			int result = dao.update(request.getParameter("room_name"),Integer.parseInt(request.getParameter("capacity")), Integer.parseInt(request.getParameter("size")), request.getParameter("id"), room_no,  request.getParameter("building"),request.getParameter("buildingroom") );
                	    	if(result == -1) {
                	    		PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('글 수정에 실패했습니다.')");
                	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	            script.println("</script>");
                	           
                	            
                	    	} 
                	    	else {
                	            PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('성공적으로 수정하였습니다.')");
                	            script.println("location.href = 'bbs.jsp'");
                	            script.println("</script>");
                	        }
                	    }
        	    		}
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
