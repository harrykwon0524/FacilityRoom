<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
    <%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
        <%@ page import = "user.UserinfoDAO" %>
                   <%@ page import = "java.net.URLEncoder"%>
       <%@ page import = "user.userinfo" %>
       <%@ page import = "qna.Qna" %>
       <%@ page import = "qna.QnaDAO" %>
       
    <%@ page import = "java.util.ArrayList" %>
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
String category = "전체";
String sort = "번호순";
String search = "";
String user_id = null;

if(request.getParameter("sort") != null) {
	sort = request.getParameter("sort");
}
if(request.getParameter("category") != null) {
	category = request.getParameter("category");
}
if(request.getParameter("search") != null) {
	search = request.getParameter("search");
}

if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
}
int pageNum = 0;
if(request.getParameter("pageNum") != null){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}


int qna_no = -1;
if(request.getParameter("qna_no") != null) {
	qna_no = Integer.parseInt(request.getParameter("qna_no"));
	
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
                      
                 <li ><a href="qna.jsp">공지 사항</a></li>
                   <li class="active"><a href="report.jsp">신고 현황</a></li>
                 
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
    <form action="./qna.jsp" method = "get" class = "form-inline mt-3">
    <select name = "searchType" class = "form-control mx-1 mt-2">
     <option value = "전체">전체</option>
    <option value = "문의"<% if(category.equals("문의")) out.println("selected");%>>문의</option>
    </select>
     <select name = "sort" class = "form-control mx-1 mt-2">
     <option value = "번호순">번호순</option>
      <option value = "조회순"<% if(sort.equals("조회순")) out.println("selected");%>>조회순</option>
     </select>
     <input type = "text" class = "form-control mx-1 mt-2" placeholder = "검색어를 입력하세요" name = "search" maxlength = 50>
    <button type = "submit" class = "btn btn-primary mx-1 mt-2" value = "검색">검색</button>
    </form>
    
    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th style = "background-color: #eeeeee; text-align: center;">게시글 번호</th>
    <th style = "background-color: #eeeeee; text-align: center;">제목</th>
      <th style = "background-color: #eeeeee; text-align: center;">작성자</th>
       <th style = "background-color: #eeeeee; text-align: center;">수정 날짜</th> 
              <th style = "background-color: #eeeeee; text-align: center;">조회수</th> 
               <th style = "background-color: #eeeeee; text-align: center;">카테고리</th> 
    </tr>
    </thead>
    <tbody>
    <%
    QnaDAO dao = new QnaDAO();
    ArrayList<Qna> list = dao.getQnaReportArray(category, sort, search, pageNum);
    if(list != null) {
    	for(int i = 0; i < list.size(); i++) {
    		Qna qna = list.get(i);
    			
    				%>
    				    
    <tr>
   <td><%= qna.getQna_no() %></td>
    <td><a href = "qnaview.jsp?qna_no=<%= qna.getQna_no() %>"><%= qna.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
      <td><%= qna.getQna_writer().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
       <td><%= qna.getQna_modate().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
         <td><%= qna.getViewcnt() %></td>
          <td><%= qna.getCategory().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
    </tr>
   
    
      <%
    }
    %>
    			

    	   
     
    	  
    
   
   
    </tbody>
    </table>
    
    <ul class = "pagination justify-content-center mt-3">
    	<li class = "page-item">
    	 <%
    if(pageNum <= 0) {
    	%>
    	<a class = "page-link disabled">이전</a>
    	
    <%
} else {
	   %>
	   	<a class = "page-link" href="./qna.jsp?category=<%=URLEncoder.encode(category, "UTF-8") %>&sort=<%=URLEncoder.encode(sort, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNum=<%=pageNum - 1 %>">이전</a>
<%	   
}
    	
    		    %>
    	</li>
    	<li class = "page-item">
    	 <%
    if(list.size() < 6) {
    	%>
    	<a class = "page-link disabled">다음</a>
    	
    <%
} else {
	   %>
	<a class = "page-link" href="./qna.jsp?category=<%=URLEncoder.encode(category, "UTF-8") %>&sort=<%=URLEncoder.encode(sort, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNum=<%=pageNum + 1 %>">다음</a>
<%	   
}
    	
    		    %>
    		    </li>
    	</ul>
    	    		<%
    			}
    			%>
  
    </div>

    </div>
   <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>
