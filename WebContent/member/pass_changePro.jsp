<%@page import="member.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* 한글 처리*/
request.setCharacterEncoding("UTF-8");

%>
<jsp:useBean id="mBean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mBean"/>

<%

MemberDAO dao = new MemberDAO();
dao.upMember(mBean);

 %>
<script type="text/javascript">
			alert("변경 성공")
			location.href="../index.jsp";
		</script>
 