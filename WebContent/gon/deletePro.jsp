<%@page import="imgboard.ImgBoardDAO"%>
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
		//delete.jsp(글삭제 비밀번호 입력 화면)에서 삭제 버튼을 클릭시..
		//삭제할 글번호, 삭제할 글이 속해 있는 페이지 번호 , 글 삭제시 입력한 글 비밀 번호 얻기
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String passwd = request.getParameter("passwd");
		
		//글 삭제 DB작업을 위한 BoardDAO객체 생성
		ImgBoardDAO bdao = new ImgBoardDAO();
		
		//글 삭제에 성공하면 1을 반환
		//글 삭제에 실패하면 0을 반환 -> 입력한 글에 대한 비밀번호가 틀릴때..
		int check = bdao.deleteBoard(num,passwd);
		 
		if(check == 1){
	%>		
		<script type="text/javascript">
			alert("글 삭제 성공");
			location.href = "blog.jsp?pageNum=<%=pageNum%>";
		</script>	
	<%		
		}else{
	%>		
		<script type="text/javascript">
			alert("비밀번호 틀림");
			history.go(-1); //history.back(); //delete.jsp 로이동
		</script>	
	<%		
		}
	
	%>
	
	
	
	
</body>
</html>