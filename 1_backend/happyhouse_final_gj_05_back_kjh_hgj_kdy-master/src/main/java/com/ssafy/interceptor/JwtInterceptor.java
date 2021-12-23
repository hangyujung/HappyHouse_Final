package com.ssafy.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ssafy.happyhouse.model.service.JwtServiceImpl;

public class JwtInterceptor implements HandlerInterceptor{
	private static final String HEADER_AUTH = "auth-token";

	@Autowired
	private JwtServiceImpl jwtService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		final String token = request.getHeader(HEADER_AUTH);

		if(token != null && jwtService.isUsable(token)){
			//logger.info("토큰 사용 가능 : {}", token);
			return true;
		}else{
			//logger.info("토큰 사용 불가능 : {}", token);
			throw new RuntimeException("인증 토큰이 없습니다.");
		}
	}
}
