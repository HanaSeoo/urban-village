package com.test.Urban_Village.cleaner.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.Urban_Village.accommodation.dao.AccommodationDAO;
import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;
import com.test.Urban_Village.cleaner.service.CleanerService;
import com.test.Urban_Village.member.dto.MemberDTO;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/cleaner")
public class CleanerControllerImpl implements CleanerController{

	@Autowired
	CleanerService service;
	@Autowired
	HttpSession session;
	@Autowired
	AccommodationDAO accDAO;
	
	private static final String CLEANER_UPLOAD_PATH = "D:\\file\\addCleaner\\";


	@Override
	@RequestMapping("/cleanerForm.do")
	public ModelAndView CleanerForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		String loginId = (String) request.getSession().getAttribute("loginId");
	    boolean alreadyApplied = service.hasAlreadyApplied(loginId);
	    System.out.println("클리너 정보"+ alreadyApplied);
	    mav.addObject("alreadyApplied", alreadyApplied);
	    mav.setViewName(viewName);
		return mav;
	}
	@Override
	@RequestMapping(value="/joinCleaner.do", method=RequestMethod.POST)
	public ResponseEntity<String> addCleaner(
	        MultipartHttpServletRequest request, 
	        HttpServletResponse response) throws Exception {

	    Map<String, Object> cleanerMap = new HashMap<>();
	    Enumeration<String> enu = request.getParameterNames();
	    while (enu.hasMoreElements()) {
	        String name = enu.nextElement();
	        String value = request.getParameter(name);
	        cleanerMap.put(name, value);
	    }

	    // 세션에서 로그인 ID 추출
	    String id = (String) session.getAttribute("loginId"); 
	    cleanerMap.put("member_id", id);

	    // 파일 업로드 처리
	    MultipartFile mFile = request.getFile("income_proof");

	    String uploadPath = "D:\\file\\addCleaner\\" + id;

	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    String savedFileName = null;

	    if (mFile != null && !mFile.isEmpty()) {
	        String originalFileName = mFile.getOriginalFilename();
	        savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;
	        File destFile = new File(uploadDir, savedFileName);
	        mFile.transferTo(destFile);
	        cleanerMap.put("income_proof", "/addCleaner/" + id + "/" + savedFileName); // DB에는 상대경로 저장
	    }

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html;charset=utf-8");

	    String msg;
	    ResponseEntity<String> resEntity;

	    try {
	        service.addCleaner(cleanerMap);

	        msg = "<script>";
	        msg += "alert('클리너 등록이 완료되었습니다.');";
	        msg += "location.href='/Urban_Village/main.do';";
	        msg += "</script>";

	        resEntity = new ResponseEntity<>(msg, headers, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();

	        msg = "<script>";
	        msg += "alert('오류가 발생했습니다. 다시 시도하세요.');";
	        msg += "history.back();";
	        msg += "</script>";

	        resEntity = new ResponseEntity<>(msg, headers, HttpStatus.INTERNAL_SERVER_ERROR);
	    }

	    return resEntity;
	}


	private List<String> upload (MultipartHttpServletRequest request) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = request.getFileNames();
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = request.getFile(fileName);
			String imageFileName = mFile.getOriginalFilename();
			File file = new File(CLEANER_UPLOAD_PATH + "//" + fileName);
			fileList.add(imageFileName);

			if(mFile.getSize() != 0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(CLEANER_UPLOAD_PATH+"//"
						+"temp//"+imageFileName));
			}
		}

		return fileList;
	}
	@Override
	@RequestMapping("/cleanerAddAcc.do")
	public ModelAndView findAccByNullCleanerId(@ModelAttribute("AccommodationDTO") AccommodationDTO accDTO,
	                                           HttpServletRequest request, HttpServletResponse response) {
	    String viewName = (String) request.getAttribute("viewName");
	    ModelAndView mav = new ModelAndView();
	    response.setContentType("text/html;charset=utf-8");

	    List<AccommodationDTO> accListByCleanerNull = service.findAccByNullCleanerId();
	    String msg = "";

	    if (accDTO.getCleaner_admin_id() == null || accDTO.getCleaner_admin_id().isEmpty()) {
	        
	        mav.setViewName(viewName);

	        String id = (String) session.getAttribute("adminId");
	        if (id == null) {
	            msg = "<script>";
	            msg += "alert('로그인 정보가 없습니다.');";
	            msg += "location.href='/Urban_Village/member/loginForm.do';";
	            msg += "</script>";
	            mav.addObject("msg", msg);
	            return mav;
	        }

	        accDTO.setCleaner_admin_id(id);
	        mav.addObject("accListByCleanerNull", accListByCleanerNull);

	    } else {
	        msg = "<script>";
	        msg += "alert('모든 숙소에 청소부가 배정되어 있습니다.');";
	        msg += "location.href='/Urban_Village/admin/cleanerList.do';";
	        msg += "</script>";
	        mav.addObject("msg", msg);
	    }

	    return mav;
	}
	@Override
	@RequestMapping("addCleanerId.do")
	public ModelAndView addCleanerId(@ModelAttribute("AccommodationDTO")AccommodationDTO accDTO,@RequestParam("accommodation_id")String accommodation_id, @RequestParam("cleaner_admin_id")String cleaner_admin_id,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		accDTO.setAccommodation_id(accommodation_id);
	    accDTO.setCleaner_admin_id(cleaner_admin_id);

	    int result = service.addCleanerId(accDTO);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (result == 1) {
			if(accDTO.getCleaner_admin_id() == cleaner_admin_id) {
				
			}
			out.write("<script>");
			out.write("alert('숙소관리자 배정에 성공했습니다!');");
			out.write("location.href='/Urban_Village/cleaner/cleanerAddAcc.do';");
			out.write("</script>");
		} else {
			out.write("<script>");
			out.write("alert('숙소관리자 배정에 실패했습니다.');");
			out.write("location.href='/Urban_Village/cleaner/cleanerAddAcc.do';");
			out.write("</script>");
		}
		return null;
		
	}
	@Override
	@RequestMapping("cleanerIdDelete.do")
	public ModelAndView cleanerIdDelete(@RequestParam("member_id")String cleaner_admin_id,HttpServletRequest request, HttpServletResponse response) throws IOException {
		int result = service.cleanerIdDelete(cleaner_admin_id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (result == 1) {
			out.write("<script>");
			out.write("alert('지원자 정보 삭제에 성공했습니다!');");
			out.write("location.href='/Urban_Village/admin/cleanerList.do';");
			out.write("</script>");
		} else {
			out.write("<script>");
			out.write("alert('지원자 정보 삭제에 실패했습니다.');");
			out.write("location.href='/Urban_Village/cleaner/cleanerIdDelete.do';");
			out.write("</script>");
		}
		return null;
		
	}
	
	@RequestMapping("/applyForm")
	public String showCleanerForm(HttpServletRequest request, Model model) {
	    String loginId = (String) request.getSession().getAttribute("loginId");
	    boolean alreadyApplied = service.hasAlreadyApplied(loginId);
	    System.out.println("클리너 정보"+ alreadyApplied);
	    model.addAttribute("alreadyApplied", alreadyApplied);
	    return "cleaner/cleanerForm"; 
	}
	
	@Override
	@RequestMapping("/jusoPopup") 
	public void jusoPopup() { 
		 // 뷰 이름 추출하는거라 절대절대 삭제하지마세유 내용 없는게 맞아요
		 }
}
