package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.mapper.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;
	
//	@Override
//	public int idCheck(String checkId) throws Exception {
//		return sqlSession.getMapper(MemberMapper.class).idCheck(checkId); // 0 or 1
//	}

	@Override
	public boolean registerMember(MemberDto memberDto) throws Exception {
		if(memberDto.getUserId()==null)
		{
			throw new Exception();
		}
		return sqlSession.getMapper(MemberMapper.class).registerMember(memberDto)==1;
	}

	@Override
	public MemberDto login(MemberDto memberDto) throws Exception {
		System.out.println(memberDto.getUserId());
		System.out.println(memberDto.getPassword());
		if(memberDto.getUserId() == null || memberDto.getPassword() == null) {
			
			return null;
		}
		return sqlSession.getMapper(MemberMapper.class).login(memberDto);
	}

	@Override
	public MemberDto getMember(String userid) throws Exception {
		return sqlSession.getMapper(MemberMapper.class).getMember(userid);
	}

	@Override
	@Transactional
	public boolean updateMember(MemberDto memberDto) throws Exception {
		return sqlSession.getMapper(MemberMapper.class).updateMember(memberDto)==1;
	}

	@Override
	public boolean deleteMember(String userid) throws Exception {
		return sqlSession.getMapper(MemberMapper.class).deleteMember(userid)==1;
	}

	@Override
	public List<MemberDto> getMemberList() throws Exception {
		return sqlSession.getMapper(MemberMapper.class).getMemberList();
	}

	@Override
	public MemberDto userInfo(String userid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MemberMapper.class).userInfo(userid);
	}
}
