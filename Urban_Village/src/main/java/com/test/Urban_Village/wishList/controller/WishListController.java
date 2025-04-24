package com.test.Urban_Village.wishList.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface WishListController {

    String addWishlist(@RequestParam("memberId") String memberId,
                       @RequestParam("accommodationId") String accommodationId,
                       HttpServletRequest request, HttpServletResponse response);

    String removeWishlist(@RequestParam("memberId") String memberId,
                          @RequestParam("accommodationId") String accommodationId,
                          HttpServletRequest request, HttpServletResponse response);


    String checkWishlist(@RequestParam("memberId") String memberId,
                         @RequestParam("accommodationId") String accommodationId,
                         HttpServletRequest request, HttpServletResponse response);

	ModelAndView getWishlist(String memberId, HttpServletRequest request, HttpServletResponse response);

}