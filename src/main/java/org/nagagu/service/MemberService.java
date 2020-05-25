package org.nagagu.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.MemberVO;


public interface MemberService {
	public int emailLink_chk(MemberVO memberVO);	//이메일 인증
	public int insert_member(MemberVO memberVO); //회원 가입 후 넣기
	public int update_member(MemberVO memberVO); //회원 가입 후 넣기
	public int status_check(MemberVO memberVO); //회원 가입 후 넣기
	
	public int email_chk(MemberVO memberVO);//중복체크
	public int nickname_chk(MemberVO memberVO);//중복체크
}
