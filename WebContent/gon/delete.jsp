<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
</head>
<body>
<%
	//세션값 얻기
	//세션값을 가져오는 이유 : 글쓰기  화면에 로그인한 사람의 아이디를 출력 해주기 위한 용도
	String id = (String)session.getAttribute("id");
//세션값이 없으면 login.jsp로가서 로그인 하고 오세요
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	//content.jsp(글상세보기화면)에서 삭제 버튼을 클릭했을때
	//삭제할 글번호 , 삭제할 글이 존재하는 페이지번호 전달 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
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
			<h1>삭제</h1>
			<div id="cente">
			<div id="cente1">
		<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
			
			<input type="hidden" name="num" value="<%=num%>">
			
			<table id="notice">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" id="passwd"></td>
				</tr>
			</table>
			
			<div id="table_search">
				<input type="submit" value="글삭제" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글 목록" 
				       class="btn" onclick="location.href='blog.jsp?pageNum=<%=pageNum%>'">
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



