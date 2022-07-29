package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {

	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() { 
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "5689";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() { // 현재 서버 시간 가져오기
		String SQL = "SELECT NOW()"; // 현재 시간을 가져오는 MySQL 문장
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // 현재 날짜 반환
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT commentID FROM COMMENT ORDER BY commentID DESC"; // 마지막 게시물 반환
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String commentContent, String userID, int bbsID) {
		String SQL = "INSERT INTO COMMENT VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Comment> getList(int bbsID) { // 특정한 리스트를 받아서 반환
		String SQL = "SELECT * FROM COMMENT WHERE bbsID = ? AND commentAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		// 마지막 게시물을 반환한다, 삭제가 되지 않은 글만 가져온다
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentAvailable(rs.getInt(4));
				comment.setCommentDate(rs.getString(5));
				comment.setBbsID(rs.getInt(6));
				list.add(comment);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; // 댓글 리스트 반환
	}
	
	public Comment getComment(int commentID) { // 하나의 댓글을 불러오는 함수
		String SQL = "SELECT * FROM COMMENT WHERE commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentAvailable(rs.getInt(4));
				comment.setCommentDate(rs.getString(5));
				comment.setBbsID(rs.getInt(6));
				return comment;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String commentContent, int bbsID, int commentID) {
		String SQL = "UPDATE COMMENT SET commentContent = ? WHERE bbsID = ? AND commentID = ?"; 
		// 특정한 아이디에 해당하는 제목과 내용을 수정한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent);
			pstmt.setInt(2, bbsID);
			pstmt.setInt(3, commentID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int commentID) {
		String SQL = "UPDATE COMMENT SET commentAvailable = 0 WHERE commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
