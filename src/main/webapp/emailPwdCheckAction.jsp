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
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String code = null;


if(session.getAttribute("code") != null) {
	code = (String) session.getAttribute("code");
}



String user_id = null;
if(session.getAttribute("newID") != null) {
	user_id = (String) session.getAttribute("newID");
}
UserinfoDAO dao = new UserinfoDAO();

if(user_id == null) {
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('로그인이 필요합니다.')");
	    script.println("location.href = 'login.jsp'");
	    script.println("</script>");
}

String usermail = dao.getEmail(user_id);
boolean isRight = (new SHA256().getSHA256(usermail).equals(code)) ? true : false;
 if(isRight == true && dao.getUserAvailable(user_id) == 1) {
	dao.setUserEmailChecked(user_id);
	session.setAttribute("sessionID", null);
	session.setAttribute("newID", user_id);
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('인증되었습니다.')");
	    script.println("location.href = 'pwdreset.jsp'");
	    script.println("</script>");
}


else {
	session.setAttribute("sessionID", null);
	PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('인증에 실패하였습니다.')");
    script.println("location.href = 'main.jsp'");
    script.println("</script>");
}
%>

    
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

</body>
</html>
