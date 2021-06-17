package com.hj.spring.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hj.spring.member.model.service.MemberService;
import com.hj.spring.member.model.vo.Member;

@Controller // 다음과 같이 Controller타입의 어노테이션을 붙여주면 빈 스캐닝을 통해서 자동으로 빈으로 등록될꺼임 (스프링이 알아서 관리할꺼임)
public class MemberController {
	
	// DI (Dependency Injection)
	// Autowired 타입의 어노테이션을 붙여주면 내가 직접 생성할 필요없이
	// 등록되어 있는 빈들 중에서 해당 타입과 맞는 클래스를 찾아서 자동으로 생성 후 주입해줌!!
	@Autowired
	private MemberService mService;
	
	
	
	
	
	
	
	
	
}
