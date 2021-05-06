<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <script type="text/javascript" src="/HomePage/js/mobile.js"></script>
     <link rel="stylesheet" type="text/css" href="/HomePage/css/top.css">
     
    <div class="clear"></div>

<header>
<%
		//session내장객체 영역에 저장되어 있는 세션값 얻기
		String id = (String)session.getAttribute("id");
			
		//session내장객체 영역에 아이디값이 존재 하지 않으면(로그아웃 상태)
		if(id == null){
%>

	<div id="login">
		<a href="/HomePage/member/login.jsp">로그인</a>  
		<a href="/HomePage/member/join.jsp">회원가입</a>
	</div><br>
<%				
		}else {//session영역에 값이 저장되어 있다면?
%>
	<div id="login">
		<%=id %>님 로그인중
		<a href="/HomePage/member/logout.jsp">logout</a>  <%--../member/logout.jsp 가능--%>
	</div>			
	<div id="getchange">
		<a href="/HomePage/member/pass_change.jsp"><input type="button" value="정보 변경" class="btn"></a>
		<a href="/HomePage/member/mdelete.jsp"><input type="button" value="회원 탈퇴" class="btn"></a>
	</div>
<%		
			}
%>
<div id="header">
	<a href="/HomePage/index.jsp" class="logo">
			<img src="/HomePage/images/game.jpg" alt="">
		</a>
		<ul id="navigation">
			<li class="selected">
				<a href="/HomePage/index.jsp">홈</a>
			</li>
			<li>
				<a href="/HomePage/easy/about.jsp">할만한 게임</a>
			</li>
			<li>
				<a href="/HomePage/center/gallery.jsp">커뮤니티</a>
			</li>
			<li>
				<a href="/HomePage/gon/blog.jsp">자랑 이미지</a>
			</li>
		</ul>
	</div>
</header>
 	
 	
<!--  		<div class="quick">
				
				<ul>
					<li>
						<h2>결재</h2>
					</li>
					<li>
						<a href="http://pinfactory.co.kr/yc/shop/item.php?it_id=1504355920">
							<img src="/HomePage/images/googel.jpg" alt="구글 기프트" />
						</a>
					</li>
					<li>
						<a href="http://www.cultureland.co.kr/main.do">
							<img src="/HomePage/images/money.jpg" alt="문화상품권" />
						</a>
					</li>
					<li>
						<a href="http://www.happymoney.co.kr/svc/#">
							<img src="/HomePage/images/happy.png" alt="해피머니" />
						</a>
					</li>
					<li>
						<a href="#">
							<img src="/HomePage/images/quick_top_btn.png" alt="상단으로 이동" />
						</a>
					</li>
				</ul>
	</div>
	
	
	<script type="text/javascript">
	$(function(){  
	var currentPosition = parseInt($(".quick").css("top")); 
    $(window).scroll(function() { 
            var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다. 
            $(".quick").stop().animate({"top":position+currentPosition+"px"},500); 
    });
});
	</script> -->
	<%--   	 <script>
	$(function () {	
		
		 /*옆쪽 퀵 메뉴*/
		//index.html 처음 실행 했을때 문서 상단에서  퀵 메뉴 의 여백 거리값을 구하기 위해 position의 속성의 top값을 구함
		//이때 px단위 가 붙게 되는데  정수만 남기기 위 해 parseInt()메소드를 이용하여 정수값을 얻는다
		//요약 : 기본 문서 상단에서 퀵 메뉴 가 이동한 거리값을 구한다
		
		var defaultTop = parseInt($("#quick_menu").css("top")); // "100px"->100
		
		//윈도우 창의 (window)에 스크롤바가 이동 될때마다...
		$(window).on("scroll",function(){
			//스크롤바가 이동 할때마다  스크롤바의 이동 높이 값을  반환하여 scv변수에 저장
			
			var scv = $(window).scrollTop();
			
			$("#quick_menu").stop().animate({"top":scv+defaultTop+"px"}, 1000);
			
		});

	});

	</script>  --%>
	
