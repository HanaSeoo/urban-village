package com.test.Urban_Village.admin.service;

import java.util.List;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.admin.dto.AdminDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

public interface AdminService {
	public AdminDTO login(String id, String pwd);
	boolean checkIfUserIdExists(String adminId);
	public List<CleanerDTO> getCleanerList();
	public CleanerDTO getCleanerDetail(String memberId);
	public List<String> getAccCleanerId();
	public int hostAccBest(AccommodationIdDTO accIdDTO);
	public List<AccommodationIdDTO> accIdList(AccommodationIdDTO accIdDTO);
	public int deleteHostAccBest(AccommodationIdDTO accIdDTO);
	public List<AccommodationDTO> accExceptBest(AccommodationDTO accDTO);
	public List<AccommodationIdDTO> accIdListAll(AccommodationIdDTO accIdDTO);
}
