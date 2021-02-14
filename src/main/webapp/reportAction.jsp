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
             <%@page import="qna.Qna"%>
<%@page import="qna.QnaDAO"%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

UserinfoDAO userDAO = new UserinfoDAO();
String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");

}

if(user_id == null) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그인 해주세요.')");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
    return;
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
QnaDAO qdao = QnaDAO.getInstance();


	request.setCharacterEncoding("UTF-8");
	
	String reportTitle = null;
	String reportContent = null;
	if(request.getParameter("reportTitle") != null) {
		reportTitle = request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent") != null) {
		reportContent = request.getParameter("reportContent");
	}
	if(reportTitle == null ||reportContent == null ) {
		 PrintWriter script = response.getWriter();
		    script.println("<script>");
		    script.println("alert('입력 안된 사항.')");
		    script.println("history.back();");
		    script.println("</script>");
		    return;
	}
	
String host = "http://localhost:8080/k/";
String from = "harrykwon0524@gmail.com";
String to = "harrykwon97@naver.com";
String subject = "신고글이 접수되었습니다";
String code = new SHA256().getSHA256(to);
qdao.reported(qna_no);
String content = "신고자:" +  user_id + "<br>제목: " + reportTitle + 
"<br>내용: " + reportContent;


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
} catch(Exception e) {
	e.printStackTrace();
	 PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('오류.')");
	    script.println("history.back()"); 
	    script.println("</script>");
	    return;
}
int result = qdao.setReport(reportTitle, reportContent, qna_no);
if(result == 1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('신고됨')");
	script.println("location.href = 'qna.jsp'");
	script.println("</script>");
	script.close();
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('오류.')");
    script.println("history.back()"); 
    script.println("</script>");
	script.close();
}

%>
