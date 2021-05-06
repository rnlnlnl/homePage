<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 API KEY를 사용하세요&libraries=services"></script>
 <script type="text/javascript">
 	
 	function winopen() {
		//아이디를 입력하지 않았다면.. 포커스 주기
		//fr은 : form태그의 name속성값
	/* 	if(document.fr.id.value == ""){
			alert("아이디를 입력하세요");
			document.fr.id.focus();
			return;
		} */
 	
 		
		
 		//아이디를 입력했다면
 		//입력한 아이디값 얻기
 		var fid = document.fr.id.value;
 		
 		//창열기
 		window.open("join_IDcheck.jsp?userid="+fid, "", "width=400,height=200");
 		
 		
	}
	
 	
 	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
	    position: new daum.maps.LatLng(37.537187, 127.005476),
	    map: map
	});


	function sample5_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = data.address; // 최종 주소 변수
	
	            // 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("address").value = addr;
	            // 주소로 상세 정보를 검색
	            geocoder.addressSearch(data.address, function(results, status) {
	                // 정상적으로 검색이 완료됐으면
	                if (status === daum.maps.services.Status.OK) {
	
	                    var result = results[0]; //첫번째 결과의 값을 활용
	
	                    // 해당 주소에 대한 좌표를 받아서
	                    var coords = new daum.maps.LatLng(result.y, result.x);
	                    // 지도를 보여준다.
	                    mapContainer.style.display = "block";
	                    map.relayout();
	                    // 지도 중심을 변경한다.
	                    map.setCenter(coords);
	                    // 마커를 결과값으로 받은 위치로 옮긴다.
	                    marker.setPosition(coords)
	                }
	            });
	        }
	    }).open();
	}
		
	
		function logins() {
			var id = document.getElementById("id");
			var passwd = document.getElementById("passwd");
			var passwd2 = document.getElementById("passwd2");
			var name = document.getElementById("name");
			var email = document.getElementById("email");
			var age = document.getElementById("age");
			var address = document.getElementById("address");
			var tel = document.getElementById("tel");
			var mtel = document.getElementById("mtel");
			<%
				String DBid = (String)session.getAttribute("id");
			%>
			
		
			if(id.value.length<4 || id.value.length>13){
				alert("아이디는 5자 ~ 12자 이내 입니다.");
				document.fr.id.focus();
				return false;
			}
		
		
		
		if(passwd.value.length<8 || passwd.value.length>13){
			alert("비밀번호는 8자 ~ 12자 이내로 입력해야 합니다");
			passwd.value=""
			document.fr.passwd.focus();
			return false;
		}
		
		if(passwd2.value != passwd.value){
			alert("두 입력한 비밀번호가 일치하지 않습니다");
			passwd2.value=""
			document.fr.passwd2.focus();
			return false;
		}
		
		if(age.value == ""){
			alert("나이를 입력해 주세요");
			document.fr.age.focus();
			return false;
		}
		
		if(name.value == ""){
			alert("이름을 입력해 주세요");
			document.fr.name.focus();
			return false;
		}
		
		if(email.value == ""){
			alert("이메일을 입력해 주세요");
			document.fr.email.focus();
			return false;
		}
		
		if(address.value == ""){
			alert("주소를 입력해 주세요");
			document.fr.address.focus();
			return false;
		}
		
		if(tel.value == ""){
			alert("전화번호를 입력해 주세요");
			document.fr.tel.focus();
			return false;
		}
		
		if(mtel.value == ""){
			alert("휴대전화번호를 입력해 주세요");
			document.fr.mtel.focus();
			return false;
		}
		
		
	}	
 </script>

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

		<!-- 본문내용 -->
		<article>
			<h1>회원 가입</h1>
			<form onsubmit="return logins();" action="joinPro.jsp" method="post" name="fr" id="join">
				<div id="cente">
				<div id="cente1">
				<fieldset id="field">
					<legend>회원가입</legend>
					<label>아이디</label> <input type="text" name="id" class="id" id="id" onblur="winopen();" required>
						<input type="button" value="아이디 체크" class="dup" id="dup" onclick="winopen();" required><br>
					<label for="passwd">비밀번호</label>
						<input type="password" name="passwd" id="passwd" class="passwd" onkeyup="passs();" required/><br>
					<label for="passwd2">비밀번호 재확인</label>
						<input type="password" name="passwd2" id="passwd2" class="passwd2" onkeyup="passs();" required/><br>
						<span id="passCheck" class="check_status">&nbsp;</span>  
					<label for="age">나이</label>
						<input type="number" name="age" id="age" class="age" required><br>
					<label>이름</label> <input type="text" name="name" id="name" required><br>
					<label>성별</label> 남<input type="radio" name="gender" id="man" value="남자" checked="checked">
									   여<input type="radio" name="gender" id="girl" value="여자"><br>
					<label>이메일</label> <input type="email" name="email" id="email" required><br>
					<!-- <label>주소</label> <input type="text" name="address" id="address" required><br> -->
						<input type="text" id="address" name="address" placeholder="주소">
						<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
						<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
					<label>전화번호</label> <input type="text" name="tel" id="tel" required><br>
					<label>휴대전화번호</label> <input type="text" name="mtel" id="mtel" required><br>
				</fieldset>
				</div>
				</div>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="가입하기" class="submit" id="submit" >
					<input type="reset" value="다시쓰기" class="cancel" >
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