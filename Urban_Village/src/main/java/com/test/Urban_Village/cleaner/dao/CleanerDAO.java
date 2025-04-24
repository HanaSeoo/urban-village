package com.test.Urban_Village.cleaner.dao;

import java.util.List;
import java.util.Map;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

public interface CleanerDAO {

	void insertCleaner(Map<String, Object> cleanerMap);

	List<AccommodationDTO> findAccByNullCleanerId();

	int addCleanerId(AccommodationDTO accDTO);

	int cleanerIdDelete(String cleaner_admin_id);


}
