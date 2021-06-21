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
public class Order {

	private int orderNo;
	private int projectNo;
	private int memberNo;
	private String purEmail;
	private int orderPlus;
	private int orderStatus;
	private String receiverName;
	private String receiverPhone;
	private String addressNo;
	private String addressDetail;
	private String address;
	private int shippingStatus;
	private String shippingReq;
	private String shippingCom;
	private String shippingNo;
	private String orderDate;
}
