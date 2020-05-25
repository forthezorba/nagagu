package org.nagagu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.nagagu.domain.AuthVO;
import org.nagagu.domain.MemberVO;
import org.nagagu.mapper.BoardMapper;
import org.nagagu.mapper.MemberMapper;
import org.nagagu.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_=@Autowired)
	private MemberMapper memberMapper;
	@Setter(onMethod_=@Autowired)
	private StoreMapper storeMapper;
	
	@Override
	public int insert_member(MemberVO memberVO) {
		int res = 0;
		try {
			memberVO.setMember_picture("https://nagagu.s3.ap-northeast-2.amazonaws.com/basic.png");
			log.info(memberVO);
			res = memberMapper.insert_member(memberVO);
			 AuthVO auth = new AuthVO();
			 auth.setAuth("ROLE_MEMBER");
			 auth.setMember_id(memberVO.getMember_id());
			 memberMapper.insert_auth(auth);
			
			if(memberVO.getMember_license()!=0) {
				auth.setMember_id(memberVO.getMember_id());
			    auth.setAuth("ROLE_WORKSHOP"); 
				memberMapper.insert_auth(auth);
			}
			
			//memberMapper.insert_auth(memberVO);
		} catch (Exception e) {
			System.out.println("회원 정보 입력 실패!" + e.getMessage());
		}
		return res;
	}
	@Override
	public int update_member(MemberVO memberVO) {
		storeMapper.member_edit_update(memberVO);
		return memberMapper.update_member(memberVO);
	}
	@Override
	public int email_chk(MemberVO memberVO) {
		log.info(memberVO);
		return memberMapper.email_chk(memberVO);
	}
	@Override
	public int nickname_chk(MemberVO memberVO) {
		log.info(memberVO);
		return memberMapper.nickname_chk(memberVO);
	}
	
	@Override
	public int emailLink_chk(MemberVO memberVO) {
		log.info("chk impl..."+memberVO);
		if(memberVO.getMember_license()==1) {
			return memberMapper.emailLink_chk_gongbang(memberVO);
		}else{
			return memberMapper.emailLink_chk(memberVO);
		}
	}
	@Override
	public int status_check(MemberVO memberVO) {
		int res = memberMapper.status_chk(memberVO);
		return res;
	}
}
