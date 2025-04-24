package com.test.Urban_Village.review.service;

import java.util.List;
import java.util.Map;

import com.test.Urban_Village.review.dto.ReviewDTO;

public interface ReviewService {


	String addReviewAndGetId(Map<String, Object> reviewMap) throws Exception;

	List<ReviewDTO> getReviewsByAccommodationId(String accommodation_id);

	Double getAverageRatingByAccommodationId(String accommodationId);

	String getLatestReview(String accommodation_id);

	void delReview(String id);

	void deleteReview(String reviewId);

	List<ReviewDTO> getReviewList();

	


}
