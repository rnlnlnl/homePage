<%@page import="imgboard.ImgBoardBean"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>

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
	//글수정을 위한 글 상세 보기 페이지
	
	//세션값을 얻어 세션값이 없으면 로그인이 되지않는 상태이므로 ...login.jsp로 이동하게 한다
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//content.jsp에서 글수정 버튼을 클릭해서 전달하여 넘어온 num, pageNum가졍오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//DB작업을 위한 객체 생성
	ImgBoardDAO dao = new ImgBoardDAO();
	
	//수정할 글에 대한 글번호 전달하여 DB로부터 검색해서 가져오기
	ImgBoardBean boardBean = dao.getBoardBean(num);
	
	int DBnum = boardBean.getNum();//검색한 글번호
	int DBReadcount = boardBean.getReadcount();//검색한 글에 대한 조회수
	String DBName = boardBean.getName();//검색한 글쓴이 이름
	String DBFile = boardBean.getFile();//검색한 이미지 파일
	Timestamp DBDate = boardBean.getDate();//검색한 글의 작성일
	String DBSubject = boardBean.getSubject();//검색한 글 제목
//이미지 업로딩 함수 file필요
	String DBContent = "";//검색한 글내용을 저장할 변수
	//검색한 글 내용이 있다면  //글 작성시 엔터키를 통해 입력 했던 부분 처리
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br/>", "\r\n");
	}
	int DBRe_ref = boardBean.getRe_ref();//부모글과 답변글을 판단 할수 있는 GROUP값
	int DBRe_lev = boardBean.getRe_lev();//답변글의 들여 쓰기 정도값
	int DBRe_seq = boardBean.getRe_seq();
	
	
	
	
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
			<h1>글 수정</h1>
			<div id="cente">
			<div id="cente1">
		<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post">
			
			<input type="hidden" name="num" value="<%=num%>">
			
			<table id="notice">
				<tr>
					<td>작성자</td>
					<td><input type="text" name="name" value="<%=DBName%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>이미지</td>
					<td><input type="file" name="file" value="<%=DBFile %>" readonly></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject%>"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea rows="13" cols="40" name="content"><%=DBContent%></textarea>
					</td>
				</tr>
			</table>
			<img alt="" src="">
			</div>
			</div>
			
			<div id="table_search">
				<input type="submit" value="글수정" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="목록 보기" class="btn" 
				       onclick="location.href='blog.jsp?pageNum=<%=pageNum%>'">
			
			
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



