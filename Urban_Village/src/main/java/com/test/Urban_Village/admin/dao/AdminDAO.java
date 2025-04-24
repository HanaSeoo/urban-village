package com.test.Urban_Village.admin.dao;

import java.util.List;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.admin.dto.AdminDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

public interface AdminDAO {
	public AdminDTO login(AdminDTO admin);
	boolean checkIfUserIdExists(String userId);
	public List<CleanerDTO> selectCleanerList();
	public CleanerDTO selectCleanerDetail(String member_id);
	public List<String> getAccCleanerId();
	public int hostAccBest(AccommodationIdDTO accIdDTO);
	public List<AccommodationIdDTO> accIdList(AccommodationIdDTO accIdDTO);
	public int deleteHostAccBest(AccommodationIdDTO accIdDTO);
	public List<AccommodationDTO> accExceptBest(AccommodationDTO accDTO);
	public List<AccommodationIdDTO> accIdListAll(AccommodationIdDTO accIdDTO);
}
