package com.test.Urban_Village.wishList.dto;

public class WishListDTO {
	private int wishlistId;
	private String memberId;
	private String accommodationId;
	
	public WishListDTO() {
		// TODO Auto-generated constructor stub
	}
	public WishListDTO(int wishlistId, String memberId, String accommodationId) {
		// TODO Auto-generated constructor stub
		this.wishlistId =wishlistId;
		this.memberId =memberId;
		this.accommodationId =accommodationId;
	}
	
	public int getWishlistId() {
		return wishlistId;
	}
	public void setWishlistId(int wishlistId) {
		this.wishlistId = wishlistId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getAccommodationId() {
		return accommodationId;
	}
	public void setAccommodationId(String accommodationId) {
		this.accommodationId = accommodationId;
	}
	
	// toString 메서드 (객체의 정보를 문자열로 표현하기 위해 오버라이드)
    @Override
    public String toString() {
        return "WishListDTO{" +
                "wishlistId=" + wishlistId +
                ", memberId='" + memberId + '\'' +
                ", accommodationId='" + accommodationId + '\'' +
                '}';
    }
	
}