<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript">
		function result() {
			
			//join.jsp페이지의 아이디 입력 공간의 값 <-----현재 작은창 join_IDcheck.jsp창에서 입력한 ID
			opener.document.fr.id.value = document.nfr.userid.value;
			
			//작은창 닫기
			window.close();
		}
	
	</script>

</head>
<body>
	<%
		//1. join.jsp의function winopen()함수에 의해서 전달받은 userid값 가져오기
		//2.밑의 중복 확인 버튼 이 존재하는 <form>태그로 부터 받은 userid값 가져오기 
		String id = request.getParameter("userid");
		
		//3.DB작업할 MemberDAO객체 생성
		MemberDAO mdao = new MemberDAO();
		
		//4.MemberDAO클래스에..idCheck()메소드를 추가하여 입력한아이디가 DB에 존재 하는지 유무 체크하기
		
		//5.입력한 id값을 DB작업을 위한 idCheck() 메소드로 넘겨 주어서
		// 입력한 id가 DB에 존재 하는지 유무값 얻기
		//반환값이 1 - > 아이디 중복 : 우리가 입력한 아이디가 DB에 존재함
		//반환값이 0 - > 아이디 중복 아님 : 우리가 입력한 아이디가 DB에 존재 하지 않음
		int check = mdao.idCheck(id);
		
		//6.check == 1 "사용중인아이디입니다 //아이디 중복
		//	check == 0 "사용중가능한 아이디입니다 //아이디 중복 아님
		if(check == 1){
			out.println("사용중인ID입니다");
		}else{
			out.println("사용가능한 아이디 입니다");
	%>		
			<%--사용가능한 아이디이면 사용함 버튼을 눌러서 -- 부모창 (join.jap)의 아이디 입력란에 ID넣어주기 --%>
			<input type="button" value="사용함" onclick="result();">
	<%		
		}
		
	%>
		<h4>아이디는 5자 ~ 12자 이내입니다</h4>
	<form action="join_IDcheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="userid" value="<%= id%>">
		<input type="submit" value="중복확인">
	</form>
	
	
	
</body>
</html>