package com.test.Urban_Village.wishList.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.wishList.dto.WishListDTO;
import com.test.Urban_Village.wishList.service.WishListService;

@Controller
@RequestMapping("/wishList")
public class WishListControllerImpl implements WishListController {

    @Autowired
    private WishListService WService;

    @Autowired
    AccommodationService accService;
    
    @Override
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)    
    @ResponseBody
    public String addWishlist(@RequestParam("memberId") String memberId,
                              @RequestParam("accommodationId") String accommodationId,
                              HttpServletRequest request, HttpServletResponse response) {
        WishListDTO wishlistDTO = new WishListDTO();
        wishlistDTO.setMemberId(memberId);
        wishlistDTO.setAccommodationId(accommodationId);
        int result = WService.addWishlist(wishlistDTO);
        return String.valueOf(result); // 성공/실패 여부를 문자열로 반환 (JSON 등으로 변경 가능)
    }

    @Override
    @RequestMapping(value = "/remove.do", method = RequestMethod.POST)
    @ResponseBody
    public String removeWishlist(@RequestParam("memberId") String memberId,
                                 @RequestParam("accommodationId") String accommodationId,
                                 HttpServletRequest request, HttpServletResponse response) {
        WishListDTO wishlistDTO = new WishListDTO();
        wishlistDTO.setMemberId(memberId);
        wishlistDTO.setAccommodationId(accommodationId);
        int result = WService.removeWishlist(wishlistDTO);
        return String.valueOf(result); // 성공/실패 여부를 문자열로 반환 (JSON 등으로 변경 가능)
    }

    @Override
    @RequestMapping("/wishList.do")
    public ModelAndView getWishlist(@RequestParam("memberId") String memberId,
                                  HttpServletRequest request, HttpServletResponse response) {
        String viewName = "/wishList/wishListadd";
        List<WishListDTO> wishlistItems = WService.getWishlistByMemberId(memberId);
        
        // 숙소 상세 정보를 저장할 리스트 생성
        List<AccommodationDTO> accommodations = new ArrayList<>();
        
        // 각 위시리스트 항목에 대해 전체 숙소 상세 정보 가져오기
        for (WishListDTO wishItem : wishlistItems) {
            AccommodationDTO accommodation = accService.getAccommodationById(wishItem.getAccommodationId());
            if (accommodation != null) {
                accommodations.add(accommodation);
            }
        }
        
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);
        mav.addObject("wishlistItems", wishlistItems); // 변수명 변경
        mav.addObject("accommodations", accommodations); 
        return mav;
    }
    
    @Override
    @RequestMapping("/check.do")
    @ResponseBody
    public String checkWishlist(@RequestParam("memberId") String memberId,
                                @RequestParam("accommodationId") String accommodationId,
                                HttpServletRequest request, HttpServletResponse response) {
        WishListDTO WDTO = new WishListDTO();
        WDTO.setMemberId(memberId);
        WDTO.setAccommodationId(accommodationId);
        WishListDTO checkedWishlist = WService.checkWishlist(WDTO);
        return (checkedWishlist != null) ? "true" : "false"; // 찜 여부를 문자열로 반환 (JSON 등으로 변경 가능);
    }
}