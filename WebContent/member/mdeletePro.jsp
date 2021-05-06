<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");	
		
		String id = (String)session.getAttribute("id");	
	
		MemberDAO dDao = new MemberDAO();
	
		dDao.deleteDao(id);
	
	%>
	<script type="text/javascript">
		alert("회원 탈퇴 되셨습니다");
		
		location.href="../index.jsp";
	</script>
	<%
	session.invalidate();
	%>
</body>
</html>