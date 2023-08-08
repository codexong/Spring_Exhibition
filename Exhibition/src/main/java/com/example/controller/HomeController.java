package com.example.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.MemberDTO;
import com.example.service.UserService;

@Controller
public class HomeController {

	@Autowired
	private UserService userService;

	@GetMapping("/")
	public String home() {
		return "home";
	}

	@GetMapping("/area")
	public String area() {
		return "area";
	}

	// 로그인 화면 이동
	@GetMapping("/login")
	public String login() {
		return "member/loginMember";
	}

	// 로그인 처리
	@PostMapping("/processLoginMember")
	public String login(@RequestParam("id") String id, @RequestParam("password") String password, HttpSession session,
			RedirectAttributes rttr) {

		MemberDTO user = userService.login(id, password); // UserService를 통해 로그인 정보 확인

		if (user == null) { // 로그인 실패 시
			rttr.addFlashAttribute("msg", "로그인에 실패하였습니다. 아이디와 비밀번호를 확인해주세요.");
			return "redirect:/login";
		} else { // 로그인 성공 시
			rttr.addFlashAttribute("welcomeMsg", "환영합니다, " + user.getNickname() + "님!");
			session.setAttribute("loginUser", user);
			return "redirect:/";
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logoutMember(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "redirect:/";
	}

	// 회원가입 페이지 이동
	@GetMapping("/addMember")
	public String addMember(Model model) {
		model.addAttribute("memberDTO", new MemberDTO());
		return "member/addMember";
	}

	// 회원가입 처리
	@PostMapping("/processAddMember")
	public String join(@ModelAttribute("memberDTO") MemberDTO memberDTO, Model model) {
		boolean result = userService.save(memberDTO);
		if (result) {
			model.addAttribute("msg", "회원가입성공");
			return "member/loginMember";
		} else {
			model.addAttribute("msg", "회원가입에실패.");
			return "redirect:/join";
		}
	}
	
	// 회원수정 페이지 이동
	@GetMapping("/updateMember")
	public String updateMember(Model model, HttpSession session) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("loginUser");
			model.addAttribute("memberDTO", memberDTO);
			return "member/updateMember";
		}
	}

	// 회원수정 처리
	@PostMapping("/processUpdateMember")
	public String updateMember(@ModelAttribute("memberDTO") MemberDTO memberDTO, Model model, HttpSession session) {
		boolean result = userService.updateUser(memberDTO);
		if (result) {
			model.addAttribute("msg", "회원정보 수정이 완료되었습니다.");
			session.invalidate(); // 세션 무효화
			return "redirect:/login";
		} else {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다.");
			return "redirect:/updateMember";
		}
	}
	
	@GetMapping("/deleteMember")
	public String deleteMember(Model model, HttpSession session) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("loginUser");
			model.addAttribute("memberDTO", memberDTO);
			return "member/deleteMember";
		}
	}

	// 회원 탈퇴
	@PostMapping("/processDeleteMember")
	public String deleteMember(HttpSession session) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login"; // 로그인되어있지 않으면 로그인 화면으로 이동
		} else {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("loginUser");
			boolean result = userService.deleteUser(memberDTO);
			session.invalidate();
			return "redirect:/";
		}
	}

}
