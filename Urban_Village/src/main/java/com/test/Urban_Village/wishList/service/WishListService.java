package com.test.Urban_Village.wishList.service;

import java.util.List;

import com.test.Urban_Village.wishList.dto.WishListDTO;

public interface WishListService {
	int addWishlist(WishListDTO WishListDTO);
	int removeWishlist(WishListDTO WishListDTO);
	List<WishListDTO> getWishlistByMemberId(String memberId);
	WishListDTO checkWishlist(WishListDTO WishListDTO);
	boolean isLiked(String memberId, String accommodationId);
}
