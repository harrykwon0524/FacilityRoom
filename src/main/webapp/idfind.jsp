<%@page import="util.SHA256Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
    <%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
<%

%>
 <script type = "text/javascript">
function SetEmailTail(emailValue) {
	  var email = document.all("email")    // 사용자 입력
	  var emailTail = document.all("email_domain") // Select box
	   
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
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li  class="active"><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form method = "post" action="idfindAction.jsp">
                    <h3 style="text-align:center;">아이디 찾기</h3>
                    
                     
                       <div class ="form-group">
                       
                        <input type ="text" class="form-control" placeholder ="이름"  name ="user_name" maxlength='20'>
                    </div>
                   
                    <div class ="form-group">
                        <input type="text"  name = "email" placeholder = "이메일 주소"/>
   @
<input type="text"  name="email_domain" placeholder="도메인" ReadOnly="true"/>
<select name="emailCheck" 
onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)">
    <option value="notSelected" >::선택하세요::</option>
    <option value="etc">직접입력</option>
    <option value="naver.com">naver.com</option>
    <option value="nate.com">nate.com</option>
    <option value="empal.com">empal.com</option>
    <option value="hotmail.com">hotmail.com</option>
    <option value="lycos.co.kr">lycos.co.kr</option>
    <option value="msn.com">msn.com</option>
    <option value="hanmail.net">hanmail.net</option>
    <option value="yahoo.com">yahoo.com</option>
    <option value="korea.com">korea.com</option>
    <option value="kornet.net">kornet.net</option>
    <option value="yahoo.co.kr">yahoo.co.kr</option>
    <option value="kebi.com">kebi.com</option>
    <option value="orgio.net">orgio.net</option>
    <option value="paran.com">paran.com</option>    
    <option value="gmail.com">gmail.com</option>
   </select>
                    </div>
                    <div class ="form-group">
                        <input type ="tel" class="form-control" placeholder = "전화번호" name = "phone" maxlength='45'>
                    </div>
                    
                    	  <div class ="form-group" style="text-align:center;">
                          <div class="btn-group" data-toggle="buttons">
                          <label class="btn btn-primary active">
                          <input type = "radio"  name = "gender" autocomplete="off" value = "남자" checked>남자
                          </label>
                            <label class="btn btn-primary active">
                          <input type = "radio"   name = "gender" autocomplete="off" value = "여자" checked>여자
                          </label>
                          </div>
                          </div>
                      
                      
                      
                       <div class ="form-group" style="text-align:center;">
                      <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-primary active">
                      <input type = "radio"  name = "state" autocomplete="off" value = "관리" checked>관리
                      </label>
                        <label class="btn btn-primary active">
                      <input type = "radio" name = "state" autocomplete="off" value = "담당" checked>담당
                      </label>
                      </div>
                      </div>
                    <input type="submit" class="btn btn=primary form-control" value="찾기">
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
