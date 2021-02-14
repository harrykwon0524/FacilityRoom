<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "facility.FacilityDAO" %>
<%@ page import = "user.UserinfoDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="facility" class="facility.Facility" scope="page"></jsp:useBean>
<jsp:setProperty name="facility" property="type"/>
 <jsp:setProperty name="facility" property="amount"/>
 <jsp:setProperty name="facility" property="serial"/>
 <jsp:setProperty name="facility" property="model"/>
 <jsp:setProperty name="facility" property="company"/>
 <jsp:setProperty name="facility" property="remarks"/>
 <jsp:setProperty name="facility" property="fa_name"/>
 
 
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


    else {
    	UserinfoDAO u = new UserinfoDAO();
   	if(!u.getUserinfo(user_id).getState().equals("관리")) {
    		 PrintWriter script = response.getWriter();
             script.println("<script>");
             script.println("alert('권한이 필요합니다.')");
             script.println("location.href = 'login.jsp'");
             script.println("</script>");
    	} else {
    		 if(facility.getType() == null || facility.getAmount() == 0 || facility.getCompany() == null || facility.getModel() == null || 
    	        		facility.getFa_name() == null || facility.getRemarks() == null || facility.getSerial() == null) {
    	        	    	 PrintWriter script = response.getWriter();
    	        	         script.println("<script>");
    	        	         script.println("alert('입력이 안된 사항이 있습니다.')");
    	        	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
    	        	         script.println("</script>");
    	        	    }

    	        	    else {
    	        	    	FacilityDAO dao = new FacilityDAO();
    	        	    	
    	        	    		int result = dao.add(facility.getType(), facility.getAmount(), facility.getSerial(), facility.getModel(), facility.getCompany(),  facility.getRemarks(), facility.getFa_name());
    	        	    		
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
    	            	            script.println("location.href = 'facility.jsp'");
    	            	            script.println("</script>");
    	            	        }
    	            	    }
    	}
       
        	    	}
        	    			
        	    		
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>