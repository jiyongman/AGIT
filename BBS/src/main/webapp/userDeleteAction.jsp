<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title>아지트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 탈퇴 가능합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.delete(userID);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 탈퇴에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			session.invalidate();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>