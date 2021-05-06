<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="/inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->
		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>로그인</h1>
			<form action="loginPro.jsp" method="post" id="join">
				<div id="cente">
					<div id="cente1">
						<fieldset id="field">
							<legend>로그인</legend>
							<label>아이디</label> <input type="text" name="id"><br>
							<label>비밀번호</label> <input type="password" name="pass"><br>
						</fieldset>
					</div>
				</div>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="로그인" class="submit"> 
					<input type="button" value="다시쓰기" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		
	</div>
	<jsp:include page="/inc/footer.jsp"/>  
</body>
</html>