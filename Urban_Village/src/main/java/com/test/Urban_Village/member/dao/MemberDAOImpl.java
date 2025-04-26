package com.test.Urban_Village.member.dao;

import java.sql.Date;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;

	@Override 
	public List<MemberDTO> listMembers() { 
		List<MemberDTO> membersList = sqlSession.selectList("mapper.member.selectAllMemberList");
		return membersList;
	}

	@Override
	public MemberDTO login(MemberDTO member) { 
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.login", member);
	}

	@Override
	public int addMember(MemberDTO member) { 
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.join",member);
	}
	
	@Override
	   public List<MemberDTO> getUserInfoById(String id) {
	      // TODO Auto-generated method stub
	      List<MemberDTO> memberList = sqlSession.selectList("mapper.member.getUserInfoById",id);
	      return memberList;
	   }
	
	@Override
	   public int updateUserInfo(MemberDTO member) {
	      // TODO Auto-generated method stub
	      return sqlSession.update("mapper.member.modMember",member);
	   }

	@Override
	public boolean checkIfUserIdExists(String userId) {
		int count = sqlSession.selectOne("mapper.member.countMemberById", userId);
		return count > 0; 
	}

	 @Override
	   public int deleteMember(String id) {
	      return sqlSession.delete("mapper.member.deleteMember", id);
	   }
	// 매출
	   @Override
	   public List<PayDTO> getDailySales() {
	      List<PayDTO> dailySalesList = sqlSession.selectList("mapper.member.selectDailySales");
	       System.out.println("일별 매출 데이터 (DAO): " + dailySalesList.get(0).getTotal_sales()); // 추가
	       return dailySalesList;
	   }

	   @Override
	   public List<PayDTO> getMonthlySales() {
	       return sqlSession.selectList("mapper.member.selectMonthlySales");
	   }

	   @Override
	   public List<PayDTO> getYearlySales() {
	       return sqlSession.selectList("mapper.member.selectYearlySales");
	   }

	@Override
	public int findPwdForId(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.findPwdForId", member_id);
	}
	
	@Override
    public List<MemberDTO> searchMembersById(String id) {
        return sqlSession.selectList("mapper.member.searchMembersById", id);
    }

	@Override
	public String findEmailById(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.findEmailById", member_id);
	}
	
	@Override
	   public int modPwdMember(MemberDTO member) {
	      // TODO Auto-generated method stub
	      return sqlSession.update("mapper.member.modPwdMember",member);
	   }

	@Override
	public MemberDTO selectByEmail(String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.selectByEmail", email);
	}

	@Override
	public void insertGoogleUser(MemberDTO member) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.member.insertGoogleUser", member);
	}

	@Override
	   public int addCoupon(MemberDTO member) {
	      // TODO Auto-generated method stub
	      return sqlSession.insert("mapper.member.addCoupon", member);
	   }
	@Override
	   public List<MemberDTO> getCouponsByMemberId(String loginId) {
	      List<MemberDTO> couponList = sqlSession.selectList("mapper.member.selectCoupon", loginId);
	      return couponList;
	   }

	   @Override
	   public void updateCouponStatus(String coupon_id) {
	      sqlSession.update("mapper.member.updateCouponStatus", coupon_id);
	      
	   }

	   @Override
	   public int modCoupon(String coupon_id) {
	      // TODO Auto-generated method stub
	      return sqlSession.update("mapper.member.modCoupon", coupon_id);
	   }

	   @Override
	   public List<MemberDTO> getCouponsByMemberId1(String loginId) {
	      List<MemberDTO> couponList = sqlSession.selectList("mapper.member.selectCoupon1", loginId);
	      return couponList;
	   }

	   @Override
	   public List<MemberDTO> getMyCoupon(String loginId) {
	      List<MemberDTO> coupon = sqlSession.selectList("mapper.member.getMyCoupon", loginId);
	      return coupon;
	   }

	@Override
	public void delCoupon(String id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.member.delCoupon", id);
	}

	

	
	
}
