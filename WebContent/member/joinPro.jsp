<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. join.jsp페이지에서 입력한 회원 데이터 중에서 한글이 하나라도 존재하면 한글이 깨짐으로 
//  request내장객체 영역에 유지되어 있는 데이터들을 인코딩방식 코딩
/* 한글 처리*/
request.setCharacterEncoding("UTF-8");
%>
<!--
2.join.jsp체이지에서 입력한 회원 데이터 들을 request내장 객체 영역에서 꺼내어서
 MemberBean객체의 각변수에 저장-->
<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>

<%
//2-1 reg_date 변수에 현재 회원 가입 날짜정보 추가로 저장
//System.currentTimeMillis() 현재 컴퓨터 시간을 반환
memberbean.setReg_date(new Timestamp(System.currentTimeMillis()));

//3. 먼저 해야할일
//회원 추가 DB작업을 하는 insertMember()라는 메서드를  MemberDAO.java파일에 추가

//4. DB작업 (DB에 입력한 회원 정보 추가)할 MemberDAO객체 생성
MemberDAO memberDao = new MemberDAO();

//4-1. insert()메서드 호출시 인자로 MemberBean객체를 전달하여 DB에 작업함
memberDao.insertMember(memberbean);

//5.회원가입 에 성공 했다면 login.jsp로 이동(재요청하여 이동)
response.sendRedirect("login.jsp");



%>
