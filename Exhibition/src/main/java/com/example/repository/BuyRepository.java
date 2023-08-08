package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BuyDTO;
import com.example.domain.MemberDTO;

@Repository
public class BuyRepository {

	@Autowired
	private DataSource dataSource;

	// 구매하기
	public void buy(HttpSession session, BuyDTO buy) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();

			MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
			String memberId = loginUser.getId();

			pstmt = conn.prepareStatement(
					"INSERT INTO BUY(num, ID, ADULT, CHILD, TITLE, THUMBNAIL) VALUES(buy_num.NEXTVAL, ?, ?, ?, ?, ?)");

			pstmt.setString(1, memberId);
			pstmt.setString(2, buy.getAdult());
			pstmt.setString(3, buy.getChild());
			pstmt.setString(4, buy.getTitle());
			pstmt.setString(5, buy.getThumbnail());

			pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	// 전체 구매 내역
	public List<BuyDTO> mydata(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BuyDTO> list = new ArrayList<BuyDTO>();

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BUY WHERE id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BuyDTO buyDTO = new BuyDTO();
				buyDTO.setId(rs.getString("id"));
				buyDTO.setAdult(rs.getString("adult"));
				buyDTO.setChild(rs.getString("child"));
				buyDTO.setTitle(rs.getString("title"));
				buyDTO.setNum(rs.getInt("num"));
				buyDTO.setThumbnail(rs.getString("thumbnail"));
				list.add(buyDTO);
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return list;
	}

	// 티켓 페이지
	public List<BuyDTO> myticket(int num) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BuyDTO> list = new ArrayList<BuyDTO>();

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BUY WHERE num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BuyDTO buyDTO = new BuyDTO();
				buyDTO.setId(rs.getString("id"));
				buyDTO.setAdult(rs.getString("adult"));
				buyDTO.setChild(rs.getString("child"));
				buyDTO.setTitle(rs.getString("title"));
				buyDTO.setNum(rs.getInt("num"));
				list.add(buyDTO);
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return list;
	}

	// 시퀀스 구하기
	public int findSeq() throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement("SELECT buy_num.currval FROM dual");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return num;
	}

	public List<BuyDTO> getThumbnailsByTitle(String title) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<BuyDTO> thumbnails = new ArrayList<BuyDTO>();

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement("SELECT thumbnail FROM BUY WHERE title = ?");
			pstmt.setString(1, title);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BuyDTO buyDTO = new BuyDTO();
				buyDTO.setTitle(rs.getString("title"));
				buyDTO.setThumbnail(rs.getString("thumbnail"));
				thumbnails.add(buyDTO);
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return thumbnails;
	}

	public List<BuyDTO> alldata() throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BuyDTO> list = new ArrayList<BuyDTO>();

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BUY ");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BuyDTO buyDTO = new BuyDTO();
				buyDTO.setId(rs.getString("id"));
				buyDTO.setAdult(rs.getString("adult"));
				buyDTO.setChild(rs.getString("child"));
				buyDTO.setTitle(rs.getString("title"));
				buyDTO.setNum(rs.getInt("num"));
				buyDTO.setThumbnail(rs.getString("thumbnail"));
				list.add(buyDTO);
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return list;
	}

}
