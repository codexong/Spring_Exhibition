package com.example.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BuyDTO;
import com.example.domain.MemberDTO;
import com.example.repository.BuyRepository;
import com.example.repository.UserRepository;

@Service
public class BuyService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private BuyRepository buyRepository;

	public MemberDTO login(String id, String password) {
		try {
			return userRepository.findByUserIdAndPassword(id, password);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean buy(HttpSession session, BuyDTO buyDTO) {
		try {
			buyRepository.buy(session, buyDTO);

			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<BuyDTO> mydata(String id) throws SQLException {
		try {
			return buyRepository.mydata(id);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<BuyDTO> myticket(int num) throws SQLException {
		try {
			return buyRepository.myticket(num);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public int findSeq() {
		try {

			return buyRepository.findSeq();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	public List<BuyDTO> getThumbnailsByTitle(String title) throws SQLException {
		try {
			return buyRepository.getThumbnailsByTitle(title);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<BuyDTO> alldata() throws SQLException {
		try {
			return buyRepository.alldata();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
