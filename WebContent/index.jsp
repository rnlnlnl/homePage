<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Mustache Enthusiast</title>
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/newstyle.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<script type="text/javascript" src="js/mobile.js"></script>
	
</head>
<body>
 
<div id="header">
<jsp:include page="./inc/top.jsp"/>
	</div>	
	<div id="body">
		<div id="featured">
			<img src="images/gamess.jpg" alt="" >
			 <div>
				<h2>즐겜을 위하여</h2><br>
				<span>모두 즐거운 시간 되시길</span><br>
				<span>자기가 좋아 하는 게임을 찾읍시다</span><br>
				<span>할만한 게임 에는 여러 게임이 소개 되어있습니다</span><br>
				<a href="/HomePage/easy/about.jsp" class="more">할만한 게임 바로가기</a>
			</div>
		</div>
		<ul>
			<li>
				<a href="https://know.search.naver.com/knowrender.naver?where=nexearch&pkid=3001&tab=home&u1=GM_4&os=6633264"><!-- 연결바꿔 줘야함 -->
					<img src="images/BG.jpg" alt="">
					<span><h3>배틀그라운드</h3></span>
				</a>
			</li>
			<li>
				<a href="https://know.search.naver.com/knowrender.naver?where=nexearch&pkid=3001&tab=gamedb&u1=GM_412&os=4426774"><!-- 연결바꿔 줘야함 -->
					<img src="images/overwatch.jpg" alt="">
					<span><h3>오버워치</h3></span>
				</a>
			</li>
			<li>
				<a href="https://know.search.naver.com/knowrender.naver?where=nexearch&pkid=3001&tab=home&u1=GM_1&os=6633263"><!-- 연결바꿔 줘야함 -->
					<img src="images/LOL.jpg" alt="">
					<span><h3>리그오브레전드</h3></span>
				</a>
			</li>
		</ul>
	</div>
<jsp:include page="./inc/footer.jsp"/> 
	
</body>
</html>