<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "facility.FacilityDAO" %>
<%@ page import = "facility.Facility_Brief" %>
<%@ page import = "facility.Facility_BriefDAO" %>
<%@ page import = "user.UserinfoDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.ArrayList" %>
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
        
    	}
      
        	int room_no = 0;
        	if(request.getParameter("room_no") != null) {
        		room_no = Integer.parseInt(request.getParameter("room_no"));
        	}
        	if(room_no == -1) {
        		 PrintWriter script = response.getWriter();
                 script.println("<script>");
                 script.println("alert('강의실이 필요합니다.')");
                 script.println("location.href = 'bbs.jsp'");
                 script.println("</script>");
        	} 
        	int facility_no = -1;
        	if(request.getParameter("facility_no") != null) {
        		facility_no = Integer.parseInt(request.getParameter("facility_no"));
        	}
        	if(facility_no == -1) {
        		 PrintWriter script = response.getWriter();
                 script.println("<script>");
                 script.println("alert('자재가 필요합니다.')");
                 script.println("location.href = 'facility.jsp'");
                 script.println("</script>");
        	} 
        		if(request.getParameter("emailCheck") == null || Integer.parseInt(request.getParameter("amount")) == 0 || request.getParameter("company") == null || request.getParameter("model") == null || 
                		request.getParameter("fa_name") == null || request.getParameter("company") == null || request.getParameter("remarks") == null) {
                	    	 PrintWriter script = response.getWriter();
                	         script.println("<script>");
                	         script.println("alert('입력이 안된 사항이 있습니다.')");
                	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	         script.println("</script>");
                	    }

                	    else {
                	    	Facility_BriefDAO dao = new Facility_BriefDAO();
                	    	FacilityDAO d = new FacilityDAO();
                	    	if(d.getFacility(request.getParameter("fa_name")).getAmount() < Integer.parseInt(request.getParameter("amount"))) {
                	    		 PrintWriter script = response.getWriter();
                    	         script.println("<script>");
                    	         script.println("alert('개수 초과.')");
                    	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                    	         script.println("</script>");
                	    	} else {
                              	Facility_Brief fb = new Facility_Brief();
                                ArrayList<Facility_Brief> alist = new ArrayList<Facility_Brief>();
                                alist = dao.getF(room_no);
                                if(alist != null) {
                                	for(int i = 0; i < alist.size(); i++) {
                                		fb = alist.get(i);
                                		if(fb.getType().equals(request.getParameter("emailCheck"))) {
                                			PrintWriter script = response.getWriter();
                            	            script.println("<script>");
                            	            script.println("alert('이미 존재.')");
                            	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                            	            script.println("</script>");
                            	            return;
                                		}
                                	}
                                }
                                
                              		int result = dao.add(request.getParameter("emailCheck"),Integer.parseInt(request.getParameter("amount")), request.getParameter("fa_name"), room_no, facility_no);
                              	
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
