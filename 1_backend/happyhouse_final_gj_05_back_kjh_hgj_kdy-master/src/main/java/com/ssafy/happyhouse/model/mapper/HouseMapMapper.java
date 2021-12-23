package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface HouseMapMapper {
	
	List<SidoGugunCodeDto> getSido() throws SQLException;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws SQLException;
	List<HouseInfoDto> getDongInGugun(String gugun) throws SQLException;
	List<HouseInfoDto> getAptInDong(String dong) throws SQLException;
	List<HouseInfoDto> getAptByYear(Map<String,String> map)throws SQLException;
	List<HouseInfoDto> getAptByName(String word)throws SQLException;
	Integer addCart(Map<String, Integer> param)throws SQLException;
	List<HouseInfoDto> getmarkedArea(String userNo)throws SQLException;
	Integer deleteMark(Map<String, Integer> param)throws SQLException;
}
