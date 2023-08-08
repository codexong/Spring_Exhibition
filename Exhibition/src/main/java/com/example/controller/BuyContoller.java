package com.example.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.BuyDTO;
import com.example.domain.MemberDTO;
import com.example.service.BuyService;

@Controller
public class BuyContoller {

	@Autowired
	private BuyService buyService;

	// 구매페이지 이동
	@GetMapping("/buy")
	public String showBuyPage(Model model, HttpSession session, @RequestParam("realmName") String realmName,
			@RequestParam("title") String title, @RequestParam("place") String place,
			@RequestParam("thumbnail") String thumbnail

	) {

		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			model.addAttribute("memberDTO", loginUser);
			model.addAttribute("realmName", realmName);
			model.addAttribute("title", title);
			model.addAttribute("place", place);
			model.addAttribute("thumbnail", thumbnail);

			return "buy/buy";
		}
	}

	// 구매처리
	@PostMapping("/processBuy")
	public String buy(@ModelAttribute("buyDTO") BuyDTO buyDTO, Model model, HttpSession session) {

		boolean result = buyService.buy(session, buyDTO);
		if (result) {
			model.addAttribute("msg", "구매성공");
			model.addAttribute("buyDTO", buyDTO);
			return "redirect:/ticket?num=" + buyService.findSeq();
		}

		return "buy/buy";
	}
	
	@GetMapping("/buyticket")
	public String buyticket(Model model, HttpSession session) {

	model.addAttribute("msg", "구매성공");
	return "redirect:/ticket?num=" + buyService.findSeq();
	
	}

	// 내 활동 페이지
	@GetMapping("/mybuy")
	public String mydata(Model model, HttpSession session) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			try {
				String memberId = loginUser.getId();
				List<BuyDTO> buyList = buyService.mydata(memberId);
				model.addAttribute("buyDTO", buyList);
				model.addAttribute("memberDTO", loginUser);
				return "buy/mybuy";

			} catch (SQLException e) {
				e.printStackTrace();
				return "error";
			}
		}
	}

	@GetMapping("/ticket")
	public String myticket(Model model, HttpSession session, @RequestParam("num") int num) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			try {
				List<BuyDTO> buyList = buyService.myticket(num);
				model.addAttribute("buyDTO", buyList);
				model.addAttribute("memberDTO", loginUser);
				return "buy/ticket";

			} catch (SQLException e) {
				e.printStackTrace();
				return "error";
			}
		}
	}

}
