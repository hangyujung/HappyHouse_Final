package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {

	MemberDto login(MemberDto memberDto) throws Exception;
	boolean registerMember(MemberDto memberDto) throws Exception;	
	MemberDto getMember(String userid) throws Exception;
	boolean updateMember(MemberDto memberDto) throws Exception;
	boolean deleteMember(String userid) throws Exception;
	List<MemberDto> getMemberList() throws Exception;
	MemberDto userInfo(String userid) throws Exception;
}
