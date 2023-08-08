package com.example.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BoardDTO;
import com.example.repository.BoardRepository;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	//모든 리뷰 리스트
	public List<BoardDTO> getBoardList() throws Exception {
		return boardRepository.getBoardList();
	}

	public BoardDTO getBoard(String id) throws Exception {
		return boardRepository.getBoard(id);
	}

	//리뷰작성
	public void insertBoard(BoardDTO board) throws Exception {
		boardRepository.insertBoard(board);
	}

	//리뷰 수정
	public void updateBoard(BoardDTO board) throws Exception {
		boardRepository.updateBoard(board);
	}

	//리뷰 삭제
	public void deleteBoard(String id) throws Exception {
		boardRepository.deleteBoard(id);
	}

	//타이틀로 리뷰 불러오기
	public List<BoardDTO> board(String title) throws SQLException {
			try {
				return boardRepository.board(title);
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}

}

