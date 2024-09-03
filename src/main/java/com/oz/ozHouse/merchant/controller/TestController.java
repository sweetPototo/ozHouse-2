package com.oz.ozHouse.merchant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oz.ozHouse.dto.MerchantDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/merchant/login")
public class TestController {

	@GetMapping("/test/bcrypt")
	public String testBcrypt(HttpServletRequest req) {
		HttpSession s = req.getSession();
		MerchantDTO dto = MerchantDTO.builder()
				.merId("iii111")
				.merPw("iii111I!")
				.merCompany("iii")
				.merComnum1("111")
				.merComnum2("11")
				.merComnum3("11111")
				.merHp1("111")
				.merHp2("1111")
				.merHp3("1111")
				.merRegistration("testRegistration")
				.merName("test")
				.merEmail("iii@iii.iii")
				.merBusinessPost("111111")
				.merAdress("22222")
				.build();
		s.setAttribute("insertMerchant", dto);
		return "merchant/join/merchant_join_check";
	}
	
}
