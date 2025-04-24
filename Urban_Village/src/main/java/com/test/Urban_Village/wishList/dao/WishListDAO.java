package com.test.Urban_Village.wishList.dao;

import java.util.List;

import com.test.Urban_Village.wishList.dto.WishListDTO;

public interface WishListDAO {
	
	int insertWishlist(WishListDTO WDTO);
	int deleteWishlist(WishListDTO WDTO);
	List<WishListDTO> selectWishlistByMemberId(String memberId);
	WishListDTO selectWishlistByMemberIdAndAccommodationId(WishListDTO WDTO);
}
