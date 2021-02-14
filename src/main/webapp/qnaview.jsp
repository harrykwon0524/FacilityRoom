<%@page import="qna.Qna"%>
<%@page import="qna.QnaDAO"%>
<%@page import="qna.Reply"%>
<%@page import="qna.ReplyDAO"%>
<%@page import="user.userinfo"%>
<%@page import="user.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
   <%@ page import = "facility.FacilityDAO" %>
       <%@ page import = "facility.Facility" %>  <%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
</head>
<body>
<% 
QnaDAO qdao = QnaDAO.getInstance();
String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
}

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


int rep_no = 0;
if(request.getParameter("rep_no") != null) {
	rep_no = Integer.parseInt(request.getParameter("rep_no"));
}
if(rep_no == -1) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 댓글입니다.')");
    script.println("history.back()");  
    script.println("</script>");
}

ReplyDAO rdao = ReplyDAO.getInstance();
qdao.updateViewcnt(qna_no);
Qna qna = qdao.getQna(qna_no);
if(qdao.getQnaAvailable(qna_no) == 0) {
	PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('삭제된 글입니다.')");
    script.println("location.href = 'qna.jsp'");
    script.println("</script>");
} 
Reply rep = rdao.getReply(qna_no, rep_no);
int reppageNum = 1;
if(request.getParameter("reppageNum") != null){
	reppageNum = Integer.parseInt(request.getParameter("reppageNum"));
}


%>
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
                 <li ><a href="bbs.jsp">강의실</a></li>
                    <li><a href="facility.jsp">자재 정보</a></li>
                   
                 <li class="active"><a href="qna.jsp">공지 사항</a></li>
              <li><a href="report.jsp">신고 현황</a></li>
            </ul>
            <%
            if(user_id == null) {
            	 %>
            	<ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            } else {
            	 %>
            	 <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">환영합니다<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="modify.jsp">정보수정</a></li>      
                        <li><a onclick = "return confirm('정말로 삭제하시겠습니까?')" href="iddelete.jsp">탈퇴</a></li>      
                        <li><a href="logoutAction.jsp">로그아웃</a></li>                  
                    </ul>
                </li>
            </ul>
            	 <%
            }
            %>
            
        </div>
    </nav>
    <div class = "container">
    <div class = "row">

    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "3" style = "background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td style = "width: 20%;">제목</td>
    <td colspan = "2"><%=qna.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    </tr>
      <tr>
    <td>작성자</td>
    <td colspan = "2"><%=qna.getQna_writer().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")  %></td>
    </tr>
      <tr>
    <td>내용</td>
    <td colspan = "5"><%=qna.getQna_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
    
    </tbody>
    </table>
  <a href = "qna.jsp" class = "btn btn-primary pull-right">목록</a>
      <%
    if(user_id != null && user_id.equals(qna.getQna_writer())){
    	 %>
    	 <a onclick = "return confirm('정말로 삭제하시겠습니까?')" href = "qnadeleteAction.jsp?qna_no=<%= qna_no%>" class = "btn btn-primary pull-right">삭제</a>
    	<a href = "qnamodify.jsp?qna_no=<%= qna_no%>" class = "btn btn-primary pull-right">수정</a>
    	
    	<%
    }
    
    %>

  
   
   <%
   if(qdao.getreported(qna.getQna_no()) == 1) {
	   %>
	   <label>신고 제목: <%=qdao.getReportTitle(qna.getQna_no()) %></label>
	    <label>신고 사유:<%=qdao.getReportContent(qna.getQna_no()) %></label>
	    <%
	    UserinfoDAO udao = new UserinfoDAO();
	    %>
	    <%
	    if(user_id != null && udao.getUserinfo(user_id).getState().equals("관리")) {
	    %>
	      <a href = "qnareportCancel.jsp?qna_no=<%=qna_no %>" class="btn btn-danger">신고 해지</a>
	      <%} %>
	      
	      
	   <%
   } else {
	   %>
	   <%
	    if(user_id != null && !user_id.equals(qna.getQna_writer())){
	    	 %>
	      
	      <a href = "#reportModal" class = "btn btn-danger pull-right" data-toggle = "modal">신고</a>
	   <div class = "modal fade" id = "reportModal" tabindex = "-1" role = "dialog" aria-labelledby = "modal">
	<div class = "modal-dialog">
	<div class = "modal-content">
	<div class = "modal-header">
	<h5 class = "modal-title" id = "modal">신고하기</h5>
	<button type = "button" class = "close" data-dismiss="modal" aria-label="Close">
	<span aria-hidden = "true">&times;</span>
	</button>
	</div>
	<div class = "modal-body">
	<form action="./reportAction.jsp?qna_no=<%= qna.getQna_no() %>" method = "post">
	<div class = "form-group">
	<label>신고 제목</label>
	<input type = "text" name = "reportTitle" class = "form-control" maxlength = "50" placeholder = "제목">
	</div>
	<div class = "form-group">
	<label>신고 제목</label>
	<textarea name = "reportContent" class = "form-control" maxlength = "2048" style ="height:350px" placeholder = "사유"></textarea>
	</div>
	<div>
	<div class = "modal-footer">
	<button type = "button" class = "btn btn-secondary" data-dismiss="modal" aria-label="Close">취소</button>
	<button type = "submit" class = "btn btn-danger">신고</button>
	</div>
	</form>
	</div>
	</div>
		<%
	    }
	    
	    %>
	   
	   <%
   }
   %>
      
</div>
    </div>

     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>
