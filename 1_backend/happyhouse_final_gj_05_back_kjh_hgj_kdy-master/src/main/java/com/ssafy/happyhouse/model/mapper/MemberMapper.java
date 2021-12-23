package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberMapper {


	int registerMember(MemberDto memberDto) throws Exception;
	MemberDto getMember(String userid) throws Exception;
	int updateMember(MemberDto memberDto) throws Exception;
	int deleteMember(String userid) throws Exception;
	List<MemberDto> getMemberList() throws Exception;
	public MemberDto login(MemberDto memberDto) throws SQLException;
	public MemberDto userInfo(String userid) throws SQLException;
	
}
