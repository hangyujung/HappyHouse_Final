package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface HappyHouseMapService {

	List<SidoGugunCodeDto> getSido() throws Exception;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dong) throws Exception;
	List<HouseInfoDto> getAptByYear(Map<String,String> map) throws Exception;
	List<HouseInfoDto> getAptByName(String word) throws Exception;
	Integer addCart(Map<String, Integer> param) throws Exception;
	List<HouseInfoDto> getmarkedArea(String userNo)throws Exception;
	Integer deleteMark(Map<String, Integer> param)throws Exception;
}
