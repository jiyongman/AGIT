package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; // 데이터베이스에 접근하게 해주는 하나의 객체
	private PreparedStatement pstmt;
	private ResultSet rs; // 정보를 담을 수 있는 객체
	
	public UserDAO() { // MySQL에 접속을 하게 해준다, 자동으로 데이터베이스 커넥션이 일어난다
		try { // 예외 처리
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "5689";
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 드라이버를 찾는다
			// 드라이버는 MySQL에 접속할 수 있도록 매개체 역할을 하는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) { // 로그인을 시도하는 함수
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // 아이디가 일치하면 비밀번호를 가져온다
			rs = pstmt.executeQuery(); // rs에 실행한 결과를 넣어준다
			if (rs.next()) { // 결과가 존자한다면
				if(rs.getString(1).equals(userPassword)) { // SQL 문장을 실행해서 나온 결과와 접속을 시도했던 비밀번호 비교
					return 1; // 로그인 성공 
				} else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)"; // 총 다섯 개의 값이 들어갈 수 있도록 한다
		try { // INSERT 문장 결과는 0 이상의 숫자가 발현되기 때문에 -1이 아닌 경우 성공적인 회원가입이 이루어진다
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace(); 
		}
		return -1; // 데이터베이스 오류
	}
	
	public User getUser(String userID) { // 하나의 글 내용을 불러오는 함수
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // SELECT문의 ?에 들어갈 내용
			rs = pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				return user;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userPassword, String userName, String userGender, String userEmail ) {
		String SQL = "UPDATE USER SET userPassword = ?, userName = ?, userGender = ?, userEmail = ? where userID = ?"; 
		// 특정한 아이디에 해당하는 제목과 내용을 수정한다
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setString(3, userGender);
			pstmt.setString(4, userEmail);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(String userID) {
		String SQL = "DELETE FROM USER WHERE userID = ?";  // // 특정한 아이디에 해당하는 제목과 내용을 삭제한다
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}