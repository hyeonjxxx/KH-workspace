package com.hj.withus.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter @Getter
@ToString
public class Refund {

	private int refundNo;
	private int orderNo;
	private String reOrginName;
	private String reChangeName;
	private String reReason;
	private String refundStatus;
	
}
