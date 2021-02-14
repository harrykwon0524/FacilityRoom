<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import = "user.UserinfoDAO" %>
       <%@ page import = "user.userinfo" %>
       <%@ page import = "facility.FacilityDAO" %>
       <%@ page import = "facility.Facility" %>
       <%@ page import = "facility.Facility_BriefDAO" %>
       <%@ page import = "facility.Facility_Brief" %>
           <%@ page import = "java.util.ArrayList" %>
                      <%@ page import = "java.util.List" %>
        <%@ page import = "java.io.PrintWriter" %>
                   <%@ page import = "java.net.URLEncoder"%>
    
<!DOCTYPE>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
</head>
<script type="text/javascript">
function SetEmailTail(emailValue) {
	  
	  var emailTail = document.all("searchtype") // Select box
	   
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
<body>
<%
String searchtype = "전체";
String sort = "번호순";
String search = "";
FacilityDAO fdao = FacilityDAO.getInstance();

String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
}
if(request.getParameter("searchtype") != null) {
	searchtype = request.getParameter("searchtype");
}
if(request.getParameter("sort") != null) {
	sort = request.getParameter("sort");
}
if(request.getParameter("search") != null) {
	search = request.getParameter("search");
}

int pageNum = 0;
if(request.getParameter("pageNum") != null){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}
int room_no = -1;
if(request.getParameter("room_no") != null) {
	room_no = Integer.parseInt(request.getParameter("room_no"));
}
int facility_no = -1;
if(request.getParameter("facility_no") != null) {
	facility_no = Integer.parseInt(request.getParameter("facility_no"));
}

if(user_id == null) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('로그인이 필요합니다.')");
     script.println("location.href = 'login.jsp'");
     script.println("</script>");
}

if(user_id != null) {

UserinfoDAO dao = UserinfoDAO.getInstance();
userinfo info = dao.getUserinfo(user_id);
	if(!info.getState().equals("관리")){
	PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('관리자만 접속 가능합니다.')");
    script.println("history.back()");    // 이전 페이지로 사용자를 보냄
    script.println("</script>");
}
}
ArrayList<Facility> flist = new ArrayList<Facility>();
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
                    <li class="active"><a href="facility.jsp" >자재 정보</a></li>
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
    <form action="./facility.jsp" method = "get" class = "form-inline mt-3">
    <select name = "searchtype" class = "form-control mx-1 mt-2" onchange= "SetEmailTail(searchtype.options[this.selectedIndex].value)">
     <option value = "전체">전체</option>
    <%
    fdao = new FacilityDAO();
  List<Facility> faclist = fdao.getAllFacility();
    if(faclist != null) {
    	for(int i = 0; i < faclist.size(); i++) {
    		Facility fac = faclist.get(i);
    		String newtype = fac.getType();
    	%>
    	<option value = "<%=fac.getType()%>" <% if(searchtype.equals(fac.getType())) out.println("selected"); %>><%=fac.getType().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></option>
    	<%
    }
    %>
    <%
    }
    %>
    </select>
    <select name = "sort" class = "form-control mx-1 mt-2">
     <option value = "번호순">번호순</option>
      <option value = "수량순"<% if(sort.equals("수량순")) out.println("selected");%>>수량순</option>
     </select>
     <input type = "text" class = "form-control  mr-sm-2" placeholder = "검색어를 입력하세요" name = "search" maxlength = 50>
    <button type = "submit" class = "btn btn-outline-success my-2 my-sm-0" value = "검색">검색</button>
    
    </form>
  <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
   
    </thead>
    <tbody>
  <tr>
  
    <th style = "background-color: #eeeeee; text-align: center;">번호</th>
    <th style = "background-color: #eeeeee; text-align: center;">종류</th>
    <th style = "background-color: #eeeeee; text-align: center;">수량</th>
      <th style = "background-color: #eeeeee; text-align: center;">시리얼</th>
       <th style = "background-color: #eeeeee; text-align: center;">모델</th>
          <th style = "background-color: #eeeeee; text-align: center;">회사</th> 
            <th style = "background-color: #eeeeee; text-align: center;">비고</th> 
             <th style = "background-color: #eeeeee; text-align: center;">이름</th> 
             <th style = "background-color: #eeeeee; text-align: center;">구입 날짜</th> 
              <th style = "background-color: #eeeeee; text-align: center;">수정 날짜</th> 
    </tr>
    
        <%
    FacilityDAO dao = new FacilityDAO();
        Facility_BriefDAO bdao = new Facility_BriefDAO();
    flist = fdao.getQnaArray(searchtype, sort, search, pageNum);
    int total = 0;
    	  if(flist != null) {
    		  for(int i = 0; i < flist.size(); i++) {
    	Facility fa = flist.get(i);
    	
    		%>
    		
    	
   
    
    <tr>
     <td><a href = "facilityview.jsp?facility_no=<%= fa.getFacility_no() %>"><%= fa.getFacility_no() %></a></td>
    <td><%= fa.getType().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    <td><%= fa.getAmount() %></td>
     <td><%= fa.getSerial().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      <td><%= fa.getModel().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
       <td><%= fa.getCompany().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
        <td><%= fa.getRemarks().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
         <td><%= fa.getFa_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
          <td><%= fa.getBuy_date().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
           <td><%= fa.getIn_date().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    </tr>
   
    <%
    }
    %>
    
     <tr>
         <td><a href = "#addfacility" data-toggle = "modal">+추가</a>
	   <div class = "modal fade" id = "addfacility" tabindex = "-1" role = "dialog" aria-labelledby = "modal">
	<div class = "modal-dialog">
	<div class = "modal-content">
	<div class = "modal-header">
	<h5 class = "modal-title" id = "modal">추가하기</h5>
	<button type = "button" class = "close" data-dismiss="modal" aria-label="Close">
	<span aria-hidden = "true">&times;</span>
	</button>
	</div>
		<div class = "modal-body">
	<form action="./addfacility.jsp?facility_no=<%= fdao.maxNum() %>" method = "post">
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>종류</label>
	<input type = "text" name = "type" class = "form-control" maxlength = "50" placeholder = "종류">
	</div>
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>수량</label>
	<input type = "text" name = "amount" class = "form-control" maxlength = "50" placeholder = "수량">
	</div>
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>시리얼</label>
	<input type = "text" name = "serial" class = "form-control" maxlength = "50" placeholder = "시리얼">
	</div>
	</div>
	<div class = "form-group col-sm-4">
	<label>모델</label>
	<input type = "text" name = "model" class = "form-control" maxlength = "50" placeholder = "모델">
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>회사</label>
	<input type = "text" name = "company" class = "form-control" maxlength = "50" placeholder = "회사">
	</div>
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>이름</label>
	<input type = "text" name = "fa_name" class = "form-control" maxlength = "50" placeholder = "이름">
	</div>
	</div>
<div class = "form-row">
	<label>비고</label>
	<textarea name = "remarks" class = "form-control" maxlength = "2048" placeholder = "비고" style ="height:200px"></textarea>
	</div>
	
	<div class = "modal-footer">
	<button type = "button" class = "btn btn-secondary" data-dismiss="modal" aria-label="Close">취소</button>
	<button type = "submit" class = "btn btn-danger">추가</button>
	</div>
	</form>
</div>
	
	</div>
	
	</div>
	
	</div>
	</td>
	
        
    <td></td>
     <td></td>
      <td></td>
       <td></td>
        <td></td>
         <td></td>
          <td></td>
           <td></td>
           
           <td></td>
           </tr>
           
         	  
	
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
	   	<a class = "page-link" href="./facility.jsp?type=<%=URLEncoder.encode(searchtype, "UTF-8") %>&searchType=<%=URLEncoder.encode(sort, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNum - 1 %>">이전</a>
<%	   
}
    	
    		    %>
    	</li>
    	<li class = "page-item">
    	 <%
    if(flist.size() < 6) {
    	%>
    	<a class = "page-link disabled">다음</a>
    	
    <%
} else {
	   %>
	   	<a class = "page-link" href="./facility.jsp?type=<%=URLEncoder.encode(searchtype, "UTF-8") %>&searchType=<%=URLEncoder.encode(sort, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNum + 1 %>">다음</a>
<%	   
}
    	
    		    %>
    		    </li>
    	</ul>
     <%
    }
    %>
   
   
    </div>

     <div class = "footer">
     <p> Copyright (C) 2018 Hyung Taek Kwon All Right Reserved</p>
     </div>

     <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
</body>
</html>