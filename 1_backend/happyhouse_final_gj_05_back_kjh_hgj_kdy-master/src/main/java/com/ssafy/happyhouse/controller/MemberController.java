package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.JwtService;
import com.ssafy.happyhouse.model.service.MemberService;

import io.swagger.annotations.ApiParam;

@CrossOrigin(origins = { "*" })
@RestController
@RequestMapping("/user")
public class MemberController {
	public static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	private MemberService service;
	@Autowired
	private JwtService jwtService;

	//회원가입
	@PostMapping("/regist")
	public ResponseEntity<String> register(@RequestBody MemberDto memberDto) throws Exception {
		System.out.println(memberDto);
		if(service.registerMember(memberDto)) {
			return new ResponseEntity<String>(SUCCESS,HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL,HttpStatus.OK);
	}

	//로그인
	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(@RequestBody MemberDto memberDto) throws Exception {
		System.out.println(memberDto);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		
		try {
			MemberDto loginUser = service.login(memberDto);
		if (loginUser != null) {
			String token = jwtService.create("userid", loginUser.getUserId(), "access-token");// key, data, subject
			logger.debug("로그인 토큰정보 : {}", token);
			resultMap.put("access-token", token);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} else {
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
		//logger.error("로그인 실패 : {}", e);
		resultMap.put("message", e.getMessage());
		status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

	//회원정보 수정
	@PutMapping("/update")
	public ResponseEntity<Map<String, Object>> edit(@RequestBody MemberDto dto) throws Exception {
		System.out.println("넘어옴: "+dto);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (service.updateMember(dto)) {
			resultMap.put("userInfo", dto);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	//회원 삭제
	@DeleteMapping("/delete/{userId}")
	public ResponseEntity<String> delete(@PathVariable("userId") String userId) throws Exception {
		System.out.println("test: "+userId);
		if (service.deleteMember(userId)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	//리스트 보기
	@GetMapping("/list")
	public String list(Model model) throws Exception {
		List<MemberDto> list = service.getMemberList();
		model.addAttribute("userlist", list);
		return "user/list";
	}
	
	//회원정보
	@GetMapping("/info/{userId}")
	public ResponseEntity<Map<String, Object>> getInfo(
			@PathVariable("userId") String userId,HttpServletRequest request) {
		System.out.println(userId);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (jwtService.isUsable(request.getHeader("access-token"))) {
			logger.info("사용 가능한 토큰!!!");
			try {
				logger.info("사용자정보");
//				로그인 사용자 정보.
				MemberDto memberDto = service.getMember(userId);
				resultMap.put("userInfo", memberDto);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} catch (Exception e) {
				logger.error("정보조회 실패 : {}", e);
				resultMap.put("message", e.getMessage());
				status = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		} else {
			logger.error("사용 불가능 토큰!!!");
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	//회원검색
	@GetMapping("/search/{userId}")
	public ResponseEntity<Map<String, Object>> search(
			@PathVariable("userId") String userId,HttpServletRequest request) throws Exception {
		System.out.println(userId+"feawfeaw");
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if(service.getMember(userId)!=null) {
			resultMap.put("searchRes", service.getMember(userId));
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
}

