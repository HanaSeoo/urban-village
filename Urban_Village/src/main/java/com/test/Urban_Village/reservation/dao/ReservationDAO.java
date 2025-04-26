package com.test.Urban_Village.reservation.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.test.Urban_Village.reservation.dto.PayDTO;


public interface ReservationDAO {
   
   public void addPay(PayDTO payDto);
   public List<PayDTO> payList();
   public List<PayDTO> reservationGetUserId(String loginId);
   public int delReservation(String reservation_id);
public int checkReservationDate(String accommodation_id, Date checkin_date, Date checkout_date);
public List<Map<String, Object>> getReservedDates(String accommodation_id);
public List<PayDTO> selectReservationHistoryByUserId(String userId);
public String getImpUidByReservationId(String reservationId);
public PayDTO getReservationById(String reservationId);
}
