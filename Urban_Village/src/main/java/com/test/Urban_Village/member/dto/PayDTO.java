package com.test.Urban_Village.member.dto;

import java.sql.Date;

public class PayDTO {
    private String reservation_id;
    private String id;
    private String accommodation_id;
    private Date checkin_date;
    private Date checkout_date;
    private int guest_count;
    private double total_price;
    private String accommodation_name;

    // 매출 관련 속성 추가
    private Date sale_date;     // 일별 매출 조회 시
    private String sales_month;    // 월별 매출 조회 시
    private String sales_year;     // 연도별 매출 조회 시
    private Double total_sales;   // 총 매출액

    public String getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(String reservation_id) {
        this.reservation_id = reservation_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAccommodation_id() {
        return accommodation_id;
    }

    public void setAccommodation_id(String accommodation_id) {
        this.accommodation_id = accommodation_id;
    }

    public Date getCheckin_date() {
        return checkin_date;
    }

    public void setCheckin_date(Date checkin_date) {
        this.checkin_date = checkin_date;
    }

    public Date getCheckout_date() {
        return checkout_date;
    }

    public void setCheckout_date(Date checkout_date) {
        this.checkout_date = checkout_date;
    }

    public int getGuest_count() {
        return guest_count;
    }

    public void setGuest_count(int guest_count) {
        this.guest_count = guest_count;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public String getAccommodation_name() {
        return accommodation_name;
    }

    public void setAccommodation_name(String accommodation_name) {
        this.accommodation_name = accommodation_name;
    }

    public Date getSale_date() {
        return sale_date;
    }

    public void setSale_date(Date sale_date) {
        this.sale_date = sale_date;
    }

    public String getSales_month() {
        return sales_month;
    }

    public void setSales_month(String sales_month) {
        this.sales_month = sales_month;
    }

    public String getSales_year() {
        return sales_year;
    }

    public void setSales_year(String sales_year) {
        this.sales_year = sales_year;
    }

    public Double getTotal_sales() {
        return total_sales;
    }

    public void setTotal_sales(Double total_sales) {
        this.total_sales = total_sales;
    }

    @Override
    public String toString() {
        return "PayDTO{" +
               "reservation_id='" + reservation_id + '\'' +
               ", id='" + id + '\'' +
               ", accommodation_id='" + accommodation_id + '\'' +
               ", checkin_date=" + checkin_date +
               ", checkout_date=" + checkout_date +
               ", guest_count=" + guest_count +
               ", total_price=" + total_price +
               ", accommodation_name='" + accommodation_name + '\'' +
               ", sale_date='" + sale_date + '\'' +
               ", sales_month='" + sales_month + '\'' +
               ", sales_year='" + sales_year + '\'' +
               ", total_sales=" + total_sales +
               '}';
    }
}