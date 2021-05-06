package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;





//lib파일에 mysql콘텍트 파일 넣어야 한다
//자바빈 클래스 의 종류 : DAO (DB관련 작업)
public class MemberDAO {
	
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
	
	/*로그인 처리시 .. 사용하는메서드*/
	//입력받은 아이디 ,비밀번호가 DB에 존재하는지 확인
	public int userCheck(String id,String passwd){
		
		int check = 1;  // 1->아이디 , 비밀번호 DB에 존재
						// 0->아이디 맞음 , 비밀번호 틀림
						// -1->아이디 틀림
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			//커넥션플로 부터 커넥션얻기(DB접속)
			con = getConnection();
			//SELECT 문장 만들기 id에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			//prepareStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			//?설정
			pstmt.setString(1, id);
			//SELECT구문 실행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()){//아이디가 존재 함
				//login.jsp에서 입력한 비밀번호와 DB에저장되어있는 비밀번호가 동일 하면?
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; //아이디맞음, 비밀번호 맞음
					
				}else{//아이디맞음, 비밀번호 틀림
					
					check =0;//아이디맞음, 비밀번호 틀림
					
				}
				
			}else{//아이디가 존재하지 않음
				check = -1;
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		//check 리턴
		return check;
	}//메소드끝

	//회원가입 을 위한 ..사용자가 입력한 id값을 매게 변수로 전ㄴ달받아
	//DB에 사용자가 입력한id값이 존재 하는지 검색하여
	//만약 사용자가 입력한 id에 해당하는 회원 레코드가 검색이 되었다면
	//check변수에 값1을 저장하여 <------아이디 중복을 나타내는값임
	//만약 사용자가 입력한 id에 해당하는 회원 래코드가 검색이 되지 않으면
	//check면수에 값0을 저장하여<------아이디 중복 아님을 나타내는값임
	//결과적으로 아이디 중복이냐 아니냐는 check변수에 저장된 값으로 판단함으로 리턴한다
	public int idCheck(String id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			//커넥션 플로부터 커넥션 빌려오기(DB접속)
			con = getConnection();
			//SELECT SQL 문 만들기 : 입력한 아이디에 해당하는 회원검색
			sql = "select * from member where id=?";
			//prepareStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			//검색
			rs = pstmt.executeQuery();
			
			if(rs.next()){//검색한 데이터가 있으면 아이디 중복
				check = 1;
			}else{//검색한 아이디가 존재하지 않으면 아이디 중복 아님
				check = 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//자원해제
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return check;//중복 또는 중복 아님 판별값 리턴
	}
	
	
	
	
	
	/*insertMember메서드 추가*/
	//MemberBean객체를 매게변수로 전달 받아 DB에 INSERT작업 하는 메서드
	public void insertMember(MemberBean memberbean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = getConnection();
			//sql insert
			sql = "insert into member(id,passwd,age,name,gender,reg_date,email,address,tel,mtel) values(?,?,?,?,?,?,?,?,?,?)";
			//prepareStatement()얻기
			pstmt = con.prepareStatement(sql);
			//?값 설정
			pstmt.setString(1, memberbean.getId());
			pstmt.setString(2, memberbean.getPasswd());
			pstmt.setInt(3, memberbean.getAge());
			pstmt.setString(4, memberbean.getName());
			pstmt.setString(5, memberbean.getGender());
			pstmt.setTimestamp(6, memberbean.getReg_date());
			pstmt.setString(7, memberbean.getEmail());
			pstmt.setString(8, memberbean.getAddress());
			pstmt.setString(9, memberbean.getTel());
			pstmt.setString(10, memberbean.getMtel());
			//prepareStatement에 설정된 INSERT전체 문장을 DB에 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.print("insert"+e); 둘다됨!!!!!
		}finally {
			//자원해제
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
	}//
	
	
	//비밀번호 변경 (MemberBean)객체를 전달 받아 
	//DB에 저장 되어있는 비밀 번호를 
	//UPDATE 시키는 메서드
	/*public void updatetMember(String id , String passwd){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try{
			con = getConnection();
			sql = "update member set passwd = ? where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, passwd);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		
	}*/
	

	/*public boolean chePass(String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean checked = false;
		
		try {
			con = getConnection();
			sql = "SELECT passwd FROM member WHERE passwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, passwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) checked = true;
			else checked = false;
		} catch(Exception e) {
			System.out.println("checkUser()메서드에서 에러 : " + e);
		} finally {
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return checked;
	}*/
	
	
	/*public boolean checkUser(String id, String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean check = false;
		
		try {
			con = getConnection();
			
			sql = "SELECT id, passwd FROM member WHERE id=? AND passwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) check = true;
			else check = false;
		} catch(Exception e) {
			System.out.println("checkUser()메서드에서 에러 : " + e);
		} finally {
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return check;
	}*/
	
	
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		MemberBean dto = new MemberBean();
		
		try {
			con = getConnection();
			
			sql = "SELECT * FROM member WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(id);
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setAge(rs.getInt("age"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setMtel(rs.getString("mtel"));
			}
		} catch(Exception e) {
			System.out.println("getMember()메서드에서 에러 : " + e);
		} finally {
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return dto;
	}
	
	
	public void upMember(MemberBean mBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			con = getConnection();
			sql = "update member set passwd = ?, age = ?, name = ?, email = ?, address = ?, tel = ?, mtel = ? where id =?";
			pstmt = con.prepareStatement(sql);

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mBean.getPasswd());
				pstmt.setInt(2, mBean.getAge());
				pstmt.setString(3, mBean.getName());
				pstmt.setString(4, mBean.getEmail());
				pstmt.setString(5, mBean.getAddress());
				pstmt.setString(6, mBean.getTel());
				pstmt.setString(7, mBean.getMtel());
				pstmt.setString(8, mBean.getId());
				pstmt.executeUpdate();

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
	}
	
	
	//회원 삭제 메서드
	public void deleteDao(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			con = getConnection();
			sql = "delete from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
	}
	
	
	
}//MemberDAO 클래스 끝
