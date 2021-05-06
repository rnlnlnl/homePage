<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>updatePro.jsp</h1>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//수정할 글이 속해있는 페이지 번호 얻기
		String pageNum = request.getParameter("pageNum");
		//수정할 글번호, 글 제목, 글 내용 글 수정 을위한 입력한 비밀번호 값을
		//request영역에서 얻어...BoardBean객체의 각변수에 저장
	%>
	<jsp:useBean id="bBean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bBean"/>
	<%
		//글수정 DB작업을 위한 객체 생성
		BoardDAO bdao = new BoardDAO();
	
		int check =bdao.updateBoard(bBean);
		 
		//check == 1 "수정성공" , notice.jsp 로이동
		//check == 0 "비밀번호 틀림" , update.jsp 뒤로로이동
		if(check == 1){
	%>
		<script type="text/javascript">
			alert("글 수정 성공");
			location.href="gallery.jsp?pageNum=<%=pageNum%>";
		</script>
	<%
		}else{//check == 0
	%>
		<script type="text/javascript">
			alert("비밀번호 틀림")
			history.go(-1)
		
		</script>
	<%
		}
	%>
	
	
	
</body>
</html>