package com.test.Urban_Village.reservation.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.reservation.dto.PayDTO;


@Repository
public class ReservationDAOImpl implements ReservationDAO {

    @Autowired
    SqlSession sqlSession;

    @Override
    public void addPay(PayDTO payDto) {
        sqlSession.insert("mapper.reservation.addPay", payDto);
    }

    @Override
    public List<PayDTO> payList() {
        return sqlSession.selectList("mapper.reservation.payList");
    }

    @Override
    public List<PayDTO> reservationGetUserId(String loginId) {
        return sqlSession.selectList("mapper.reservation.reservationGetUserId", loginId);
    }

   @Override
   public int delReservation(String reservation_id) {
      // TODO Auto-generated method stub
      return sqlSession.delete("mapper.reservation.delReservation", reservation_id);
   }

   @Override
   public int checkReservationDate(String accommodation_id, Date checkin_date, Date checkout_date) {
       Map<String, Object> dateMap = new HashMap<>();
       dateMap.put("accommodation_id", accommodation_id);
       dateMap.put("checkin_date", checkin_date);
       dateMap.put("checkout_date", checkout_date);

       return sqlSession.selectOne("mapper.reservation.checkReservationDate", dateMap);
   }

   public List<Map<String, Object>> getReservedDates(String accommodation_id) {
	    return sqlSession.selectList("mapper.reservation.getReservedDates", accommodation_id);
	}

   @Override
   public List<PayDTO> selectReservationHistoryByUserId(String userId) {
      return sqlSession.selectList("mapper.reservation.selectReservationHistoryByUserId", userId);
   }


}