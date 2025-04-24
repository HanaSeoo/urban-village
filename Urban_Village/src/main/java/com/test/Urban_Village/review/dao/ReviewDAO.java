package com.test.Urban_Village.review.dao;

import java.util.List;
import java.util.Map;

import com.test.Urban_Village.review.dto.ReviewDTO;

public interface ReviewDAO {

	

	String getLastInsertedReviewId();
	public int insertReview(Map<String, Object> reviewMap) throws Exception;
	List<ReviewDTO> getReviewsByAccommodationId(String accommodationId);
	Double getAverageRatingByAccommodationId(String accommodationId);
	String getLatestReview(String accommodation_id);
	void delReview(String id);
	List<ReviewDTO> getReviewList();
	void deleteReview(String reviewId);
}
