package com.test.Urban_Village.cleaner.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.cleaner.dao.CleanerDAO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

@Service
public class CleanerServiceImpl implements CleanerService {

	@Autowired
	CleanerDAO dao;


	@Override
	public void addCleaner(Map<String, Object> cleanerMap) {
	    dao.insertCleaner(cleanerMap);
	}


	@Override
	public List<AccommodationDTO> findAccByNullCleanerId() {
		// TODO Auto-generated method stub
		return dao.findAccByNullCleanerId();
	}




	@Override
	public int addCleanerId(AccommodationDTO accDTO) {
		// TODO Auto-generated method stub
		return dao.addCleanerId(accDTO);
	}


	@Override
	public int cleanerIdDelete(String cleaner_admin_id) {
		// TODO Auto-generated method stub
		return dao.cleanerIdDelete(cleaner_admin_id);
	}

	@Override
	public boolean hasAlreadyApplied(String loginId) {
		// TODO Auto-generated method stub
		return dao.hasAlreadyApplied(loginId);
	}





}
