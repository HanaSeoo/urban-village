package com.test.Urban_Village.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.Urban_Village.review.dao.ReviewDAO;
import com.test.Urban_Village.review.dto.ReviewDTO;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    ReviewDAO dao;

    @Override
    public String addReviewAndGetId(Map<String, Object> reviewMap) throws Exception {
        // 리뷰 데이터 삽입
        int result = dao.insertReview(reviewMap);
        System.out.println("Insert result: " + result); // 디버깅 로그

        if (result > 0) {
            // 최신 삽입된 review_id 반환
            String reviewId = dao.getLastInsertedReviewId();
            System.out.println("Generated review ID: " + reviewId); // 디버깅 로그
            return reviewId;
        }
        return null;
    }

    /**
     * 숙소 ID로 후기 리스트를 가져오는 메서드
     *
     * @param accommodationId 숙소 ID
     * @return 후기 리스트
     */
    @Override
    public List<ReviewDTO> getReviewsByAccommodationId(String accommodationId) {
        return dao.getReviewsByAccommodationId(accommodationId);
    }
    @Override
    public Double getAverageRatingByAccommodationId(String accommodationId) {
        return dao.getAverageRatingByAccommodationId(accommodationId);
    }

    @Override
    public String getLatestReview(String accommodation_id) {
       return dao.getLatestReview(accommodation_id);
    }
    
    @Override
	public void delReview(String id) {
		// TODO Auto-generated method stub
		dao.delReview(id);
	}
    @Override
	public List<ReviewDTO> getReviewList() {
		// TODO Auto-generated method stub
		return dao.getReviewList();
	}

	@Override
	public void deleteReview(String reviewId) {
		 dao.deleteReview(reviewId);
		
	}

    
}