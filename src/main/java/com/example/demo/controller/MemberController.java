package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MemberController {
		
	@GetMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}
	
	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}

}
