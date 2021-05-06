<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 API KEY를 사용하세요&libraries=services"></script>
<script type="text/javascript">
	
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
<%
//한글처리
request.setCharacterEncoding("UTF-8");

String id = (String)session.getAttribute("id");

MemberDAO dao = new MemberDAO();
MemberBean memberBean = dao.getMember(id);

String Did = memberBean.getId();
String Dpasswd = memberBean.getPasswd();
int Dage = memberBean.getAge();
String Dname = memberBean.getName();
String Demail = memberBean.getEmail();
String Daddress = memberBean.getAddress();
String Dtel = memberBean.getTel();
String Dmtel = memberBean.getMtel();


%>
</head>
<body>
	<div id="header">
		<jsp:include page="/inc/top.jsp" />
	</div>
	

	
		<article>
			<h1>정보 변경</h1>
			<div id="cente">
			<div id="cente1">
			<form onsubmit="return logins();" action="pass_changePro.jsp" method="post" name="fr" id="join">
				<fieldset>
					<legend>정보 변경</legend>
					<label>아이디</label> 
						<input type="text" name="id" class="id" id="id" value="<%=Did%>" readonly><br>
					<label for="passwd">비밀번호</label>
						<input type="password" name="passwd" id="passwd" class="passwd" value="<%=Dpasswd %>" required/><br>
					<label for="passwd2">비밀번호 재확인</label>
						<input type="password" name="passwd2" id="passwd2" class="passwd2" value="<%=Dpasswd %>" required/><br>
						<span id="passCheck" class="check_status">&nbsp;</span>  
					<label for="age">나이</label>
						<input type="number" name="age" id="age" class="age" value="<%=Dage %>" required><br>
					<label>이름</label> 
						<input type="text" name="name" id="name" value="<%=Dname %>" required><br>
					<label>이메일</label> 
						<input type="email" name="email" id="email" value="<%=Demail %>" required><br>
					<input type="text" id="address" name="address" placeholder="주소" value="<%=Daddress%>">
						<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
						<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
					<label>전화번호</label> 
						<input type="text" name="tel" id="tel" value="<%=Dtel %>" required><br>
					<label>휴대전화번호</label> 
						<input type="text" name="mtel" id="mtel" value="<%=Dmtel %>" required><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="변경하기" class="submit" id="submit" >
					<input type="reset" value="다시쓰기" class="cancel" >
				</div>
			</form>
			</div>
			</div>
		</article>
	
	<jsp:include page="/inc/footer.jsp"/> 
</body>
</html>