<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/* 한글 처리*/
	request.setCharacterEncoding("UTF-8");

	//1.login.jsp페이지로부터 로그인을 하기위해 사용자가 입력한
	//아이디 , 비밀번호 값을request영역에서 꺼내오기
	String id = request.getParameter("id");
	String passwd = request.getParameter("pass");
	
	//2.DB작업할MemberDAO객체 생성
	MemberDAO memberdao = new MemberDAO();
	
	//3.MemberDAO.java 파일에.....userCheck()메소드 추가하기
	//설명) 입력받은 id passwd가 DB에 존재 하는지 확인

	//4.check =1 ->아이디, 비밀번호 맞음
	//4.check =0 ->아이디, 비밀번호 틀림
	//4.check =-1 ->아이디 틀림
	int check = memberdao.userCheck(id, passwd);
	
	if(check == 1){//아이디, 비밀번호 가 DB에 저장되어있다면  ->로그인 시켜야함
		
		//login.jsp에서 입력한 아이디값을 session내장객체 영역에 저장
		session.setAttribute("id", id);
		
		//index.jsp를 재요청해 이동할, 이동시 ..session내장객체 메모리 영역은 유지
		response.sendRedirect("../index.jsp");
	
	}else if(check == 0){//아이디는 맞고 비밀번호가 틀릴때
%>		
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();//이전페이지 login.jsp로 이동
	</script>	
<%		
	}else{//check == -1 아이디 틀림 (없음)
%>	
	<script type="text/javascript">
		alert("아이디 없음");
		history.back();//이전페이지 login.jsp로 이동
	</script>	
		
<%		
	}
%>
<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>

<%









 %>