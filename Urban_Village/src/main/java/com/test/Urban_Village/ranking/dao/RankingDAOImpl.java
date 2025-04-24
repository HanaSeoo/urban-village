package com.test.Urban_Village.ranking.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.reservation.dto.PayDTO;

@Repository
public class RankingDAOImpl implements RankingDAO {
@Autowired
SqlSession session;
	@Override
	public List<String> AccRankTopList() {
		// TODO Auto-generated method stub
		return session.selectList("mapper.ranking.AccRankTopList");
	}

}
