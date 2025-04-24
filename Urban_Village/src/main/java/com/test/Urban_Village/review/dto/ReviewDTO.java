package com.test.Urban_Village.review.dto;

import java.util.Date;

public class ReviewDTO {
	private String accommodation_name;
	private String review_data;
	private String id;
	private int rating;
	private String review_photo;
	private Date created_at; // 작성 시간 추가
	private String review_id;
	
	
	public String getReview_id() {
		return review_id;
	}
	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public String getAccommodation_name() {
		return accommodation_name;
	}
	public void setAccommodation_name(String accommodation_name) {
		this.accommodation_name = accommodation_name;
	}
	public String getReview_data() {
		return review_data;
	}
	public void setReview_data(String review_data) {
		this.review_data = review_data;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getReview_photo() {
		return review_photo;
	}
	public void setReview_photo(String review_photo) {
		this.review_photo = review_photo;
	}
	
}
