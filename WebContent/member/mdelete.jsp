<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
</head>
<body>
<%
	String id = (String)session.getAttribute("id");

%>
<jsp:include page="/inc/top.jsp" />
<form action="mdeletePro.jsp" method="post">
	<div>
	<h2>회원을 탈퇴 하시려면 NO버튼을 클릭해 주세요</h2>
	<img alt="" src="../images/gameover.jpg"><br><br>
	<h3>CONTINUE!!</h3>
	<div id="table_search">
	<a href="../index.jsp"><input type="button" value="YES"></a>
	<input type="submit" value="NO" class="btn">
	</div>
	</div>
</form>
<jsp:include page="/inc/footer.jsp" />

</body>
</html>