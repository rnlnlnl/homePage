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
	<h1>reWritePro.jsp</h1>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//reWrite.jsp에서 입력한 답변글 내용 + 주글 정보를 request영역에서 꺼내와서
		//BoardBean객체의 각변수에 저장
			
	 %>
	 <jsp:useBean id="bBean" class="board.BoardBean"/>
	 <jsp:setProperty property="*" name="bBean"/>
	 <%
	 	//답변글 작성 날짜 및 시간 저장
	 	bBean.setDate(new Timestamp(System.currentTimeMillis()));
	 	//답변글 작성하는 사람의 IP주소 저장
	 	//답변글을 DB에  INSERT 하기위해 메서드 호출
	 	BoardDAO dao = new BoardDAO();
	 	//(답변글 작성 내용 + 주글의 그룹번호 , 들여쓰기 정도값 , 위치번호 )가 저장 되어있는 BoardBean객체 전달
	 	dao.reInsertBoard(bBean); 
	 	//답변글 추가에 성공하면 notice.jsp로 이동 (재요청 이동)
	 	response.sendRedirect("gallery.jsp");
	 	
	 	
	 %>
	 
	 
	 
</body>
</html>