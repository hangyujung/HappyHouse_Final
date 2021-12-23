package com.ssafy.happyhouse.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.Charge;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HappyHouseMapService;

@RestController
@RequestMapping(value="/map", method= {RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.POST})
@CrossOrigin(origins = { "*" })
public class HappyHouseMapController {
	
	@Autowired
	private HappyHouseMapService happyHouseMapService;
	
	@GetMapping("/sido")
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception {
		return new ResponseEntity<List<SidoGugunCodeDto>>(happyHouseMapService.getSido(), HttpStatus.OK);
	}
	
	@GetMapping("/gugun")
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws Exception {
		return new ResponseEntity<List<SidoGugunCodeDto>>(happyHouseMapService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping("/dong")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping("/apt")
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getAptInDong(dong), HttpStatus.OK);
	}
	
	
	@GetMapping("/year")
	public ResponseEntity<List<HouseInfoDto>> year(@RequestParam Map<String, String> map) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getAptByYear(map), HttpStatus.OK);
	}


	@GetMapping("/name")
	public ResponseEntity<List<HouseInfoDto>> name(@RequestParam("word") String word) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(happyHouseMapService.getAptByName(word), HttpStatus.OK);
	}
	
	
	
	@PostMapping("/cart")
	public ResponseEntity<Integer> cart(@RequestBody Map<String, Integer> params) throws Exception {
		System.out.println("param: "+params);
		return new ResponseEntity<Integer>(happyHouseMapService.addCart(params), HttpStatus.OK);
	}
	
	@GetMapping("/myMark/{userNo}")
	public ResponseEntity<Map<String,Object>> myMark(@PathVariable("userNo")String userNo, HttpSession session) throws Exception {
		//String userNo = ((MemberDto)session.getAttribute("userInfo")).getUserNo();
		List<HouseInfoDto> list = happyHouseMapService.getmarkedArea(userNo);
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("markList", list);
		resultMap.put("message","success");
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	@DeleteMapping("/deleteMark")
	public ResponseEntity<Integer> deleteMark(@RequestParam Map<String, Integer> param) throws Exception {
		System.out.println(param);
		return new ResponseEntity<Integer>(happyHouseMapService.deleteMark(param), HttpStatus.OK);
	}
	

	@GetMapping("/charge")
	public ResponseEntity<List<Charge>> charge() throws Exception {

		//Object jsonVO = new Charge();
		List<Charge> latLng = new ArrayList<Charge>();
		
		
		JSONParser jsonParser = new JSONParser();
	    JSONObject jsonObject = (JSONObject) jsonParser.parse(new FileReader("C:/Spring/HappyHouseFramework/src/main/resources/json/charge.json"));

	 
	    JSONArray jsonArray1 =(JSONArray)jsonObject.get("DATA");

	    for(int i=0;i<jsonArray1.size();i++) {
	    	JSONObject objectInArray = (JSONObject) jsonArray1.get(i);
	    	Charge charge = new Charge(objectInArray.get("xcode").toString(),objectInArray.get("ycode").toString());
	    	latLng.add(charge);
	    }

	    return new ResponseEntity<List<Charge>>(latLng, HttpStatus.OK);
	}
}
