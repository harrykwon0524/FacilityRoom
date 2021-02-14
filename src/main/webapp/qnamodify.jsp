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
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
<%
String category = "전체";
String sort = "번호순";
String search = "";
String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
} 
int qna_no = -1;
if(request.getParameter("qna_no") != null) {
	qna_no = Integer.parseInt(request.getParameter("qna_no"));
}
QnaDAO dao = QnaDAO.getInstance();
Qna q = dao.getQna(qna_no);
if(!user_id.equals(q.getQna_writer())) {
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('권한이 필요합니다.')");
	    script.println("location.href = 'qna.jsp'");
	    script.println("</script>");
}
%>
 <script type = "text/javascript">
 function SetCategory(emailValue) { // 사용자 입력
	  var emailTail = document.all("category") // Select box
	   
	  if ( emailValue == "notSelected" )
	   return;
	  else if ( emailValue == "etc" ) {
	   emailTail.readOnly = false;
	   emailTail.value = "";
	   emailTail.focus();
	  } else {
	   emailTail.readOnly = true;
	   emailTail.value = emailValue;
	  }
	 }s
</script>
</head>
<body>

    <nav class ="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">강의실 관리 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="bbs.jsp">강의실</a></li>
                    <li><a href="facility.jsp">자재 정보</a></li>
                   
                 <li><a href="qna.jsp">공지 사항</a></li>
                 <li><a href="report.jsp">신고 현황</a></li>
            </ul>
             <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">환영합니다<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li class="active"><a href="modify.jsp">정보수정</a></li>      
                        <li><a onclick = "return confirm('정말로 삭제하시겠습니까?')" href="iddelete.jsp">탈퇴</a></li>      
                        <li><a href="logoutAction.jsp">로그아웃</a></li>                  
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form method = "post" action="qnamodifyAction.jsp?qna_no=<%= qna_no %>">
                    <h3 style="text-align:center;">글 수정</h3>
                    <div class ="form-group">
                        <input type ="text" class="form-control" value =  "<%=q.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>" name ="title" maxlength='20' >
                    </div>
                     
                      
                   
                    <div class ="form-group">
                        
                    </div>
                    <div class ="form-group">
                        <textarea class="form-control" name ="qna_content" maxlength='2048' style = "height:350px"><%=q.getQna_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></textarea>
                    </div>
                    
                    	  
                    <input type="submit" class="btn btn=primary form-control" value="수정">
                </form>
            </div> 
        </div> 
        
    </div>
    <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    
</body>
</html>
