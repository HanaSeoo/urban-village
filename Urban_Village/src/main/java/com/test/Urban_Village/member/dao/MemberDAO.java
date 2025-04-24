package com.test.Urban_Village.member.dao;

import java.sql.Date;
import java.util.List;

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

public interface MemberDAO {
	public List<MemberDTO> listMembers();
	public MemberDTO login(MemberDTO member);
	public int addMember(MemberDTO member);
	public boolean checkIfUserIdExists(String userId);
	public List<MemberDTO> getUserInfoById(String id);
	public int updateUserInfo(MemberDTO member);
	public int deleteMember(String id);
	public List<PayDTO> getDailySales();
	public List<PayDTO> getMonthlySales();
	public List<PayDTO> getYearlySales();
	public int findPwdForId(String member_id);
	public List<MemberDTO> searchMembersById(String id);
	public String findEmailById(String member_id);
	public int modPwdMember(MemberDTO member);
	public MemberDTO selectByEmail(String email);
	public void insertGoogleUser(MemberDTO member);
	public int addCoupon(MemberDTO member);
	public List<MemberDTO> getCouponsByMemberId(String loginId);
	public void updateCouponStatus(String coupon_id);
	public int modCoupon(String coupon_id);
	public List<MemberDTO> getCouponsByMemberId1(String loginId);
	public List<MemberDTO> getMyCoupon(String loginId);
	public void delCoupon(String id);
}
