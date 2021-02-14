<%@page import="room.RoomDAO"%>
<%@page import="user.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
<script type="text/javascript">
function SetBuilding(emailValue) { // 사용자 입력
	  var emailTail = document.all("building") // Select box
	   
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
	 }
function SetBuildingRoom(emailValue) { // 사용자 입력
	  var emailTail = document.all("buildingroom") // Select box
	   
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
	 }
</script>
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
int room_no = -1;
if(request.getParameter("room_no") != null) {
	room_no = Integer.parseInt(request.getParameter("room_no"));
}
UserinfoDAO dao = new UserinfoDAO();
RoomDAO rdao = new RoomDAO();

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
<form method = "post" action = "addAction.jsp">
    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "2" style = "background-color: #eeeeee; text-align: center;">게시판 글쓰기</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td><input type = "text" class = "form-control" placeholder = "강의실 제목" name = "room_name" maxLength = "50"></td>
    </tr>
          <tr>
   <td><input type="text" name="building" placeholder="건물" ReadOnly="true"/>
<select name="buildingCheck" 
onchange="SetBuilding(buildingCheck.options[this.selectedIndex].value)">
    <option value="notSelected" >::선택하세요::</option>
    
    <option value="a건물">a건물</option>
    <option value="b건물">b건물</option>    
    <option value="c건물">c건물</option>
   </select></td>
   </tr>
    <tr>
    <td><input type="text" name="buildingroom" placeholder="호실" ReadOnly="true"/>
<select name = "buildingRoomCheck" onchange="SetBuildingRoom(buildingRoomCheck.options[this.selectedIndex].value)" >
 <option value="notSelected" >::선택하세요::</option>
    
      <option value = "1호실">1호실</option>
<option value = "2호실">2호실</option>
<option value = "3호실" >3호실</option>
<option value = "4호실">4호실</option>
<option value = "5호실" >5호실</option>
<option value = "6호실" >6호실</option>
<option value = "7호실">7호실</option>
<option value = "8호실" >8호실</option>
<option value = "9호실" >9호실</option>
<option value = "10호실" >10호실</option>
    </select></td>
    </tr>
     <tr>
    <td><input type = "text" class = "form-control" placeholder = "수용 인원" name = "capacity" maxLength = "50"></td>
    </tr>
    <tr>
    <td><input type = "text" class = "form-control" placeholder = "규격" name = "size" maxLength = "50"></td>
    </tr>
    <%
   
    if(dao.getUserinfo(user_id).getState().equals("관리")) {
    	%>
    	<tr>
    	<td><input type = "text" class = "form-control" placeholder = "담당자" name = "user_id" maxLength = "50"></td>
    </tr>
    	<%
    } else {
    	%>
    	<tr>
    	<td><input type = "text" class = "form-control" placeholder = "담당자" name = "user_id" value = <%=user_id %> maxLength = "50" readonly></td>
    </tr>
<%    	
    }
    %>
    
    </tbody>
    </table>
    
     <input type = "submit" class = "btn btn-primary pull-right" value = "추가">
    </form>
</div>
    </div>
   
    
     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   
</body>
</html>
