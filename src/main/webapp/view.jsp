<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
    <%@ page import = "room.RoomDAO" %>
    <%@ page import = "room.Roomlist" %>
   <%@ page import = "facility.FacilityDAO" %>
       <%@ page import = "facility.Facility" %>
          <%@ page import = "facility.Facility_BriefDAO" %>
                 <%@ page import = "facility.Facility_Brief" %>
                                       <%@ page import = "java.util.List" %>
         <%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/custom.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="resources/js/bootstrap.js"></script>
<title>자재 관리 페이지</title>
</head>
<script type="text/javascript">

function SetEmailTail(emailValue) {
	  var emailTail = document.all("serial") // Select box
	  var emailTail2 = document.all("model") // Select box
	  var emailTail3 = document.all("company") // Select box
	  var emailTail4 = document.all("fa_name") // Select box
	  var emailTail5 = document.all("remarks") // Select box
	  
	   
	  if ( emailValue == "notSelected" )
	   return;
	 
	   emailTail.readOnly = true;
	   emailTail2.readOnly = true;
	   emailTail3.readOnly = true;
	   emailTail4.readOnly = true;
	   emailTail5.readOnly = true;
	   $.ajax({
			type: "get", 
			contentType: "application/json; charset=utf-8",
			url: "/room/greeting",
			success: function(data) {
				
				var bbsList = data;
				
				for(var idx = 0; idx < bbsList.length; idx++) {
					var newtype = bbsList[idx].type;
					if(emailValue == newtype) {
						var newserial = bbsList[idx].serial;
						var newmodel = bbsList[idx].model;
						var newcompany = bbsList[idx].company;
						var newfa_name = bbsList[idx].fa_name;
						var newremarks = bbsList[idx].remarks;
						console.log(newmodel);
						emailTail.value = newserial;
						emailTail2.value = newmodel;
						emailTail3.value = newcompany;
						emailTail4.value = newfa_name;
						emailTail5.value = newremarks;
						return;
					}
				}
			}
			
	});

	  
	 }
	 

</script>

<body>
<% 
String user_id = null;
if(session.getAttribute("sessionID") != null) {
	user_id = (String) session.getAttribute("sessionID");
}
int room_no =0;
if(request.getParameter("room_no") != null) {
	room_no = Integer.parseInt(request.getParameter("room_no"));
}
int facility_no = 0;
if(request.getParameter("facility_no") != null) {
	facility_no = Integer.parseInt(request.getParameter("facility_no"));
}
if(room_no == -1) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('유효하지 않은 방입니다.')");
     script.println("location.href = 'bbs.jsp'");
     script.println("</script>");
}
if(facility_no == -1) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 자재입니다.')");
    script.println("location.href = 'facility.jsp'");
    script.println("</script>");
}
RoomDAO dao = RoomDAO.getInstance();
Roomlist room = dao.getRoom(room_no);
FacilityDAO fdao = FacilityDAO.getInstance();
Facility_BriefDAO bdao = Facility_BriefDAO.getInstance();
Facility fff = fdao.getF(facility_no);

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
    <div class = "row">

    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "3" style = "background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td style = "width: 20%;">강의실 이름</td>
    <td colspan = "2"><%=room.getRoom_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    </tr>
    <tr>
    <td>건물</td>
    <td colspan = "2"><%=room.getBuilding().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")  %></td>
    </tr>
     <tr>
    <td>호실</td>
    <td colspan = "2"><%=room.getBuildingroom().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")  %></td>
    </tr>
      <tr>
    <td>담당자</td>
    <td colspan = "2"><%=room.getUser_id().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")  %></td>
    </tr>
      <tr>
    <td>작성일자</td>
    <td colspan = "2"><%=room.getUser_modate().substring(0, 11) + room.getUser_modate().substring(11,13) + "시" + room.getUser_modate().substring(14, 16) + " 분 "  %>글 </td>
    </tr>
     <tr>
    <td>수용인원</td>
    <td colspan = "2"><%=room.getCapacity()  %></td>
    </tr>
       <tr>
    <td>규격</td>
    <td colspan = "2"><%=room.getSize()  %></td>
    </tr>
    
    </tbody>
    </table>
  
    <%
    if(user_id != null && user_id.equals(room.getUser_id())){
    	 %>
    	 <a onclick = "return confirm('정말로 삭제하시겠습니까?')" href = "deleteAction.jsp?room_no=<%= room_no%>" class = "btn btn-primary pull-right">삭제</a>
    	<a href = "update.jsp?room_no=<%= room_no%>" class = "btn btn-primary pull-right">수정</a>
    	
    	<%
    }
    
    %>
      <a href = "bbs.jsp" class = "btn btn-primary pull-right">목록</a>
    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
  
    <tr>
    <td>
    자재번호
    </td>
       <td>
    종류
    </td>
       <td>
    이름
    </td>
       <td>
    사용갯수
    </td>   
     <td>
    
    </td>
    <td>
    
    </td>
  </tr>

	<%
    Facility_BriefDAO fbdao = Facility_BriefDAO.getInstance();
    ArrayList<Facility_Brief> list = new ArrayList<Facility_Brief>();
    list = fbdao.getF(room_no);
    if(list != null) {
    for(int i = 0; i < list.size(); i++) {
    	Facility_Brief fb = list.get(i);

    	 %>
<tr>
    		<td><%=fb.getFacility_no()%></td>
    		 <td><%=fb.getType().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
    		 <td><%=fb.getName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
    		 <td><%=fb.getAmount()%></td>
    	     <td><a href = "#modifyfacilitybrief" data-toggle = "modal">개수 수정</a>
	   <div class = "modal fade" id = "modifyfacilitybrief" tabindex = "-1" role = "dialog" aria-labelledby = "modal">
	<div class = "modal-dialog">
	<div class = "modal-content">
	<div class = "modal-header">
	<h5 class = "modal-title" id = "modal">개수 수정</h5>
	<button type = "button" class = "close" data-dismiss="modal" aria-label="Close">
	<span aria-hidden = "true">&times;</span>
	</button>
	</div>
		<div class = "modal-body">
	<form action="modifyfacilitybrief.jsp?room_no=<%= room_no%>&facility_no=<%= fb.getFacility_no() %>" method = "post">
	
<div class = "form-row">
	<label>개수</label>
	<input type = "number" name = "number" class = "form-control" maxlength = "5" placeholder = "개수" style ="height:50px">
	</div>
	
	<div class = "modal-footer">
	<button type = "button" class = "btn btn-secondary" data-dismiss="modal" aria-label="Close">취소</button>
	<button type = "submit" class = "btn btn-danger">수정</button>
	</div>
	</form>
</div>
	
	</div>
	
	</div>
	
	</div>
	</td>
    	      <td><a onclick = "return confirm('정말로 삭제하시겠습니까?')" href = "briefdelete.jsp?room_no=<%= room_no%>&facility_no=<%= fb.getFacility_no()%>">삭제</a></td>
    	</tr>
  
    	<%
    }
    %>
   
<%
    	}
    System.out.println(room_no);
    	 %>
    
    	 <tr>
             <td><a href = "#addfacilitybrief" data-toggle = "modal">+추가</a>
	   <div class = "modal fade" id = "addfacilitybrief" tabindex = "-1" role = "dialog" aria-labelledby = "modal">
	<div class = "modal-dialog">
	<div class = "modal-content">
	<div class = "modal-header">
	<h5 class = "modal-title" id = "modal">자재로부터 추가하기</h5>
	<button type = "button" class = "close" data-dismiss="modal" aria-label="Close">
	<span aria-hidden = "true">&times;</span>
	</button>
	</div>
		<div class = "modal-body">
	<form action="./addfacilitybrief.jsp?room_no=<%= room.getRoom_no() %>&facility_no=<%= bdao.maxNum(room.getRoom_no())  %>" method = "post">
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>종류</label>
		
	<select name="emailCheck" class = "form-control"
onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)">
 <option value="notSelected" >::선택하세요::</option>
    <option value="etc">직접입력</option>
    <%
   Facility fac = new Facility();
    FacilityDAO fd = FacilityDAO.getInstance();
    List<Facility> faclist = fdao.getAllFacility();
    String type = null;
    for(int i = 0; i < faclist.size(); i++) {
    	fac = faclist.get(i);
         type = fac.getType();
    	  %>
    <option value = "<%=type %>"><%=type.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></option>
    	<%
    }
    %>
   </select>
	</div>
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>수량</label>
	
	<input type = "number" name = "amount" class = "form-control" maxlength = "50"  placeholder = "수량">
	</div>
	</div>
	<div class = "form-row">
	<div class = "form-group col-sm-4">
	<label>시리얼</label>
	<input type = "text" name = "serial" class = "form-control" maxlength = "50"  placeholder = "시리">
    		
    	 

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
	  </tr>
    	
   
	  
    </table>
    

</div>
    </div>
  

     <footer style="text-align:center;" style="border-top:1px solid #666;" style= "height:70px;" style="line-height:70px;" style="margin:0;"   style = "padding:0;">
        Copyright (C) 2018 Hyung Taek Kwon All Right Reserved
        </footer>
    
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


</body>
</html>
