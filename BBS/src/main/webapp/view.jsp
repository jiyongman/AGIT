<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>아지트</title>
<style type="text/css">
	a, a:hover {
		color: #ffffff;
		text-decoration: none;
	}
	th, th:hover {
		color: #ffffff;
		text-decoration: none;
	}
	td, td:hover {
		color: #ffffff;
		text-decoration: none;
	}
</style>
</head>
<body>
	<body style='background-color: #333333;'>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		int commentID = 0;
		if (request.getParameter("commentID") != null) {
			commentID = Integer.parseInt(request.getParameter("commentID"));
		}
		Comment comment = new CommentDAO().getComment(commentID);
	%>
	<nav class="navbar navbar-inverse">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">아지트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        	<ul class="nav navbar-nav">
            	<li><a href="main.jsp">홈</a></li>
            	<li class="active"><a href="bbs.jsp">자유게시판</a></li>
     		</ul>
     		<%
     			if (userID == null) {
     		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
                     	data-toggle="dropdown" role="button" aria-haspopup="true"
                    	aria-expanded="false">접속하기<span class="caret"></span></a>
        			<ul class="dropdown-menu">
        				<li><a href="join.jsp">회원가입</a></li>
             			<li><a href="login.jsp">로그인</a></li>
             			
                     </ul>
				</li>
			</ul>
			<%
     			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
                     	data-toggle="dropdown" role="button" aria-haspopup="true"
                    	aria-expanded="false">회원관리<span class="caret"></span></a>
        			<ul class="dropdown-menu">
        				<li><a href="userUpdate.jsp">내 정보</a></li>
             			<li><a href="logoutAction.jsp">로그아웃</a></li>
                     </ul>
				</li>
			</ul>
			<% 
     			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #222222; text-align: center;">자유게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>글쓴이</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 16) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 500px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>조회</td>
						<td colspan="2"><%= bbs.getBbsCount() + 1 %></td>
					</tr>
					<tr>
						<td>추천</td>
						<td colspan="2"><%= bbs.getLikeCount() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container">
     	<div class="row">
          	<table class="table" style="text-align: center; border: 1px solid #dddddd">
             	<tbody>
             		<tr>
              			<td align="left">댓글</td>
           			</tr>
            		<tr>
               		<%
               			CommentDAO commentDAO = new CommentDAO();
              			ArrayList<Comment> list = commentDAO.getList(bbsID);
               			for(int i = 0; i < list.size(); i++) {
               		%>
          			<div class="container">
                		<div class="row">
                			<table class="table" style="text-align: center; border: 1px solid #dddddd">                  	
                				<tbody>
                					<tr>
                						<td align="left"><%= list.get(i).getUserID() %></td>
                						<td align="left"><%= list.get(i).getCommentContent() %></td>
                						<td align="right"><%= list.get(i).getCommentDate().substring(0, 16) %></td>
               							<td align="right"><a href="commentUpdate.jsp?bbsID=<%= bbsID %>&commentID=<%= list.get(i).getCommentID() %>" class="btn btn-warning">수정</a>
                						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?bbsID=<%= bbsID %>&commentID=<%= list.get(i).getCommentID() %>" class="btn btn-danger">삭제</a></td>
               						</tr>
                				</tbody>
                			</table>
         				</div>
           			</div>
        			<%
                  		 }
              		%>
                	</tr>
                </tbody>
          	</table>
       	</div>
    </div>
<div class="container">
	<div class="row">
    	<form method="post" action="submitAction.jsp?bbsID=<%= bbsID %>">
          	<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
             	<tbody>
                	<tr>
                   		<td align="left"><%=userID %></td>
                	</tr>
                	<tr>
                   		<td><input type="text" class="form-control" placeholder="댓글 쓰기" name="commentContent" maxlength="300"></td>
                	</tr>
             	</tbody>
          	</table>
          	<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<a onclick="return confirm('추천하시겠습니까?')" href="likeAction.jsp?bbsID=<%=bbsID %>" class="btn btn-success">추천</a>
			<input type="submit" class="btn btn-primary pull-right" value="댓글 쓰기">
			<%	
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-danger pull-right">삭제</a>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-warning pull-right">수정</a>
			<%
				}
			%>
			</form>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>