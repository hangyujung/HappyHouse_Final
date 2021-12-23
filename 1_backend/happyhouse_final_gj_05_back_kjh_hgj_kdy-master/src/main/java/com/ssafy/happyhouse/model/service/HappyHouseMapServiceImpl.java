package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HappyHouseMapServiceImpl implements HappyHouseMapService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}

	@Override
	public List<HouseInfoDto> getAptByYear(Map<String,String> map) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptByYear(map);
	}

	@Override
	public List<HouseInfoDto> getAptByName(String word) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptByName(word);
	}

	@Override
	public Integer addCart(Map<String, Integer> param) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).addCart(param);
	}

	@Override
	public List<HouseInfoDto> getmarkedArea(String userNo) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getmarkedArea(userNo);
	}

	@Override
	public Integer deleteMark(Map<String, Integer> param) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).deleteMark(param);
	}

}
