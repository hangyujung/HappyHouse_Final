package com.ssafy.happyhouse.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/open")
public class OpenApiController {
	
	@Autowired
	private RestTemplate rt;
	
	private static final Logger logger = LoggerFactory.getLogger(OpenApiController.class);
	private static final String elecServiceKey ="%2BKpIeKhGngEiS%2BHcLJEP8odLYvljbZjpa3DjqxCeW4g348lRG%2BxSxfsfhHLd9K8J6VAn7xzc%2F9qYSfhol2gGGg%3D%3D";
	private static final String parkingServiceKey="6345716c696b696936397978587a5a";
	
	@GetMapping(value="/elec")
	public Object getElecInfo(@RequestParam Map<String, Object> param) {
		
	
		UriComponents comp = UriComponentsBuilder.newInstance()
				.scheme("http")
				.host("apis.data.go.kr")
//				.port(80)
				.path("B552584/EvCharger/getChargerInfo")
				.queryParam("serviceKey", elecServiceKey)
				.queryParam("zcode", 11)
//				.queryParam("pageNo", param.get("pageNo"))
//				.queryParam("numOfRows", 9999)
				.build(true);
	
		return rt.getForObject(comp.toUri(), String.class);
	}
	@GetMapping("/parking")
	public Object getParkingInfo(@RequestParam String gu) {
	
		
		UriComponents comp = UriComponentsBuilder.newInstance()
				.scheme("http")
				.host("openapi.seoul.go.kr")
				.port(8088)
				//.queryParam("ServiceKey", parkingServiceKey)			
				.path(parkingServiceKey+"/json/GetParkInfo/1/100/"+gu)
//				.queryParam("ServiceKey", param.get("ServiceKey"))
//				.queryParam("pageNo", param.get("pageNo"))
//				.queryParam("numOfRows", param.get("numOfRows"))
				.build();
				logger.info("api{}",comp.toUri());
		return rt.getForObject(comp.toUri(), Map.class);
	}
}

 