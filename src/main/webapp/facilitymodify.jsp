       <%@ page import = "facility.FacilityDAO" %>
       <%@ page import = "facility.Facility" %>
              <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
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
int facility_no = -1;
if(request.getParameter("facility_no") != null) {
	facility_no = Integer.parseInt(request.getParameter("facility_no"));
}
if(facility_no == -1) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('유효하지 않은 자재입니다.')");
     script.println("location.href = 'facility.jsp'");
     script.println("</script>");
}
UserinfoDAO udao = UserinfoDAO.getInstance();
userinfo info = udao.getUserinfo(user_id);
if(!info.getState().equals("관리")) {
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('권한이 필요합니다.')");
	    script.println("location.href = 'login.jsp'");
	    script.println("</script>");
}

FacilityDAO fdao = FacilityDAO.getInstance();
Facility fa = fdao.getF(facility_no);

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
                 <li class="active"><a href="bbs.jsp">강의실</a></li>
                    <li><a href="facility.jsp">자재 정보</a></li>
                 <li><a href="qna.jsp">공지 사항</a></li>
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
<form method = "post" action = "facilitymodifyAction.jsp?facility_no=<%= facility_no %>">
    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "3" style = "background-color: #eeeeee; text-align: center;">자재 세부 사항</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td style = "width: 20%;">종류</td>
    <td><input type = "text" class = "form-control" placeholder = "종류" name = "type" maxLength = "50" value = "<%=fa.getType().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>"></td>
    </tr>
      <tr>
    <td>수량</td>
    <td><input type = "number" class = "form-control" placeholder = "수량" name = "amount" maxLength = "50" value = "<%=fa.getAmount() %>">
    </tr>
      <tr>
    <td>시리얼</td>
    <td><input type = "text" class = "form-control" placeholder = "시리얼" name = "serial" maxLength = "50" value = "<%=fa.getSerial().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>"> </td>
    </tr>
     <tr>
    <td>모델</td>
    <td><input type = "text" class = "form-control" placeholder = "모델" name = "model" maxLength = "50" value = "<%=fa.getModel().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>"> </td>
    </tr>
      <tr>
    <td>회사</td>
    <td><input type = "text" class = "form-control" placeholder = "회사" name = "company" maxLength = "50" value = "<%=fa.getCompany().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>"> </td>
    </tr>
      <tr>
    <td>비고</td>
    <td><input type = "text" class = "form-control" placeholder = "비고" name = "remarks" maxLength = "50" value = "<%=fa.getRemarks().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> "></td>
    </tr>
      <tr>
    <td>이름</td>
    <td><input type = "text" class = "form-control" placeholder = "이름" name = "fa_name" maxLength = "50" value = "<%=fa.getFa_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>"> </td>
    </tr>
    </tbody>
    </table>
 
   
   
	    <input type = "submit" class = "btn btn-primary pull-right" value = "자재 수정">
	  
      </form>
</div>
    </div>
  

     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>
