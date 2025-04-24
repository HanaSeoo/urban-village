package com.test.Urban_Village;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.admin.service.AdminService;
import com.test.Urban_Village.review.service.ReviewService;
import com.test.Urban_Village.wishList.service.WishListService;

@Controller
public class MainController {
	
	@Autowired
	AccommodationService service;
	@Autowired
	AdminService adminService;
	@Autowired
	WishListService wishListService;
	@Autowired
	ReviewService rService;

	@RequestMapping(value= {"/", "/main"}) 
	public ModelAndView main(HttpSession session,@ModelAttribute("AccommodationIdDTO") AccommodationIdDTO accIdDTO, @ModelAttribute AccommodationDTO accDTO) {
	    List<AccommodationDTO> accommodationList = service.accList();
	    session.setAttribute("accommodationList", accommodationList);
	    ModelAndView mav = new ModelAndView();
	    

	    List<AccommodationIdDTO> hostBestAccIdList = adminService.accIdListAll(accIdDTO);
	    String memberId = (String) session.getAttribute("loginId");
        if (memberId != null) {
            for (AccommodationDTO acc : accommodationList) {
                boolean liked = wishListService.isLiked(memberId, acc.getAccommodation_id());
                acc.setLiked(liked);  // AccommodationDTO에 setLiked(boolean) 필요
            }
        }
        
        for (AccommodationDTO acc : accommodationList) {
            Double avgRating = rService.getAverageRatingByAccommodationId(acc.getAccommodation_id());
            System.out.println("메인에 진입함");
            System.out.println("리스트 " + accommodationList);
            if (avgRating == null) {
                avgRating = 0.0;
                System.out.println("이프문 들어옴");
            }
            acc.setAverageRating(avgRating);
            
          String latestReview = rService.getLatestReview(acc.getAccommodation_id()); // 최신 리뷰 한 개
          System.out.println("호잇오"+latestReview);
          int viewCount = service.getViewCount(acc.getAccommodation_id());
          System.out.println("조회수 " + viewCount);
          Integer reservationCount = service.getReservationCountByAccommodationId(acc.getAccommodation_id());
          System.out.println("id"+acc.getAccommodation_id());
          System.out.println("예약수 : " + reservationCount );
          acc.setReservation_count(reservationCount);
          acc.setView_count(viewCount);
          acc.setLatestReview(latestReview);
          
        }
        
	    mav.addObject("hostBestAccIdList", hostBestAccIdList);
	    session.setAttribute("hostBestAccIdList", hostBestAccIdList);
	    mav.setViewName("urbanMain");
	    return mav;
	}

}