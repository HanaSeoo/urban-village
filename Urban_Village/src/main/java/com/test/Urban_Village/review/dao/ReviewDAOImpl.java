package com.test.Urban_Village.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.review.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO{

	@Autowired
	SqlSession session;

	@Override
    public String getLastInsertedReviewId() {
        return session.selectOne("mapper.review.getLastInsertedReviewId");
    }

    /**
     * 리뷰를 데이터베이스에 삽입하는 메서드
     *
     * @param reviewMap 리뷰 데이터
     * @return 삽입된 행의 개수
     * @throws Exception
     */
    @Override
    public int insertReview(Map<String, Object> reviewMap) throws Exception {
        return session.insert("mapper.review.insertReview", reviewMap);
    }

    /**
     * 특정 숙소 ID를 기준으로 리뷰 리스트를 가져오는 메서드
     *
     * @param accommodationId 숙소 ID
     * @return 리뷰 리스트
     */
    // 특정 숙소의 후기 리스트 조회
    public List<ReviewDTO> getReviewsByAccommodationId(String accommodationName) {
        return session.selectList("mapper.review.getReviewsByAccommodationId", accommodationName);
    }
    @Override
    public Double getAverageRatingByAccommodationId(String accommodationId) {
        return session.selectOne("mapper.review.getAverageRatingByAccommodationId", accommodationId);
    }
    @Override
    public String getLatestReview(String accommodation_id) {
       return session.selectOne("mapper.review.getLatestReview",accommodation_id);
    }

    @Override
	public void delReview(String id) {
		// TODO Auto-generated method stub
		session.delete("mapper.review.delReview", id);
	}
    @Override
	public List<ReviewDTO> getReviewList() {
		// TODO Auto-generated method stub
		return session.selectList("mapper.review.getRiviewList");
	}

	@Override
	public void deleteReview(String reviewId) {
		session.delete("mapper.review.deleteReview", reviewId);
		
	}
	
}
