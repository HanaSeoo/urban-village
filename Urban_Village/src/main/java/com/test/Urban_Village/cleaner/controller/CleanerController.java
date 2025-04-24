package com.test.Urban_Village.cleaner.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;

public interface CleanerController {
	public ModelAndView CleanerForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ModelAndView joinCleaner(CleanerDTO cleanerDTO, MultipartFile incomeFile, HttpServletRequest request) throws Exception;
	public ResponseEntity<String> addCleaner(MultipartHttpServletRequest request, HttpServletResponse response)
			throws Exception;
	public void jusoPopup();
	public ModelAndView addCleanerId(AccommodationDTO accDTO, String accommodation_id, String cleaner_admin_id,
			HttpServletRequest request, HttpServletResponse response) throws IOException;
	public ModelAndView findAccByNullCleanerId(AccommodationDTO accDTO, HttpServletRequest request,
			HttpServletResponse response);
	public ModelAndView cleanerIdDelete(String cleaner_admin_id,
			HttpServletRequest request, HttpServletResponse response)throws Exception;
}
