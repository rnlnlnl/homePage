<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>writePro.jsp</h1>
<%
	//세션값 얻기
	//세션값을 가져오는 이유 : 글쓰기  화면에 로그인하지않고 글쓰기 작업시 로그인 페이지로 이동하기위해 
	String id = (String)session.getAttribute("id");
	//세션값이 없으면 login.jsp로가서 로그인 하고 오세요

	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//한글 처리
	request.setCharacterEncoding("UTF-8");
	
	
	//write.jsp페이지에서 입력한 글내용을 request영역에서 꺼내서 BoardBean의 각 변수에 저장
	
%>
	<jsp:useBean id="bBean" class="imgboard.ImgBoardBean"/>
	
<%
	


	
	String savePath = "D:\\workspace_jsp\\HomePage\\WebContent\\images\\"; // 저장할 디렉토리 (절대경로)
	int sizeLimit = 10 * 1024 * 1024; // 10메가까지 제한 넘어서면 예외발생
	try{
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8",
				new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String passwd = multi.getParameter("passwd");
		String subject = multi.getParameter("subject");
		String content =multi.getParameter("content");
		String file = multi.getFilesystemName("file");
		
		
		//BoardBean의 변수에 현재 글쓴 날짜 와 시간 , 글쓴이의 IP주소 정보 추가로 저장
		bBean.setDate(new Timestamp(System.currentTimeMillis()));//날짜 얻어오기
		
		bBean.setName(name);
		bBean.setPasswd(passwd);
		bBean.setSubject(subject);
		bBean.setContent(content);
		bBean.setFile(file);
		//게시판 board테이블에 입력한 글내용을 추가하기 위해 DB관련 BoardDAO객체 생성
		ImgBoardDAO bdao = new ImgBoardDAO();
		
		
		
		//INSERT작업을 위한 메소드 호출
		bdao.insertBoard(bBean); //insert 
		
		//이동 notice.jsp
		response.sendRedirect("blog.jsp");
		
		
		

	
	}catch(Exception e){
		e.printStackTrace();
	}
%>



	
	
</body>
</html>