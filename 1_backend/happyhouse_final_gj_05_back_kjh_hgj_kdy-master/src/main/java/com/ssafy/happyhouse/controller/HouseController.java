package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/house")
public class HouseController {

	@GetMapping("/")
	public String housePage(){
		return "house/house";
	}
	
	
	
	@GetMapping("/mark")
	public String markedArea(){
		return "house/markedArea";
	}
}
