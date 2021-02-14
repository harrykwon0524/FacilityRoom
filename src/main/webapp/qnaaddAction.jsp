<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "qna.QnaDAO" %>
<%@ page import = "qna.Qna" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="qna" class="qna.Qna" scope="page"></jsp:useBean>
<jsp:setProperty name="qna" property="title"/>
<jsp:setProperty name="qna" property="qna_content"/>
 <jsp:setProperty name="qna" property="category"/>

 
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
    int qna_no = -1;
    if(request.getParameter("qna_no") != null) {
    	qna_no = Integer.parseInt(request.getParameter("qna_no"));
    } else {
    	if(qna.getTitle() == null || qna.getQna_content() == null) {
	    	 PrintWriter script = response.getWriter();
	         script.println("<script>");
	         script.println("alert('입력이 안된 사항이 있습니다.')");
	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
	         script.println("</script>");
	    }

	    else {
	    	QnaDAO userDAO = new QnaDAO();
	    	
	    		int result = userDAO.add(qna.getTitle(), user_id, qna.getQna_content() , "공지");
	    		qna.setQna_available(1);
	    		
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
   	            script.println("location.href = 'qna.jsp'");
   	            script.println("</script>");
   	        }
   	    }
    }

   
        
        	    	
        	    			
        	    		
        	    	
        	         
   
    
        
      
    %>
 
</body>
</html>
