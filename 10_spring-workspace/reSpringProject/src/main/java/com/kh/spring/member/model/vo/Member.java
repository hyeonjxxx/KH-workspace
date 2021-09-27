package com.kh.spring.member.model.vo;

import java.util.Date;

public class Member {

	//@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String gender;
	private int age;
	private String phone;
	private String address;
	private Date enrollDate;
	private Date modifyDate;
	
	public Member() {}
	
}
