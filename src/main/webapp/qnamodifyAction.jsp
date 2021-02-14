<%@page import="util.SHA256Util"%>
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
 <jsp:setProperty name="qna" property="qna_writer"/>
<!DOCTYPE html>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 관리 페이지</title>
</head>
<body>
    <% String user_id = null;
    if(session.getAttribute("sessionID") != null) {
    	user_id = (String) session.getAttribute("sessionID");
    }
    QnaDAO dao = QnaDAO.getInstance();
   
    int qna_no = -1;
    if(request.getParameter("qna_no") != null) {
    	qna_no = Integer.parseInt(request.getParameter("qna_no"));
    }
    if(qna_no == -1) {
      	 PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('유효하지 않은 글입니다.')");
           script.println("location.href = 'qna.jsp'");
           script.println("</script>");
      }
    Qna q =  dao.getQna(qna_no);
    if(user_id == null) {
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    if(!user_id.equals(q.getQna_writer())) {
   	 PrintWriter script = response.getWriter();
   	    script.println("<script>");
   	    script.println("alert('권한이 필요합니다.')");
   	    script.println("location.href = 'qna.jsp'");
   	    script.println("</script>");
   }

    
    	
    
    if(request.getParameter("title") == null || request.getParameter("title").equals("") || request.getParameter("category") == null || request.getParameter("qna_content") == null) {
   	 PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
   }
 else {
        dao.update(request.getParameter("title"), user_id, request.getParameter("qna_content") , request.getParameter("category"), qna_no);
    	  
    	    PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('수정되었습니다.')");
    	    script.println("location.href = 'qna.jsp'");
    	    script.println("</script>");
 }
 

    %>
 
</body>
</html>
