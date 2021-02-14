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
int facility_no = -1;
if(request.getParameter("facility_no") != null) {
	facility_no = Integer.parseInt(request.getParameter("facility_no"));
}
if(facility_no == -1) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('유효하지 않은 자재입니다.')");
     script.println("location.href = 'bbs.jsp'");
     script.println("</script>");
}

FacilityDAO fdao = FacilityDAO.getInstance();
Facility fa = fdao.getF(facility_no);

UserinfoDAO udao = UserinfoDAO.getInstance();
userinfo user = udao.getUserinfo(user_id);
if(!user.getState().equals("관리")) {
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('권한이 필요합니다.')");
	    script.println("location.href = 'login.jsp'");
	    script.println("</script>");
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

    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "3" style = "background-color: #eeeeee; text-align: center;">자재 세부 사항</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td style = "width: 20%;">종류</td>
    <td colspan = "2"><%=fa.getType().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    </tr>
      <tr>
    <td>수량</td>
    <td colspan = "2"><%=fa.getAmount()%></td>
    </tr>
      <tr>
    <td>시리얼</td>
    <td colspan = "5"><%=fa.getSerial().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
     <tr>
    <td>모델</td>
    <td colspan = "5"><%=fa.getModel().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
      <tr>
    <td>회사</td>
    <td colspan = "5"><%=fa.getCompany().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
      <tr>
    <td>비고</td>
    <td colspan = "5"><%=fa.getRemarks().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
      <tr>
    <td>이름</td>
    <td colspan = "5"><%=fa.getFa_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
    <tr>
    <td>구입 날짜</td>
    <td colspan = "5"><%=fa.getBuy_date().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
    <tr>
    <td>수정 날짜</td>
    <td colspan = "5"><%=fa.getIn_date().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> </td>
    </tr>
    </tbody>
    </table>
  <a href = "facility.jsp" class = "btn btn-primary pull-right">목록</a>
    <%
    if(user_id != null && user.getState().equals("관리")){
    	 %>
    	 <a onclick = "return confirm('정말로 삭제하시겠습니까?')" href = "facilitydeleteAction.jsp?facility_no=<%= facility_no%>" class = "btn btn-primary pull-right">삭제</a>
    	<a href = "facilitymodify.jsp?facility_no=<%= facility_no%>" class = "btn btn-primary pull-right">수정</a>
    	
    	<%
    }
    
    %>
   
	  
	  
      
</div>
    </div>
  
    </thead>
     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>
