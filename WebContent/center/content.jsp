<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/footer.css" rel="stylesheet" type="text/css">
<%
	
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//gallery.jsp에서 하나의 글행을 클랙해서 전달하여 넘어온 num, pageNum가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//DB작업을 위한 객체 생성
	BoardDAO dao = new BoardDAO();
	
	//글의 조회수 증가를 위한 메소드 호출
	dao.updateReadCount(num);
	
	//글 상세 내용 을 볼 글 에 대한 글번호 전달하여 DB로부터 검색해서 가져오기
	BoardBean boardBean = dao.getBoardBean(num);
	
	int DBnum = boardBean.getNum();//검색한 글번호
	int DBReadcount = boardBean.getReadcount();//검색한 글에 대한 조회수
	String DBName = boardBean.getName();//검색한 글쓴이 이름
	Timestamp DBDate = boardBean.getDate();//검색한 글의 작성일
	String DBSubject = boardBean.getSubject();//검색한 글 제목
	String DBContent = "";//검색한 글내용을 저장할 변수
	//검색한 글 내용이 있다면  //글 작성시 엔터키를 통해 입력 했던 부분 처리
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("\r\n", "<br/>");
	}
	int DBRe_ref = boardBean.getRe_ref();//부모글과 답변글을 판단 할수 있는 GROUP값
	int DBRe_lev = boardBean.getRe_lev();//답변글의 들여 쓰기 정도값
	int DBRe_seq = boardBean.getRe_seq();
	
	
	
	
%>
</head>
<body>
<jsp:include page="/inc/top.jsp" />
		<article>
		
			<h1>글 보기</h1>
			<div id="cente">
			<div id="cente1">
			<table id="notice" border="1" width="1000" height="500">
				<tr>
					<td>글번호</td>
					<td><%=DBnum %></td>
					<td>조회수</td>
					<td><%=DBReadcount %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><%=DBName %></td>
					<td>작성일</td>
					<td><%=DBDate %></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td colspan="3"><%=DBSubject %></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td colspan="3"><%=DBContent %></td>
				</tr>
				
			</table>
			</div>
			</div>
			<%
				//각각의 패이지에서 .. 로그인후 이동해 올때 .. session영역에서 저장되어있는 id값 반환
				String id = (String) session.getAttribute("id");
				//세션값이 저장되어 있으면 글쓰기 버튼이 보이게 설정
				if (id != null) {
			%>
			<div id="table_search">
				<input type="button" value="글수정" class="btn"
						onclick="location.href='update.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
				<input type="button" value="글삭제" class="btn"
						onclick="location.href='delete.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
				<input type="button" value="답글쓰기" class="btn"
						onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">
			
			<%
				}
			%>
				<input type="button" value="목록 보기" class="btn" 
				       onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
			
			
			</div>
			
		
			
			<div class="clear"></div>
			<div id="page_control">
				<%--아래의 페이지 번호 출력 부분 --%>
				
				
				
				
			</div>
		</article>
		<jsp:include page="/inc/footer.jsp" />
</body>
</html>