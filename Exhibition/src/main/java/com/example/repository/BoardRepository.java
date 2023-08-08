package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardDTO;

@Repository
public class BoardRepository {

   private DataSource dataSource;

   @Autowired
   public BoardRepository(DataSource dataSource) {
      this.dataSource = dataSource;
   }

   // 모든 글 목록 가져오기
   public List<BoardDTO> getBoardList() throws Exception {
      List<BoardDTO> boardList = new ArrayList<>();
      String sql = "SELECT * FROM board";

      try (Connection conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()) {

         while (rs.next()) {
        	 BoardDTO board = new BoardDTO();
            board.setTitle(rs.getString("title"));
            board.setNickname(rs.getString("nickname"));
            board.setText(rs.getString("text"));
            board.setGrade(rs.getString("grade"));
            boardList.add(board);
         }
      }

      return boardList;
   }

   // 글 작성
   
   public void insertBoard(BoardDTO board) throws Exception {
	    String sql = "INSERT INTO BOARD (num, nickname, title, text, grade) VALUES (board_seq.NEXTVAL, ?, ?, ?, ?)";
	    try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, board.getNickname());
	        pstmt.setString(2, board.getTitle());
	        pstmt.setString(3, board.getText());
	        pstmt.setString(4, board.getGrade());
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        throw new Exception("Failed to insert board.", e);
	    }
	}


   // 티켓 페이지
   public List<BoardDTO> board(String title) throws SQLException {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<BoardDTO> list = new ArrayList<BoardDTO>();

      try {
         conn = dataSource.getConnection();
         pstmt = conn.prepareStatement("SELECT * FROM Board WHERE title = ?");
         pstmt.setString(1, title);
         rs = pstmt.executeQuery();
         while (rs.next()) {
        	 BoardDTO BoardDTO = new BoardDTO();
        	 BoardDTO.setNickname(rs.getString("nickname"));
        	 BoardDTO.setText(rs.getString("text"));
        	 BoardDTO.setGrade(rs.getString("grade"));
        	 BoardDTO.setTitle(rs.getString("title"));
        	 BoardDTO.setNum(rs.getInt("num"));
            list.add(BoardDTO);
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

   // 글 상세보기
   public BoardDTO getBoard(String id) throws Exception {
	   String sql = "SELECT * FROM board WHERE num = ?";
	   BoardDTO board;
	   try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	     try {
	       int num = Integer.parseInt(id);
	       pstmt.setInt(1, num);
	     } catch (NumberFormatException e) {
	       throw new IllegalArgumentException("Invalid board id: " + id);
	     }
	     try (ResultSet rs = pstmt.executeQuery()) {
	       if (rs.next()) {
	         board = new BoardDTO();
	         board.setNum(rs.getInt("num"));
	         board.setTitle(rs.getString("title"));
	         board.setNickname(rs.getString("nickname"));
	         board.setText(rs.getString("text"));
	         board.setGrade(rs.getString("grade"));
	         return board;
	       }
	     }
	   }
	   return null;
	 }


   public void updateBoard(BoardDTO board) throws Exception {
	    String sql = "UPDATE board SET nickname = ?, title = ?, text = ?, grade = ? WHERE num = ?";
	    try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, board.getNickname());
	        pstmt.setString(2, board.getTitle());
	        pstmt.setString(3, board.getText());
	        pstmt.setString(4, board.getGrade());
	        pstmt.setInt(5, board.getNum());
	        pstmt.executeUpdate();
	    }
	}

   // 글 삭제
   public void deleteBoard(String id) throws Exception {
	    String sql = "DELETE FROM board WHERE num = ?";
	    try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, Integer.parseInt(id));
	        pstmt.executeUpdate();
	    }
	}

}