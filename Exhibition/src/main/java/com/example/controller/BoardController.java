package com.example.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.BoardDTO;
import com.example.domain.BuyDTO;
import com.example.domain.MemberDTO;
import com.example.service.BoardService;
import com.example.service.BuyService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private BuyService buyService;

	// 모든 리뷰 리스트
	   @GetMapping("/board")
	   public String getBoardList(Model model) throws Exception {
	      List<BoardDTO> boardList = boardService.getBoardList();
	      model.addAttribute("BoardDTO", boardList);
	      List<BuyDTO> buyList = buyService.alldata();
	      model.addAttribute("buyDTO", buyList);
	      return "board/list";
	   }

	//리뷰 삭제
	@GetMapping("/board/{id}")
	public String getBoard(@PathVariable("id") String id, Model model) throws Exception {
		BoardDTO board = boardService.getBoard(id);
		model.addAttribute("board", board);
		return "board/detele";
	}


	//리뷰 작성
	@GetMapping("/board/write")
	public String writeBoardForm(Model model, HttpSession session, @RequestParam("num") int num) {
	MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
	if (loginUser == null) {
		return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
	} else {
		try {
			List<BuyDTO> buyList = buyService.myticket(num);
			 model.addAttribute("buyDTO", buyList);
			 model.addAttribute("memberDTO", loginUser);
			return "board/write";

		} catch (SQLException e) {
			e.printStackTrace();
			return "error";
		}
	 }
   }

	@PostMapping("/board/write")
	public String writeBoard(@RequestParam("title") String title,
							@RequestParam("nickname") String nickname,
							@RequestParam("text") String text,
							@RequestParam("grade") String grade,
	RedirectAttributes redirectAttrs) throws Exception {
		BoardDTO board = new BoardDTO();
		board.setTitle(title);
		board.setNickname(nickname);
		board.setText(text);
		board.setGrade(grade);
		boardService.insertBoard(board);
		redirectAttrs.addFlashAttribute("msg", "글이 등록되었습니다.");
		return "redirect:/board";
	}

	@GetMapping("/board/update/{id}")
	public String updateBoardForm(@PathVariable("id") String id, Model model) throws Exception {
	    BoardDTO board = boardService.getBoard(id);
	    model.addAttribute("board", board);
	    return "board/update";
	}

	@PostMapping("/board/update")
	public String updateBoard(BoardDTO board, RedirectAttributes redirectAttrs) throws Exception {
		boardService.updateBoard(board);
		redirectAttrs.addFlashAttribute("msg", "글이 수정되었습니다.");
		return "redirect:/board";
	}

	@PostMapping("/board/delete/{id}")
	public String deleteBoard(@PathVariable("id") String id, RedirectAttributes redirectAttrs) throws Exception {
	boardService.deleteBoard(id);
	redirectAttrs.addFlashAttribute("msg", "글이 삭제되었습니다.");
	return "redirect:/board";
	}

	@GetMapping("/titleboard")
	public String board(Model model, @RequestParam("title") String title) {
		try {
			List<BoardDTO> boardList = boardService.board(title);
			model.addAttribute("BoardDTO", boardList);
			return "board/title";

		} catch (SQLException e) {
			e.printStackTrace();
			return "error";
		}
  }

}



