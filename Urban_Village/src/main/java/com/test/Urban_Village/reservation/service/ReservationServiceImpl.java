package com.test.Urban_Village.reservation.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.Urban_Village.reservation.dao.ReservationDAO;
import com.test.Urban_Village.reservation.dto.PayDTO;

@Service
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    ReservationDAO dao;

    @Override
    @Transactional
    public void addPay(PayDTO payDto) {
        dao.addPay(payDto);
    }

    @Override
    public List<PayDTO> payList() {
        return dao.payList();
    }

    @Override
    public List<PayDTO> reservationGetUserId(String loginId) {
        return dao.reservationGetUserId(loginId);
    }

   @Override
   public int delReservation(String reservation_id) {
      // TODO Auto-generated method stub
      return dao.delReservation(reservation_id);
   }

@Override
public boolean isReservationConflict(String accommodation_id, Date checkin_date, Date checkout_date) {
    int conflictCount = dao.checkReservationDate(accommodation_id, checkin_date, checkout_date);
    return conflictCount > 0;  // 겹치는 예약이 있으면 true 반환
}
@Override
public List<Map<String, Object>> getReservedDates (String accommodation_id) {
    return dao.getReservedDates(accommodation_id);
}

@Override
public List<PayDTO> getReservationHistory(String userId) {
    return dao.selectReservationHistoryByUserId(userId);
}

}