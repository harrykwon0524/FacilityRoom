<%@page import="room.Roomlist"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "room.RoomDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="room" class="room.Roomlist" scope="page"></jsp:useBean>
<jsp:setProperty name="room" property="room_name"/>
<jsp:setProperty name="room" property="capacity"/>
 <jsp:setProperty name="room" property="user_id"/>
  
  <jsp:setProperty name="room" property="building"/>
   <jsp:setProperty name="room" property="buildingroom"/>
  <jsp:setProperty name="room" property="size"/>
 
 
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
    int room_no = 0;
    if(request.getParameter("room_no") != null) {
    	room_no = Integer.parseInt(request.getParameter("room_no"));
    }
    else {
        if(room.getCapacity() == 0 || room.getSize() == 0 || room.getUser_id() == null || room.getRoom_name() == null || room.getBuilding() == null || room.getBuildingroom() == null) {
        	    	 PrintWriter script = response.getWriter();
        	         script.println("<script>");
        	         script.println("alert('입력이 안된 사항이 있습니다.')");
        	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        	         script.println("</script>");
        	    }

        	    else {
        	    	if(!room.getRoom_name().matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
        	    		 PrintWriter script = response.getWriter();
            	         script.println("<script>");
            	         script.println("alert('한글로 입력해야 합니다.')");
            	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            	         script.println("</script>");
        	    	} else {
        	    		RoomDAO userDAO = new RoomDAO();
            	    	Roomlist ro = new Roomlist();
            	    	String roomno = null;
            	    	for(int i = 0; i < userDAO.maxNum(); i++) {
            	    		ro = userDAO.getRoom(i);
            	    		roomno = ro.getBuildingroom();
            	    		if(roomno.equals(room.getBuildingroom()) && room.getBuilding().equals(ro.getBuilding()) ) {
                	    		PrintWriter script = response.getWriter();
                   	         script.println("<script>");
                   	         script.println("alert('이미 등록된 호실입니다.')");
                   	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                   	         script.println("</script>");
                   	         return;
                	    	}
            	    	}
            	    	
            	    		int result = userDAO.add(room.getRoom_name(), room.getUser_id(), room.getSize(), room.getCapacity(), room.getBuilding(), room.getBuildingroom());
            	    		userDAO.getRoom(room_no).setRoom_available(1);
                	    	if(result == -1) {
                	    		PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('글쓰기에 실패했습니다.')");
                	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	            script.println("</script>");
                	           
                	            
                	    	} 
                	    	else {
                	            PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('성공적으로 작성하였습니다.')");
                	            script.println("location.href = 'bbs.jsp'");
                	            script.println("</script>");
                	        }
                	    }
        	    	}
        	    	
        	    	}
        	    			
        	    		
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
