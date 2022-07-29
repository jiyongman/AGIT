package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn; // 데이터베이스에 접근하게 해주는 하나의 객체
	private ResultSet rs; // 정보를 담을 수 있는 객체
	
	public BbsDAO() { // MySQL에 접속을 하게 해준다, 자동으로 데이터베이스 커넥션이 일어난다
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "5689";
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 드라이버는 MySQL에 접속할 수 있도록 매개체 역할을 하는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent, int bbsCount, int likeCount) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.setInt(7, bbsCount);
			pstmt.setInt(8, likeCount);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsCount(rs.getInt(7));
				bbs.setLikeCount(rs.getInt(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCount() {
		String SQL = "SELECT COUNT(*) FROM BBS";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				int bbsCount = rs.getInt(7);
				bbs.setBbsCount(bbsCount);
				bbsCount++;
				countUpdate(bbsCount, bbsID);
				bbs.setLikeCount(rs.getInt(8));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int countUpdate(int bbsCount, int bbsID) {
		String SQL = "UPDATE BBS SET bbsCount = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsCount);
			pstmt.setInt(2, bbsID);
			return pstmt.executeUpdate();	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public int update(String bbsTitle, String bbsContent, int bbsID) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int like(int bbsID) {
		String SQL = "UPDATE BBS SET likeCount = likeCount + 1 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getSearch(String searchField, String searchText) {
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM BBS WHERE " + searchField.trim();
			try {
				if(searchText != null && !searchText.equals("")) {
					SQL += " LIKE '%" + searchText.trim() + "%' ORDER BY bbsID DESC LIMIT 10";
				}
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbsCount(rs.getInt(7));
					bbs.setLikeCount(rs.getInt(8));
					list.add(bbs);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			return list;
	   }
}