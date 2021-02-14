<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
    <%@ page import = "user.UserinfoDAO" %>
    <%@ page import = "user.userinfo" %>
           <%@ page import = "facility.FacilityDAO" %>
       <%@ page import = "facility.Facility" %>
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
    int facility_no = 0;
    if(request.getParameter("facility_no") != null) {
    	facility_no = Integer.parseInt(request.getParameter("facility_no"));
    }
    String room_name = null;
    if(request.getParameter("room_name") != null) {
    	room_name = request.getParameter("room_name");
    }
    
    if(facility_no == -1) {
   	 PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 자재입니다.')");
        script.println("location.href = 'facility.jsp'");
        script.println("</script>");
   }
    FacilityDAO dao = FacilityDAO.getInstance();
    	Facility fa = dao.getF(facility_no);

    		UserinfoDAO da = UserinfoDAO.getInstance();
    		userinfo info = da.getUserinfo(user_id);
    			if(!info.getState().equals("관리")){
    			PrintWriter script = response.getWriter();
    		    script.println("<script>");
    		    script.println("alert('관리자만 접속 가능합니다.')");
    		    script.println("history.back()");    // 이전 페이지로 사용자를 보냄
    		    script.println("</script>");
    		}
    		
    
    else {
        if(request.getParameter("type") == null || Integer.parseInt(request.getParameter("amount")) == 0 || request.getParameter("serial") == null || request.getParameter("model") == null||
        		request.getParameter("company").equals("") || request.getParameter("remarks").equals("") || request.getParameter("fa_name") == null) {
        	    	 PrintWriter script = response.getWriter();
        	         script.println("<script>");
        	         script.println("alert('입력이 안된 사항이 있습니다.')");
        	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        	         script.println("</script>");
        	    }

        	    else {
        	    	
        	    	   
        	    			int result = dao.update(request.getParameter("type"), Integer.parseInt(request.getParameter("amount")), request.getParameter("serial"), request.getParameter("model"), request.getParameter("company"), request.getParameter("remarks"), request.getParameter("fa_name"), facility_no);
        	    			
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
                	            script.println("location.href = 'facility.jsp'");
                	            script.println("</script>");
                	        }
                	    }
        	    		}
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
