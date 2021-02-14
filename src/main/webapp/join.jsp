<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
 <script type = "text/javascript">
 function registerCheckFunction() {
	 var id = $('#id').val();
	 $.ajax({
		 type: 'POST',
		 url: './UserRegisterCheckServlet',
		 data: {id : id},
		 success: function(result) {
			 if(id == null) {
				 $('#checkMessage').html('아이디를 입력해주세요');
				 $('#checkType').attr('class', 'modal-content panel-warning');
			 }
			 if(result == 1) {
				 $('#checkMessage').html('사용할 수 있는 아이디입니다');
				 $('#checkType').attr('class', 'modal-content panel-success');
			 }
			 else {
				 $('#checkMessage').html('사용할 수 없는 아이디입니다');
				 $('#checkType').attr('class', 'modal-content panel-warning');
			 }
			 $('#checkModal').modal("show");
			 
		 }
	 })
 }
 function passwordCheckFunction() {
	 var pwd1 = $('#pwd1').val();
	 var pwd2 = $('#pwd2').val();
	 var id = $('#id').val();
	 var pattern1 = /[0-9]/;	 var pattern2 = /[a-zA-Z]/;	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;	

	
	 if(pwd1 != pwd2) {
		 $('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다');
	 } else {
		 $('#passwordCheckMessage').html('사용 가능합니다');
	 }
	 if(pwd1.indexOf(" ") != -1 || pwd1.indexOf(" ") != -1) {
		 $('#passwordCheckMessage').html('비밀번호에 공백이 있으면 안됩니다');
	 }
	 if(!pattern1.test(pwd1) || !pattern2.test(pwd1) || !pattern3.test(pwd1) || !pattern1.test(pwd2) || !pattern2.test(pwd2) || !pattern3.test(pwd2) || pwd1.length < 7 || pwd2.length < 7) {
		 $('#passwordCheckMessage').html('비밀번호는 영어(대소문자 포함)와 숫자를 포함하고 7자리를 넘어야 합니다');
	 }
	
			 
	 
 }
 
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
<%
String user_id = null;
if(session.getAttribute("newID") != null) {
	user_id = (String) session.getAttribute("newID");
}
String id = null;
if(session.getAttribute("sessionID") != null) {
	id = (String) session.getAttribute("sessionID");
}
if(id != null) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('이미 로그인이 되어 있습니다.')");
     script.println("location.href = 'main.jsp'");
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
 <div class = "container">
<form method = "post" action = "./userRegister">
<table class = "table table-bordered table-hover" style = "text-align: center; border : 1px solid #dddddd">
<thead>
<tr>
<th colspan = "3"><h4>회원 등록 양식</h4></th>
</tr>
</thead>
<tbody>
<tr>
<td style = "width: 110px;"><h5>아이디</h5></td>
<td><input class = "form-control" type = "text" id = "id" name = "id" maxLength = "20" placeholder = "아이디를 입력해주세요"></td>
<td style = "width: 110px;"><button class = "btn btn-primary" onclick = "registerCheckFunction();" type = "button">중복 체크</button></td>
</tr>
<tr>
<td style = "width: 110px;"><h5>비밀번호</h5></td>
<td colspan = "2"><input class = "form-control" type = "password" onkeyup = "passwordCheckFunction();" id = "pwd1" name = "pwd1" maxLength = "20" placeholder = "비밀번호를 입력해주세요"></td>
</tr>
<tr>
<td style = "text-align: left"colspan = "3"><h5 style = "color: red" id = "passwordCheckMessage"></h5></td>
</tr>
<tr>
<td style = "width: 110px;"><h5>비밀번호 확인</h5></td>
<td colspan = "2"><input class = "form-control" type = "password" onkeyup = "passwordCheckFunction();"  id = "pwd2" name = "pwd2" maxLength = "20" placeholder = "비밀번호 확인을 입력해주세요"></td>
</tr>
<tr>
<td style = "width: 110px;"><h5>이름</h5></td>
<td colspan = "2"><input class = "form-control" type = "text" id = "name" name = "name" maxLength = "20"placeholder = "이름을 입력해주세요"></td>
</tr>
<tr>
<td style = "width: 110px;"><h5>성별</h5></td>
<td colspan = "2">
 <div class ="form-group" style="text-align:center;">
                      <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-primary active">
                      <input type = "radio" name = "gender" autocomplete="off" value = "남자" checked>남자
                      </label>
                        <label class="btn btn-primary active">
                      <input type = "radio" name = "gender" autocomplete="off" value = "여자" checked>여자
                      </label>
                      </div>
                      </div>
<tr>
<td style = "width: 110px;"><h5>지위</h5></td>
<td colspan = "2">
 <div class ="form-group" style="text-align:center;">
                      <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-primary active">
                      <input type = "radio" name = "state" autocomplete="off" value = "관리" checked>관리
                      </label>
                        <label class="btn btn-primary active">
                      <input type = "radio" name = "state" autocomplete="off" value = "담당" checked>담당
                      </label>
                      </div>
                      </div>
<tr>
<td style = "width: 110px;"><h5>이메일</h5></td><td colspan = "2">
<input type="text" name="email" placeholder="이메일을 입력하세요" />
   @
<input type="text" name="email_domain" placeholder="도메인" ReadOnly="true"/>
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

</td>
<tr>
<td style = "width: 110px;"><h5>전화번호</h5></td><td colspan = "2">
<input class = "form-control" type = "tel" id = "phone" name = "phone" maxLength = "20"placeholder = "전화번호를 입력해주세요"></td>
<tr>
<td style = "text-align: left"colspan = "3">
<input class = "btn btn-primary pull-right" type = "submit" value = "회원가입"></td>
</tbody>
</table>
</form>
</div>
<%
String messageContent = null;
if(session.getAttribute("messageContent") != null) {
	messageContent = (String) session.getAttribute("messageContent");
}
String messageType = null;
if(session.getAttribute("messageType") != null) {
	messageType = (String) session.getAttribute("messageType");
}
if(messageContent != null) {
	
	%>
	<div class = "modal fade" id = "messageModal" tabindex = "-1" role = "dialog" aria-hidden = "true">
	<div class = "vertical-alignment-helper">
	<div class = "modal-dialog vertical-align-center">
	<div class = "modal-content" <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>>
	<div class = "modal-header panel-heading">
	<button type = "button" class = "close" data-dismiss = "modal">
	<span aria-hidden = "true">&times;</span>
	<span class="sr-only">Close</span>
	</button>
	<h4 class = "modal-title">
	<%= messageType %>
	</h4>
	</div>
	<div class = "modal-body">
	<%= messageContent %>
	</div>
	<div class = "modal-footer">
	<button type = "button" class = "btn btn-primary" data-dismiss="modal">확인</button>
	</div>
	</div>
	</div>
	</div>
	</div>
	<script>
	$('#messageModal').modal("show");
	</script>
	<%
	session.removeAttribute("messageContent");
	session.removeAttribute("messageType");
}
%>
	<div class = "modal fade" id = "checkModal" tabindex = "-1" role = "dialog" aria-hidden = "true">
	<div class = "vertical-alignment-helper">
	<div class = "modal-dialog vertical-align-center">
	<div id = "checkType" class = "modal-content panel-info">
	<div class = "modal-header panel-heading">
	<button type = "button" class = "close" data-dismiss = "modal">
	<span aria-hidden = "true">&times;</span>
	<span class="sr-only">Close</span>
	</button>
	<h4 class = "modal-title">
	확인 메세지
	</h4>
	</div>
	<div class = "modal-body" id = "checkMessage">
	</div>
	<div class = "modal-footer">
	<button type = "button" class = "btn btn-primary" data-dismiss="modal">확인</button>
	</div>
	</div>
	</div>
	</div>
	</div>

     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>

</body>
</html>