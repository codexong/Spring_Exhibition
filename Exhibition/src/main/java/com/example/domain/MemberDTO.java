package com.example.domain;

import lombok.Data;

@Data
public class MemberDTO {

	private String id;
	private String password;
	private String name;
	private String email;
	private String nickname;

	private String mail1;
	private String mail2;

	public void setEmail(String mail1, String mail2) {
		this.email = mail1 + "@" + mail2;
	}
}