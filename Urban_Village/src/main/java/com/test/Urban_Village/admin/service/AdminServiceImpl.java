package com.test.Urban_Village.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.admin.dao.AdminDAO;
import com.test.Urban_Village.admin.dao.AdminDAOImpl;
import com.test.Urban_Village.admin.dto.AdminDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired 
	AdminDAO dao;

	@Override
	public AdminDTO login(String id, String pwd) {
		// TODO Auto-generated method stub
		AdminDTO admin = new AdminDTO();
		admin.setAdmin_id(id);
		admin.setPwd(pwd);
		return dao.login(admin);
	}

	@Override
	public boolean checkIfUserIdExists(String adminId) {
		// TODO Auto-generated method stub
		return dao.checkIfUserIdExists(adminId);
	}

	@Override
	public List<CleanerDTO> getCleanerList() {
	    return dao.selectCleanerList();
	}

	@Override
	public CleanerDTO getCleanerDetail(String member_id) {
	    return dao.selectCleanerDetail(member_id);
	}

	@Override
	public List<String> getAccCleanerId() {
		// TODO Auto-generated method stub
		return dao.getAccCleanerId();
	}

	@Override
	public int hostAccBest(AccommodationIdDTO accIdDTO) {
		// TODO Auto-generated method stub
		return dao.hostAccBest(accIdDTO);
	}

	@Override
	public List<AccommodationIdDTO> accIdList(AccommodationIdDTO accIdDTO) {
		// TODO Auto-generated method stub
		return dao.accIdList(accIdDTO);
	}

	@Override
	public int deleteHostAccBest(AccommodationIdDTO accIdDTO) {
		// TODO Auto-generated method stub
		 return dao.deleteHostAccBest(accIdDTO);
	}

	@Override
	public List<AccommodationDTO> accExceptBest(AccommodationDTO accDTO) {
		// TODO Auto-generated method stub
		return dao.accExceptBest(accDTO);
	}

	@Override
	public List<AccommodationIdDTO> accIdListAll(AccommodationIdDTO accIdDTO) {
		// TODO Auto-generated method stub
		return dao.accIdListAll(accIdDTO);
	}

}
