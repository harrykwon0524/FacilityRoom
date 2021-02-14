<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "javax.mail.Transport" %>
<%@ page import = "javax.mail.Message" %>
<%@ page import = "javax.mail.Address" %>
<%@ page import = "javax.mail.internet.InternetAddress" %>
<%@ page import = "javax.mail.internet.MimeMessage" %>
<%@ page import = "javax.mail.Session" %>
<%@ page import = "javax.mail.Authenticator" %>
<%@ page import = "java.util.Properties" %>
  <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
         <%@ page import = "util.SHA256" %>
         <%@ page import = "util.Gmail" %>
             <%@ page import = "java.io.PrintWriter"%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 관리 페이지</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

UserinfoDAO userDAO = new UserinfoDAO();
String user_id = null;
if(session.getAttribute("newID") != null) {
	user_id = (String) session.getAttribute("newID");

}

if(user_id == null) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그인 해주세요.')");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
    return;
}



int emailChecked = userDAO.getUserEmailChecked(user_id);
if(emailChecked == 1) {
	 PrintWriter script = response.getWriter();
	
	    script.println("<script>");
	    script.println("alert('이미 인증되었습니다.')");
	    script.println("location.href = 'main.jsp'");
	    script.println("</script>");
	    return;
} else {
	
String host = "http://localhost:8080/room/";
String from = "harrykwon0524@gmail.com";
String to = userDAO.getEmail(user_id);
String subject = "회원 가입 완료 위한 이메일 인증메일입니다";
String code = new SHA256().getSHA256(to);
String content = "링크를 클릭해서 인증을 진행하세요" + 
"<a href = '" + host + "emailCheckAction.jsp?code=" + code + "'>이메일 인증하기</a>";

Properties p = new Properties();
p.put("mail.smtp.user", from);
p.put("mail.smtp.host", "smtp.googlemail.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

try {
	Authenticator auth = new Gmail();
	Session ses = Session.getInstance(p, auth);
	ses.setDebug(true);
	MimeMessage msg = new MimeMessage(ses);
	msg.setSubject(subject);
	Address fromAddr = new InternetAddress(from);
	msg.setFrom(fromAddr);
	Address toAddr = new InternetAddress(to);
	msg.addRecipient(Message.RecipientType.TO, toAddr);
	msg.setContent(content, "text/html;charset=UTF-8");
	Transport.send(msg);
	session.setAttribute("code", code);
} catch(Exception e) {
	e.printStackTrace();
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('오류.')");
	    script.println("history.back()"); 
	    script.println("</script>");
	    return;
}

}

%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1" >        
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/toolbar.css">
<title>자재 관리 페이지</title>
</head>
<body>
<% 
int idch = userDAO.getUserEmailChecked(user_id); 
if(idch == 0) {
	session.setAttribute("sessionID", null); 
}
else {
	session.setAttribute("sessionID", user_id); 
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
                 <li><a href="qna.jsp">문의 사항</a></li>
            </ul>
           
    </nav>
    
    <div class="container">
         <section class = "container mt-3" style = "max-width: 560px;">
            <div class = "alert alert-success mt-4" role = "alert">
            이메일 주소 인증 메일이 전송되었습니다. 이메일에 들어가셔서 인증해주세요
        </div>
        <div class="col-lg-4"></div>
   <footer style="text-align:center;" style="border-top:1px solid #666;" style= "height:70px;" style="line-height:70px; style="margin:0;"   style = "padding:0;">
        Copyright (C) 2018 Hyung Taek Kwon All Right Reserved
        </footer>
    </div>
    
    
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

</body>
</html>


</body>
</html>