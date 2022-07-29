<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
	<%
		BbsDAO bbs = new BbsDAO();
	%>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
							<option value="bbsTitle">제목</option>
							<option value="bbsContent">내용</option>
							<option value="userID">글쓴이</option>
							<option value="comment">댓글</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-primary">검색</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<br>
	<div class="container">
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #222222; text-align: center;">번호</th>
						<th style="background-color: #222222; text-align: center;">제목</th>
						<th style="background-color: #222222; text-align: center;">글쓴이</th>
						<th style="background-color: #222222; text-align: center;">작성일</th>
						<th style="background-color: #222222; text-align: center;">조회</th>
						<th style="background-color: #222222; text-align: center;">추천</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 16) %></td>
						<td><%= list.get(i).getBbsCount() %></td>
						<td><%= list.get(i).getLikeCount() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class=container style="text-align: center">
				<%
					if (pageNumber != 1) {
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>">◀</a>
				<%
					}
				%>
				<%
					int n = (int) (bbsDAO.getCount() / 10 + 1);
					for (int i = 1; i <= n; i++) {
				%>
				<a href="bbs.jsp?pageNumber=<%= i %>"><%= i %></a>
				<%
					}
				%>
				<%
					if (bbsDAO.nextPage(pageNumber + 1)) {
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>">▶</a>
				<%
					}
				%>
				<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>