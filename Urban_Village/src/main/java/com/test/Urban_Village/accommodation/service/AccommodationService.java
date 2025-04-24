package com.test.Urban_Village.accommodation.service;

import java.util.List;
import java.util.Map;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;

public interface AccommodationService {



	List<AccommodationDTO> accList();
	AccommodationDTO findAccommodationId(String accommodationId);
	String addAccommodation(AccommodationDTO dto);
	String addNewAccommodation(Map<String, Object> accommodationMap);
	int delAccommodation(String accommodation_id);
	List<AccommodationDTO> idFindByAccList(String accommodation_id);
	void updateAccommodation(Map<String, Object> accommodationMap);
	boolean checkAccommodationName(String accommodationName);
	List<AccommodationDTO> searchAddress(List<String> regions);
	boolean checkName(String accommodation_name);
	List<AccommodationDTO> searchAccommodation(String keyword);
	AccommodationDTO getAccommodationById(String accommodationId);
	Integer getReservationCountByAccommodationId(String accommodation_id);
	List<AccommodationDTO> getAccommodationsSortedByViewCount();
	List<AccommodationDTO> getAccommodationsSortedByReservation();
	void increaseViewCount(String accommodation_id);
	int getViewCount(String accommodation_id);


}
