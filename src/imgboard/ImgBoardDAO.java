package imgboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ImgBoardDAO {
	//커넥션플로 부터  커넥션을  얻기 위한 메소드
	private Connection getConnection() throws Exception{
		
		Connection con = null;
		Context init = new InitialContext();
		//커넥션플 얻기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//커넥션플로부터 커넥션 객체 얻기
		con = ds.getConnection();
		
		return con;

	}//getConnection()메서드 끝
	
public void reInsertBoard(ImgBoardBean bBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		//DB에추가할 답변글번호를 저장할 변수 선언
		int num = 0;
		try {
			//커넥션플로부터 커넥션 얻기
			con = getConnection();
			//답변글 글번호 구하기
			//SQL구문 만들기 : DB에 저장되어있는 글들 중에 .. 가장큰 글번호 검색
			sql = "select max(num) from imge";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//답변글 글번호 = 검색 된 최신 글번호 + 1
				num = rs.getInt(1) + 1;
				
			}else{//최신 글번호가 검색 되지 않으면 
				//답변글 글번호 = 1
				num = 1;
				
			}
			
			/*re_seq 답글 순서 재배치*/
			//무보글 그룹과 같은 그룹이면서... 부모글의 seq값보다 큰 답변글들은? seq값을1 중가 시킨다
			sql = "update imge set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref()); //부모글 그룹번호
			pstmt.setInt(2, bBean.getRe_seq()); //부모글의 글입력 순서
			pstmt.executeUpdate();
			
			/*답변글 달기*/
			//insert
			sql = "insert into imge values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//답변글 번호
			pstmt.setString(2, bBean.getName());//답변글 작성자 이름
			pstmt.setString(3, bBean.getPasswd());//답변글 비밀번호
			pstmt.setString(4, bBean.getSubject());//답변글 제목
			pstmt.setString(5, bBean.getContent());//답변글 내용
			pstmt.setString(6, bBean.getFile());//업로드 파일명
			pstmt.setInt(7, bBean.getRe_ref());//답변글의 group값 == 부모글의 group값을 사용하여 INSERT
			pstmt.setInt(8, bBean.getRe_lev() + 1);//답변글의 들여쓰기 정도값은? 부모글의 들여쓰기 정도값에 +1한 값을 사용
			pstmt.setInt(9, bBean.getRe_seq() + 1);//답변글의 내의 순서 값은 부모글의 순서값에 + 1 한값을 사용
			pstmt.setInt(10, 0);//답변글 추가시 조회
			pstmt.setTimestamp(11, bBean.getDate());//답변글의 작성한 날짜 및  시간
			
			
			//답변글 INSERT 실행
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}//finally끝

	}//reInsertBean끝
	
	
	
	
	
	
	
	
	//수정할 글정보 (BoardBean)객체 를 메게변수로 전달받아
	//DB에 저장되어있는 수정할 글의 비밀번호와 일치하면
	//글 수정 Update 시키는 메서드
	public int updateBoard(ImgBoardBean bBean){
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select passwd from imge where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;
					
					sql = "update imge set subject=?, content=? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getSubject());
					pstmt.setString(2, bBean.getContent());
					pstmt.setInt(3, bBean.getNum());
					pstmt.executeUpdate();
					
				}else{

					check = 0;

				}
			}

		} catch (Exception e/*rr*/) {
			e/*rr*/.printStackTrace();
		}finally {
			//자원해제
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return check;
	}
	
	
	
	
	//삭제할 글번호와 삭제하기 위해 입력했던 비밀번호를 메소드의 매게변수로 전달 받아..
	//글삭제 메서드
	public int deleteBoard(int num, String passwd){
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			//커넥션플로 부터 커넥션 객체 가져오기
			con = getConnection();
			//SQL SELECT구문 : 메게변수로 전달 받은 글 번호에 해당하는 삭제할 글의 비밀번호 얻기
			sql = "select passwd from imge where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//메게변수로 전달받은 글번호에 해당하는 삭제할 글의 비밀번호가 검색 되었다면
					//입력한 글의 비밀번호와 DB에서 검색해온 비밀번호가 동일할때
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					//메게변수로 전달받은 삭제할 글번호에 해당하는 글 삭제
					sql = "delete from imge where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();//DELETE샐행
					
				}else{//비밀번호가 틀리면
					
					check = 0;
				
				}
					
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return check; //deletePro.jsp로 반환
	}
	
	
	
	//글번호 를 전달받아 글번호에 해당하는 글정보 검색 하는 메서드
	public ImgBoardBean getBoardBean(int num){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ImgBoardBean bBean =null;
		
		try {
			con = getConnection();
			
			sql = "select * from imge where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
				if (rs.next()) {
				
				bBean = new ImgBoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return bBean;
	}
	
	
	
	//하나의 글정보를 보기 위해서 notice.jsp에서 글행을 클릭했을때
	//DB에 저장되어 잇는 글에 대한 조회수를 증가시키는 메서드
	public void updateReadCount(int num){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			//커넥션플로 부터 커넥션 얻기
			con = getConnection();
			//SQL구문 -> UPDATE 글조회수 1증가
			sql = "update imge set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);//update 구문 실행 객체 얻기
			pstmt.setInt(1, num);//?에 대응 하는 값 설정
			pstmt.executeUpdate();//UPDATE실행
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해재
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
	}
	
	
	
	
	
	//글들을 검색하는 메서드
	//.getBoardList(각 페이지마다 맨위쪽애 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
	public List<ImgBoardBean> getBoardList(int startRow, int pageSize){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		List<ImgBoardBean> boardList = new ArrayList<ImgBoardBean>();
		
		try {
			//커넥션 플로부터 커넥션 얻기(DB접속) 
			con = getConnection();
			//SQL SELECT      limit 잘라서 갓고오기
			sql = "select * from imge order by re_ref desc, re_seq asc limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ImgBoardBean bBean = new ImgBoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
			
				//BardBean객체 -> ArrayLisr배열에 추가
				boardList.add(bBean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return boardList; //ArrayList리턴
	}
	
	
	//게시판 전체에 글개수 검색하여 반환 해주는 메서드
	public int getBoardCount(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int count = 0;
		
		try {
			//커넥션플로부터 커넥션 얻기(DB접속)
			con = getConnection();
			//SQL -> 전체 글개수 검색
			sql = "select count(*) from imge";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return count;
		
		
	}
	
	
	
	//입력한 글정보를 board테이블이 추가시키는 메서드
	public void insertBoard(ImgBoardBean bBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql ="";
		int num =0;//DB에 추가할 글번호
		
		try {
			//커넥션플로부터 커넥션 얻기(DB접속)
			con = getConnection();
			//먼저 ~~게시판에 글을 추가하기 전에 게시판에 저장되어있는 최신 글번호를 알아야
			//새로 추가할 글번호를 만들수 있다
			//board테이블에 저장되어있는 최신글num(가장큰 글번호)을 검색 하여 얻기
			sql = "select max(num) from imge";
			pstmt = con.prepareStatement(sql);
		 	rs = pstmt.executeQuery();
			
		 	if(rs.next()){//검색된 최신 글번호가 존재 하면
		 		num = rs.getInt(1)+1; //글이 존재하면 최신 글번호 + 1
		 		
		 	}else{//board테이블에 저장된 글이 존재 하지 않으면
		 		num = 1; //글이 존재 하지않으면 insert할 글번호를 1로 저장
		 		
		 	}
		 	//insert SQL 문만들기
		 	sql = "insert into imge (num,name,passwd,"
		 			+ "subject,content,file,re_ref,re_lev,re_seq,readcount,date)"
		 			+ "values(?,?,?,?,?,?,?,?,?,?,?)";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, num);
		 	pstmt.setString(2, bBean.getName());
		 	pstmt.setString(3, bBean.getPasswd());
		 	pstmt.setString(4, bBean.getSubject());
		 	pstmt.setString(5, bBean.getContent());
		 	pstmt.setString(6, bBean.getFile());
		 	pstmt.setInt(7, num);//num주글번호 기준 == re_ref 그룹번호
		 	pstmt.setInt(8, 0);//주글 이므로...들여쓰기 레벨값0
		 	pstmt.setInt(9, 0);//주글 이므로...답글 순서 이므로 순서는0
			pstmt.setInt(10, 0);//조회수는 0
			pstmt.setTimestamp(11, bBean.getDate());//글쓴 날짜
			
			
			//insert실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			
		}//finally끝
		
		
	}//insert메소드 끝

	
	
}
