package com.test.Urban_Village.ranking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.ranking.dao.RankingDAO;
import com.test.Urban_Village.reservation.dto.PayDTO;

@Service
public class RankingServiceImpl implements RankingService {
@Autowired
RankingDAO dao;
	@Override
	public List<String> AccRankTop() {
		// TODO Auto-generated method stub
		return dao.AccRankTopList();
	}

}
