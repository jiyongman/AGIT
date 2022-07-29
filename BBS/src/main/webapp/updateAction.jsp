<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
			script.println("alert('로그인 후 수정 가능합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 되지 않은 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(request.getParameter("bbsTitle"), request.getParameter("bbsContent"), bbsID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp?pageNumber=1'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>