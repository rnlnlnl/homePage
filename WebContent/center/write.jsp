<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Value"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/top.css" rel="stylesheet" type="text/css">
<link href="../css/footer.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	MemberDAO dao = new MemberDAO();
	MemberBean memberBean = dao.getMember(id);
	String pass = memberBean.getPasswd();
%>	
	function passch() {
		var passwd = document.getElementById("passwd");


		if(passwd.value != <%=pass%>){
			alert("입력한 비밀번호가 틀렸습니다.")
			passwd.value=""
			return false;
		}

	}




</script>

</head>
<body>
	
<%
	//세션값 얻기
	//세션값을 가져오는 이유 : 글쓰기  화면에 로그인한 사람의 아이디를 출력 해주기 위한 용도
	/* String id = (String)session.getAttribute("id"); */
	
//세션값이 없으면 login.jsp로가서 로그인 하고 오세요
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	

%>
	
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="/inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 게시판 -->
		<article>
			<h1>커뮤니티 계시판</h1>
		<div id="cente">
		<div id="cente1">
		<form action="writePro.jsp" method="post" onsubmit="return passch();">
			<table id="notice">
				<tr>
					<td>글쓴이</td>
					<td><input type="text" name="name" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" id="passwd" required></td>
				</tr>
				<tr>
					<td>글재목</td>
					<td><input type="text" name="subject" required></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea name="content" rows="13" cols="40" required></textarea></td>
				</tr>
				
			</table>
			<div id="table_search">
				<input type="submit" value="글쓰기" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글 목록" 
				       class="btn" onclick="location.href='gallery.jsp'">
			</div>
		</form>
		</div>
		</div>	
			<div class="clear"></div>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="/inc/footer.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>



