package com.test.Urban_Village.reservation.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonObject;
import com.test.Urban_Village.reservation.dao.ReservationDAO;
import com.test.Urban_Village.reservation.dto.PayDTO;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import org.json.JSONObject;

@Service
public class ReservationServiceImpl implements ReservationService {
    @Autowired
    ReservationDAO dao;

    private final String impKey = "3114340314304337";
    private final String impSecret = "mBMev2hk7ez634hG30ihYJSEPfDdqv6FRyA5VCn8n3yyfKnLX0tVmjzhgEa3XZTzF3RjhRu53tPH0tO8";
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


// 1. 아임포트 Access Token 받기
private String getAccessToken() throws Exception {
    URL url = new URL("https://api.iamport.kr/users/getToken");

    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("POST"); 
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);

    JSONObject json = new JSONObject();
    json.put("imp_key", impKey);
    json.put("imp_secret", impSecret);

    OutputStream os = conn.getOutputStream();
    os.write(json.toString().getBytes());
    os.flush();
    os.close();

    Scanner sc = new Scanner(conn.getInputStream());
    String response = "";
    while (sc.hasNext()) {
        response += sc.nextLine();
    }
    sc.close();

    JSONObject parsed = new JSONObject(response);
    String accessToken = parsed.getJSONObject("response").getString("access_token");

    return accessToken;
}

// 2. 결제 취소 요청
@Override
public boolean cancelPayment(String reservationId) {
    try {
        // 예약 ID로 imp_uid 조회
        String impUid = getImpUidByReservationId(reservationId);
        
        if (impUid == null || impUid.isEmpty()) {
            System.out.println("imp_uid가 없습니다. 예약 ID: " + reservationId);
            return false;
        }
        
        String token = getAccessToken();
        URL url = new URL("https://api.iamport.kr/payments/cancel");

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST"); 
        conn.setRequestProperty("Authorization", token); 
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);
        
        JSONObject json = new JSONObject();
        json.put("imp_uid", impUid);
        
        OutputStream os = conn.getOutputStream();
        os.write(json.toString().getBytes());
        os.flush();
        os.close();

        // 응답 읽기
        Scanner sc = new Scanner(conn.getInputStream());
        StringBuilder responseStr = new StringBuilder();
        while (sc.hasNext()) {
            responseStr.append(sc.nextLine());
        }
        sc.close();
        
        // 응답 처리
        System.out.println("결제 취소 API 응답: " + responseStr.toString());
        JSONObject jsonResponse = new JSONObject(responseStr.toString());
        
        // 안전하게 success 키 확인
        if (jsonResponse.has("success")) {
            return jsonResponse.getBoolean("success");
        } else if (jsonResponse.has("code")) {
            // API에 따라 code 값으로 성공 여부 판단
            return jsonResponse.getInt("code") == 0;
        } else {
            System.out.println("API 응답에 success 또는 code 키가 없습니다");
            return false;
        }
    } catch (Exception e) {
        System.out.println("결제 취소 처리 중 오류: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}


public String getImpUidByReservationId(String reservationId) {
    return dao.getImpUidByReservationId(reservationId);
}
public PayDTO getReservationById(String reservationId) {
    return dao.getReservationById(reservationId);
}
}