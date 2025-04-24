package com.test.Urban_Village.wishList.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.wishList.dao.WishListDAO;
import com.test.Urban_Village.wishList.dto.WishListDTO;

@Service
public class WishListServiceImpl implements WishListService{

	@Autowired
	private WishListDAO WDAO;
	
	@Override
	public int addWishlist(WishListDTO WishListDTO) {
		// TODO Auto-generated method stub
		return WDAO.insertWishlist(WishListDTO);
	}

	@Override
	public int removeWishlist(WishListDTO WishListDTO) {
		// TODO Auto-generated method stub
		return WDAO.deleteWishlist(WishListDTO);
	}

	@Override
	public List<WishListDTO> getWishlistByMemberId(String memberId) {
		// TODO Auto-generated method stub
		return WDAO.selectWishlistByMemberId(memberId);
	}

	@Override
	public WishListDTO checkWishlist(WishListDTO WishListDTO) {
		// TODO Auto-generated method stub
		return WDAO.selectWishlistByMemberIdAndAccommodationId(WishListDTO);
	}
	@Override
	public boolean isLiked(String memberId, String accommodationId) {
	    WishListDTO dto = new WishListDTO();
	    dto.setMemberId(memberId);
	    dto.setAccommodationId(accommodationId);
	    return WDAO.selectWishlistByMemberIdAndAccommodationId(dto) != null;
	}

}
