<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
    <%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
        <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
    <%@ page import = "java.util.ArrayList" %>
    <%@ page import = "java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >     
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
</head>
<body>
<% 
request.setCharacterEncoding("UTF-8");
String building = "전체";
String buildingroom = "전체";
String searchType = "번호순";
String search = "";

if(request.getParameter("building") != null) {
	building = request.getParameter("building");
}
if(request.getParameter("buildingroom") != null) {
	building = request.getParameter("buildingroom");
}
if(request.getParameter("searchType") != null) {
	searchType = request.getParameter("searchType");
}
if(request.getParameter("search") != null) {
	search = request.getParameter("search");
}

String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
}
int pageNumber = 0;
if(request.getParameter("pageNumber") != null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
int room_no = -1;
if(request.getParameter("room_no") != null) {
	room_no = Integer.parseInt(request.getParameter("room_no"));
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
    <form action="./bbs.jsp" method = "get" class = "form-inline mt-3">
    <select name = "building" class = "form-control mx-1 mt-2">
     <option value = "전체">전체</option>
      <option value = "a건물" <% if(building.equals("a건물")) out.println("selected");%>>a건물</option>
    <option value = "b건물"<% if(building.equals("b건물")) out.println("selected");%>>b건물</option>
    <option value = "c건물"<% if(building.equals("c건물")) out.println("selected");%>>c건물</option>
    </select>
   
    <select name = "searchType" class = "form-control mx-1 mt-2">
     <option value = "번호순">번호순</option>
      <option value = "수용인원순" <% if(searchType.equals("수용인원순")) out.println("selected");%>>수용인원순</option>
    </select>
     <input type = "text" class = "form-control mr-sm-2" placeholder = "검색어를 입력하세요" name = "search" maxlength = 50 type="search">
    <button type = "submit" class = "btn btn-outline-success my-2 my-sm-0" value = "검색">검색</button>
    </form>
   
   <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    		    <thead>
    		    <tr>
    		    <th style = "background-color: #eeeeee; text-align: center;">강의실 번호</th>
    		    <th style = "background-color: #eeeeee; text-align: center;">강의실 이름</th>
    		      <th style = "background-color: #eeeeee; text-align: center;">수용 인원</th>
    		       <th style = "background-color: #eeeeee; text-align: center;">수정 날짜</th>
    		          <th style = "background-color: #eeeeee; text-align: center;">담당자</th> 
    		          <th style = "background-color: #eeeeee; text-align: center;">건물</th> 
    		          <th style = "background-color: #eeeeee; text-align: center;">호실</th> 
    		    </tr>
    		     </thead>
    		    <tbody>
    <%
    
    ArrayList<Roomlist> roomlist = new  ArrayList<Roomlist>();
    RoomDAO dao = new RoomDAO();
    roomlist = dao.getRoomArray(building,searchType, search, pageNumber);
    if(roomlist != null) {
    	for(int i = 0; i < roomlist.size(); i++) {
    		if(i == 5) break;
    			Roomlist room = roomlist.get(i);
    			if(dao.getRoomAvailable(i) == 1) {
    				 %>
    				    		    <tr>
    		    <td><%= room.getRoom_no() %></td>
    		    <td><a href = "view.jsp?room_no=<%= room.getRoom_no() %>"><%= room.getRoom_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
    		     <td><%= room.getCapacity() %></td>
    		      <td><%= room.getUser_modate().substring(0, 11) + room.getUser_modate().substring(11,13) + "시" + room.getUser_modate().substring(14, 16) + " 분 "%></td>
    		       <td><%= room.getUser_id().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    		 <td><%= room.getBuilding().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    		  		 <td><%= room.getBuildingroom().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    		    </tr>
    		   

    				<%
    			}
    			 %>
    			
    		   
    		   
 
   
    				<%
    			}
    			 %>
    	        		  

    		   
      <%
    } 
    	 %>
    	 
    	  
     <%
    if(user_id != null) {
    	 UserinfoDAO infodao = new UserinfoDAO();
 	    userinfo inf = infodao.getUserinfo(user_id);
    	 %>
    	    <%
    	    if(inf.getState().equals("담당") || inf.getState().equals("관리")) {
    	    	  %>
    	    	  <a href = "add.jsp" class = "btn btn-primary pull-right">글쓰기</a>
    	    	  
    	    	  <%
    	    }
    	%>
    	
    	  <%
    }
    %>
    </tbody>
    		    </table>

  <ul class = "pagination justify-content-center mt-3">
    	<li class = "page-item">
    	 <%
    if(pageNumber <= 0) {
    	%>
    	<a class = "page-link disabled">이전</a>
    	
    <%
} else {
	   %>
	   	<a class = "page-link" href="./bbs.jsp?building=<%=URLEncoder.encode(building, "UTF-8") %>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1 %>">이전</a>
<%	   
}
    	
    		    %>
    	</li>
    	<li class = "page-item">
    	 <%
    if(roomlist.size() < 6) {
    	%>
    	<a class = "page-link disabled">다음</a>
    	
    <%
} else {
	   %>
	   	<a class = "page-link" href="./bbs.jsp?building=<%=URLEncoder.encode(building, "UTF-8") %>&searchType=<%=URLEncoder.encode(searchType, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNumber + 1 %>">다음</a>
<%	   
}
    	
    		    %>
    		    </li>
    	</ul>
    
    </div>
 
    </div>
     
     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>
    
    
  
</body>
</html>
