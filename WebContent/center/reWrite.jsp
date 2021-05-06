<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
</head>
<%
	//답글달기
	
	//세션값을 얻어 세션값이 없으면 로그인이 되지않는 상태이므로 ...login.jsp로 이동하게 한다
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//content.jsp에서 답변쓰기 버튼을 클릭해서 전달하여 넘어온 주글num, re_ref, re_lev, re_seq가졍오기
	int num = Integer.parseInt(request.getParameter("num"));
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	
	
	
	
	
%>


<body>
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
			<h1>답변글 작성</h1>
			<div id="cente">
			<div id="cente1">
		<form action="reWritePro.jsp" method="post">
			<%--주글 글번호, 주글의 그룹값, 들여쓰기정도, 주글순서값 --%>
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="re_ref" value="<%=re_ref%>">
			<input type="hidden" name="re_lev" value="<%=re_lev%>">
			<input type="hidden" name="re_seq" value="<%=re_seq%>">
			
			<table id="notice">
				<tr>
					<td>답변글 작성자</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>답변글 비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>답변글 제목</td>
					<td><input type="text" name="subject" value="[답글]"></td>
				</tr>
				<tr>
					<td>답변글내용</td>
					<td>
						<textarea rows="13" cols="40" name="content"></textarea>
					</td>
				</tr>
			</table>
			</div>
			</div>
			
			<div id="table_search">
				<input type="submit" value="답글작성" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="목록 보기" class="btn" 
				       onclick="location.href='gallery.jsp'">
			
			
			</div>
		</form>	
			
			<div class="clear"></div>
			<div id="page_control">
				<%--아래의 페이지 번호 출력 부분 --%>
	
			</div>
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



