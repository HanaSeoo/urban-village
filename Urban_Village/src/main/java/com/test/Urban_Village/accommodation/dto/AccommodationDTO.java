package com.test.Urban_Village.accommodation.dto;

import java.util.List;

public class AccommodationDTO {

    private String accommodation_id;     // 숙소 고유번호
    private String admin_id;             // 관리자 ID
    private String accommodation_name;   // 숙소 이름
    private String accommodation_photo;  // 숙소 대표 사진
    private String cleaner_admin_id;     // 청소 관리자 ID
    private int capacity;                // 최대 수용 인원
    private int room_count;              // 방 개수
    private int bathroom_count;          // 욕실 개수
    private int bed_count;               // 침대 개수
    private String wifi_avail;           // 와이파이 여부
    private String review_data;          // 리뷰 데이터
    private int price;                   // 가격
    private List<String> imageList;
    private String accommodation_address;
    private double averageRating;
    private boolean liked;
    private String latestReview;
    private int view_count;              //조회수 조회              
    private int reservation_count;              //예약수 조회 


    
    public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getReservation_count() {
		return reservation_count;
	}
	public void setReservation_count(int reservation_count) {
	      this.reservation_count = reservation_count;
	   }

	public String getLatestReview() {
		return latestReview;
	}

	public void setLatestReview(String latestReview) {
		this.latestReview = latestReview;
	}

	public String getAccommodation_address() {
		return accommodation_address;
	}

	public void setAccommodation_address(String accommodation_address) {
		this.accommodation_address = accommodation_address;
	}

	public double getAverageRating() {
		return averageRating;
	}

	public void setAverageRating(double averageRating) {
		this.averageRating = averageRating;
	}

	public boolean isLiked() {
        return liked;
    }

    public void setLiked(boolean liked) {
        this.liked = liked;
    }

    
    public List<String> getImageList() {
		return imageList;
	}

	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}

	@Override
    public String toString() {
        return "AccommodationDTO{" +
                "accommodation_id='" + accommodation_id + '\'' +
                ", accommodation_name='" + accommodation_name + '\'' +
                ", price=" + price +
                ", accommodation_photo='" + accommodation_photo + '\'' +
                ", room_count=" + room_count +
                '}';
    }

    public String getAccommodation_id() {
        return accommodation_id;
    }
    public void setAccommodation_id(String accommodation_id) {
        this.accommodation_id = accommodation_id;
    }
    public String getAdmin_id() {
        return admin_id;
    }
    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }
    public String getAccommodation_name() {
        return accommodation_name;
    }
    public void setAccommodation_name(String accommodation_name) {
        this.accommodation_name = accommodation_name;
    }
    public String getAccommodation_photo() {
        return accommodation_photo;
    }
    public void setAccommodation_photo(String accommodation_photo) {
        this.accommodation_photo = accommodation_photo;
    }
    public String getCleaner_admin_id() {
        return cleaner_admin_id;
    }
    public void setCleaner_admin_id(String cleaner_admin_id) {
        this.cleaner_admin_id = cleaner_admin_id;
    }
    public int getCapacity() {
        return capacity;
    }
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
    public int getRoom_count() {
        return room_count;
    }
    public void setRoom_count(int room_count) {
        this.room_count = room_count;
    }
    public int getBathroom_count() {
        return bathroom_count;
    }
    public void setBathroom_count(int bathroom_count) {
        this.bathroom_count = bathroom_count;
    }
    public int getBed_count() {
        return bed_count;
    }
    public void setBed_count(int bed_count) {
        this.bed_count = bed_count;
    }
    public String getWifi_avail() {
        return wifi_avail;
    }
    public void setWifi_avail(String wifi_avail) {
        this.wifi_avail = wifi_avail;
    }
    public String getReview_data() {
        return review_data;
    }
    public void setReview_data(String review_data) {
        this.review_data = review_data;
    }
    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }

}
