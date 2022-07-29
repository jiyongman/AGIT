<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
            	<li class="active"><a href="main.jsp">홈</a></li>
            	<li><a href="bbs.jsp">자유게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p></p>
				<p>이 웹사이트는 부트스트랩으로 만든 JSP 웹 사이트입니다.</p>
				<p>회원가입 및 로그인 후 이용해주시기 바랍니다.</p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>