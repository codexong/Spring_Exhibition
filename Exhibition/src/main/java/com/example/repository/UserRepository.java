package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.MemberDTO;

@Repository
public class UserRepository {

	@Autowired
	private DataSource dataSource;

	public MemberDTO findByUserIdAndPassword(String id, String password) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;

		try {
			conn = dataSource.getConnection();

			pstmt = conn.prepareStatement("SELECT * FROM member WHERE id=? AND password=?");
			pstmt.setString(1, id);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setNickname(rs.getString("nickname"));
			}

			return member;
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
	}

	public void save(MemberDTO member) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();

			pstmt = conn
					.prepareStatement("INSERT INTO member(id, password, name, email, nickname) VALUES(?, ?, ?, ?, ?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			member.setEmail(member.getMail1(), member.getMail2());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getNickname());

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

	public void update(MemberDTO member) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();

			pstmt = conn.prepareStatement("UPDATE member SET password=?, email=?, nickname=? WHERE id=?");

			pstmt.setString(1, member.getPassword());
			member.setEmail(member.getMail1(), member.getMail2());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getNickname());
			pstmt.setString(4, member.getId());

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

	public void delete(MemberDTO member) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();

			pstmt = conn.prepareStatement("DELETE FROM member WHERE id=?");

			pstmt.setString(1, member.getId());

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
}
