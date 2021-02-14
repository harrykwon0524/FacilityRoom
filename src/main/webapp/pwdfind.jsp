<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
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
if(session.getAttribute("newID") != null) {
	user_id = (String) session.getAttribute("newID");
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
                   <li><a href="bbs.jsp">강의실</a></li>
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
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form method = "post" action="pwdfindAction.jsp">
                    <h3 style="text-align:center;">비밀번호 찾기</h3>
                    <div class ="form-group">
                        <input type ="text" class="form-control" placeholder="아이디" name ="id" maxlength='500'>
                    </div>
                    
                     
                    <input type="submit" class="btn btn=primary form-control" value="아이디 입력">
                    
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
