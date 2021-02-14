<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>���� ���� ������</title>
</head>
<script type="text/javascript">

function passwordCheckFunction() {
	 var pwd1 = $('#pwd1').val();
	 var pwd2 = $('#pwd2').val();
	 var pattern1 = /[0-9]/;	 var pattern2 = /[a-zA-Z]/;	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;	

	
	 if(pwd1 != pwd2) {
		 $('#passwordCheckMessage').html('��й�ȣ�� ��ġ���� �ʽ��ϴ�');
	 } else {
		 $('#passwordCheckMessage').html('��� �����մϴ�');
	 }
	 if(pwd1.indexOf(" ") != -1 || pwd1.indexOf(" ") != -1) {
		 $('#passwordCheckMessage').html('��й�ȣ�� ������ ������ �ȵ˴ϴ�');
	 }
	 if(!pattern1.test(pwd1) || !pattern2.test(pwd1) || !pattern3.test(pwd1) || !pattern1.test(pwd2) || !pattern2.test(pwd2) || !pattern3.test(pwd2) || pwd1.length < 7 || pwd2.length < 7) {
		 $('#passwordCheckMessage').html('��й�ȣ�� ����(��ҹ��� ����)�� ���ڸ� �����ϰ� 7�ڸ��� �Ѿ�� �մϴ�');
	 }
	
			 
	 
}


</script>
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
            <a class ="navbar-brand" href="main.jsp">���ǽ� ���� ����Ʈ</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">

                <li><a href="bbs.jsp">���ǽ�</a></li>
                    <li><a href="facility.jsp">���� ����</a></li>
                    
                 <li><a href="qna.jsp">���� ����</a></li>
                   <li><a href="report.jsp">�Ű� ��Ȳ</a></li>
                 
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">�����ϱ�<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">�α���</a></li>
                        <li  class="active"><a href="join.jsp">ȸ������</a></li>                    
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class = "container">
    <form method = "post" action = "pwdresetAction.jsp">
    <table class = "table table-bordered table-hover" style = "text-align: center; border : 1px solid #dddddd">
<thead>
<tr>
<th colspan = "3"><h4>ȸ�� ��� ���</h4></th>
</tr>
</thead>
<tbody>
    <tr>
<td style = "width: 110px;"><h5>��й�ȣ</h5></td>
<td colspan = "2"><input class = "form-control" type = "password" onkeyup = "passwordCheckFunction();" id = "newpwd1" name = "newpwd1" maxLength = "20" placeholder = "��й�ȣ�� �Է����ּ���"></td>
</tr>
<tr>
<td style = "width: 110px;"><h5>��й�ȣ Ȯ��</h5></td>
<td colspan = "2"><input class = "form-control" type = "password" onkeyup = "passwordCheckFunction();"  id = "newpwd2" name = "newpwd2" maxLength = "20" placeholder = "��й�ȣ Ȯ���� �Է����ּ���"></td>
</tr>
<tr>
<td style = "text-align: left"colspan = "3"><h5 style = "color: red" id = "passwordCheckMessage"></h5>
<input class = "btn btn-primary pull-right" id = "check" type = "submit" value = "�缳��"></td>
 </tbody>
 </table>
 </form>
    </div>
  <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
</body>
</html>