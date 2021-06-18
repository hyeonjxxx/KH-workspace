package com.hj.withus.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member {

	private int memberNo;
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String phone;
	private String memberCreateDate;
	private String memberLink;
	private int reportCount;
	private String memberStatus;
	private String memberProfile;
	private String partnerJoin;
	private String partnerName;
	private String partnerInto;
}
