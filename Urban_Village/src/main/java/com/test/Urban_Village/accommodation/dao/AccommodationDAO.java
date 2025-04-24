package com.test.Urban_Village.accommodation.dao;

import java.util.List;
import java.util.Map;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;

public interface AccommodationDAO {

	List<AccommodationDTO> accList();

	AccommodationDTO findAccommodationId(String accommodationId);

	int addAcommodation(AccommodationDTO dto);


	String getLastInsertedAccommodationId();

	int insertAccommodation(Map<String, Object> accommodationMap);

	String getLastInsertedAccommodationId2();

	int delAccommodation(String accommodation_id);

	List<AccommodationDTO> idFindByAccList(String accommodation_id);

	void updateAccommodation(Map<String, Object> accommodationMap);

	boolean checkAccommodationName(String name);

	boolean checkName(String accommodation_name);

	List<AccommodationDTO> searchByRegions(List<String> regions);

	List<AccommodationDTO> searchAccommodation(String keyword);

	void increaseViewCount(String accommodation_id);

	int getViewCount(String accommodation_id);

	List<AccommodationDTO> selectAccommodationsSortedByReservation();

	List<AccommodationDTO> selectAccommodationsSortedByViewCount();

	Integer getReservationCountByAccommodationId(String accommodation_id);

	


}
