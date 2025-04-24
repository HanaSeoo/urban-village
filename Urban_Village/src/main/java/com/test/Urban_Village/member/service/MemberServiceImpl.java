package com.test.Urban_Village.member.service;

import java.sql.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.member.dao.MemberDAO;
import com.test.Urban_Village.member.dao.MemberDAOImpl;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO dao;

	@Override
	public List<MemberDTO> listMembers() {
		// TODO Auto-generated method stub
		return dao.listMembers();
	}

	@Override
	public MemberDTO login(String id, String pwd) {
		MemberDTO member = new MemberDTO();
		member.setId(id);
		member.setPwd(pwd);
		return dao.login(member); // DB���� �ش� ������ ��ȸ
	}

	@Override
	public int addMember(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.addMember(member);
	}

	@Override
	public List<MemberDTO> getUserInfoById(String id) {
		// TODO Auto-generated method stub
		return dao.getUserInfoById(id);
	}

	@Override
	public int updateUserInfo(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.updateUserInfo(member);
	}

	@Override
	public boolean checkIfUserIdExists(String userId) {
		return dao.checkIfUserIdExists(userId);
	}




	@Override
	public int deleteMember(String id) {
		return dao.deleteMember(id);
	}

	@Override
	public List<PayDTO> getDailySales() {
		List<PayDTO> dailySalesList = dao.getDailySales();
		System.out.println("일별 매출 데이터 (서비스): " + dailySalesList); // 추가
		return dao.getDailySales();
	}

	@Override
	public List<PayDTO> getMonthlySales() {
		return dao.getMonthlySales();
	}

	@Override
	public List<PayDTO> getYearlySales() {
		return dao.getYearlySales();
	}

	@Override
	public int findPwdForId(String member_id) {
		// TODO Auto-generated method stub
		return dao.findPwdForId(member_id);
	}
	@Override
	public List<MemberDTO> searchMembersById(String id) {
		return dao.searchMembersById(id);
	}

	@Override
	public String findEmailById(String member_id) {
		// TODO Auto-generated method stub
		return dao.findEmailById(member_id);
	}

	@Override
	public int modPwdMember(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.modPwdMember(member);
	}

	@Override
	public MemberDTO selectByEmail(String email) {
		// TODO Auto-generated method stub
		return dao.selectByEmail(email);
	}

	@Override
	public void insertGoogleUser(MemberDTO member) {
		// TODO Auto-generated method stub
		dao.insertGoogleUser(member);
		return; 
	}

	// 쿠폰 번호 생성 메서드
	private String generateCouponId() {
		Random rand = new Random();
		StringBuilder couponId = new StringBuilder();
		for (int i = 0; i < 4; i++) {
			if (i > 0) couponId.append("-");
			for (int j = 0; j < 4; j++) {
				couponId.append(rand.nextInt(10));
			}
		}
		return couponId.toString(); // 예: 1234-1234-1234-1234
	}

	// 할인율 생성 메서드 (10% ~ 15%)
	private int generateDiscount() {
		Random rand = new Random();
		return 11 + rand.nextInt(6); // 11 ~ 20 사이의 랜덤 값
	}

	@Override
	public int addCoupon(MemberDTO member) {
		String couponId = generateCouponId();
		int discount = generateDiscount();

		member.setCoupon_id(couponId);
		member.setDiscount(discount);
		member.setCoupon_name("신규가입 "+discount+"% 쿠폰");
		member.setIs_used("Y");
		return dao.addCoupon(member);
	}
	@Override
	public List<MemberDTO> getCouponsByMemberId(String loginId) {
		// TODO Auto-generated method stub
		return dao.getCouponsByMemberId(loginId);
	}

	@Override
	public void updateCouponStatus(String coupon_id) {
		// TODO Auto-generated method stub
		dao.updateCouponStatus(coupon_id);
	}

	@Override
	public int modCoupon(String coupon_id) {
		// TODO Auto-generated method stub
		return dao.modCoupon(coupon_id);
	}

	@Override
	public List<MemberDTO> getCouponsByMemberId1(String loginId) {
		// TODO Auto-generated method stub
		return dao.getCouponsByMemberId1(loginId);
	}

	@Override
	public List<MemberDTO> getMyCoupon(String loginId) {
		// TODO Auto-generated method stub
		return dao.getMyCoupon(loginId);
	}

	@Override
	public void delCoupon(String id) {
		// TODO Auto-generated method stub
		dao.delCoupon(id);
	}

}
