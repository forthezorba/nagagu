package org.nagagu.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.AuthVO;
import org.nagagu.domain.MemberVO;


public interface MemberMapper { 
	public MemberVO read(String userid);
	
	public int insert_member(MemberVO memberVO);		//회원가입
	public int update_member(MemberVO memberVO);		//회원가입
	public int insert_auth(AuthVO auth);		//회원가입
	public int emailLink_chk(MemberVO memberVO);		//이메일 인증	
	public int emailLink_chk_gongbang(MemberVO memberVO);		//이메일 인증	
	public int status_chk(MemberVO memberVO);		//상태 인증	
	
	public int nickname_chk(MemberVO memberVO);	//별명 중복체크
	int email_chk(MemberVO memberVO);		//이메일 중복체크, 이메일 가지고 사용자 정보 가져오기

}
