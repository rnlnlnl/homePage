<%@page import="imgboard.ImgBoardBean"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Blog - Mustache Enthusiast</title>
	<link rel="stylesheet" type="text/css" href="/HomePage/css/gallery.css">
    <link rel="stylesheet" type="text/css" href="/HomePage/css/footer.css">
	
	<script type="text/javascript" src="js/mobile.js"></script>
</head>
<%
	//DB작업을 위한 객체 생성
	ImgBoardDAO boardDAO = new ImgBoardDAO();

	//DB에 저장 되어있는 전체 글개수 검색
	int count = boardDAO.getBoardCount();

	//한 페이지당 보여줄 글개수 -> 5
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	//현재 보여질 (선택한)페이지 번호가 없으면? 1페이지에 처리
	if(pageNum == null){
		pageNum = "1";
	}
	
	//선택한 페이지 번호 값이 문자열 이므로 정수로 변환 해서 저장
	int currentPage = Integer.parseInt(pageNum);
	
	//각 페이지 마다 맨위에 첫번째로 보여질 시작 글번호 구하기
	//(현재 보여질 페이지 번호 -1)* 한페이지당 보여질 글개수 5
	int startRow = (currentPage -1)* pageSize;
	
	System.out.println(startRow);
	
	//Db로부터 검색한 글정보  하나하나를 각각 BoardBean객체들에 저장하여
	//다시~~ BoardBean객체들을 ArrayList배열에 저장하기 위한 ArrayList객체 생성
	List<ImgBoardBean> list = null; 
	
	//위의 count변수값을 활용해서
	//만약DB의 board테이블에 글이 저장되어 있다면?
	if(count > 0){
		//.getBoardList(각 페이지마다 맨위쪽애 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
		list = boardDAO.getBoardList(startRow, pageSize);
		
	}
	
	//날짜 형식을 설정 하는 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	
%>
<body>
<div id="header">
		<jsp:include page="/inc/top.jsp" />
	</div>
	<div id="body">
		<article>
			<h1>자랑 이미지 계시판[전체 글 개수 : <%=count %>]</h1>
			
			<table id="notice">
				<tr>
					<th class="ino">No.</th>
					<th class="iimage">이미지</th>
					<th class="ttitle">제목</th>
					<th class="twrite">글쓴이</th>
					<th class="tdate">날짜</th>
					<th class="tread">조회수</th>
				</tr>
				<%
				if(count > 0){//검색한 글이 존재 하면
					//ArrayList 크기 만큼 반복
					for(int i =0; i<list.size(); i++){
						
						ImgBoardBean bean = list.get(i);
				%>
				<tr onclick="location.href='content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
						<td><%=bean.getNum() %></td>
						<td class="iii"><img alt="" src="/HomePage/images/<%=bean.getFile()%>"></td>
						<td class="left">
						<%
							int wid = 0;//답변글에 대한 들여쓰기 값 저장 용도
							
							//답변글에 대한 들여쓰기 정도값이 0보다 크다면 ?
							if(bean.getRe_lev() > 0){
								wid = bean.getRe_lev() * 10;
						%>		
							<img src="../images/center/level.gif" width="<%=wid%>" height="15">
							<img src="../images/center/re.gif">
						<%	
							}
							
						%>
						<%=bean.getSubject() %></td>
						<td><%=bean.getName() %></td>
						<td><%=sdf.format(bean.getDate()) %></td>
						<td><%=bean.getReadcount() %></td>
					</tr>
				<%			
						}
					
					}else{//검색한 글이 존재하지 않으면
				%>
						<tr>
							<td colspan="5">게시판 글 없음</td>
						</tr>
				<%		
					}	
				%>
				
			</table>

			<%
				//각각의 패이지에서 .. 로그인후 이동해 올때 .. session영역에서 저장되어있는 id값 반환
				String id = (String) session.getAttribute("id");
				//세션값이 저장되어 있으면 글쓰기 버튼이 보이게 설정
				if (id != null) {
			%>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn"
					onclick="location.href='write.jsp'">
			</div>	

			
			<%
				}
			%>

			<!-- <div id="table_search">
				<input type="text" name="search" class="input_box"> 
				<input type="button" value="검색" class="btn">
			</div> -->
			<div class="clear"></div>
			<div id="page_control">
				<%--아래의 페이지 번호 출력 부분 --%>
				<%
					if(count > 0){//DB에 글이 존재 한다면 ...
						//전체 페이지 수를 구하기 -> 글 20개 존재 하면 -> 한페이지에 보여직 글수 10개  -> 2개의 페이지
						//                    글 25개 존재 하면 -> 한페이지에 보여직 글수 10개  -> 3개의 페이지
						//공식
						//전체 페이지 수 = 전체글 / 한페이지에 보여줄 글수 + (전체 글수를 한 페이지에 보여줄 글수로 나눈 나머지값)
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
						
						//하나의 화면(한블럭)에 보여줄 페이지 개수 설정 
						int pageBlock = 2;
						
						/*시작 페이지 번호 구하기*/
						// 1~10 =>1   11~20 => 11   21~30 => 21
						//( (현재  선택한 페이지 번호 / 한 화면에 보여줄 페이지수 )   -
						//	(현재 선택한 페이지 번호를 한 화면에 보여줄 페이지 수로 나눈 나머지값) ) *
						//  한화면에 보여줄 페이지수 +1;
						//공식
						int startPage = ((currentPage / pageBlock)-(currentPage % pageBlock ==0?1:0) ) * pageBlock + 1 ;
						
						//끝 페이지 번호 구하기 1~10 => 10  11~20 =>20  21~30 =>30
						//공식 : 시작페이지번호 + 현재 블럭 에 보여줄 페이지수 - 1
						int endPage = startPage + pageBlock - 1;
						
						//끝 페이지 번호가 전체 페이지 개수보다 클때..
						if(endPage > pageCount){
							//끝 페이지 번호를 전체 페이지 수로 저장
							endPage = pageCount;
						}
						
							//[이전] 시작 페이지 번호가 한 화면에 보여줄 페이지 수보다 클떄..
							if(startPage > pageBlock){
					%>			
								<a href="blog.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
					<%			
							}
										
							
							//[1][2][3]
							for(int i =startPage; i<=endPage; i++){
					%>			
								<a href="blog.jsp?pageNum=<%=i%>">[<%=i %>]</a>
					<%			
							}
							
							//[다음] 끝 페이지 번호가 전체 페이지 수보다 작을때 ..
							if(endPage < pageCount){
					%>			
								<a href="blog.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
					<%			
							}
							
					}
				%>
			</div>
		</article>
	</div>
	<jsp:include page="/inc/footer.jsp"/>  
	
</body>
</html>