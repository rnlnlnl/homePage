<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<%
		//세션 영역의 값 초기화
		session.invalidate();
	
	%>
	<script type="text/javascript">
		window.alert("로그아웃");
		location.href="../index.jsp";
		
		
	</script>
