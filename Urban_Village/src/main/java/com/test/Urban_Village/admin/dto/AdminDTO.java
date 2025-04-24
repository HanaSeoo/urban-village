package com.test.Urban_Village.admin.dto;

public class AdminDTO {

	    private String admin_id;           // 관리자 ID
	    private String pwd;               // 비밀번호
	    private String email;             // 이메일
	    private String name;              // 관리자 이름
	    private String phone_number;       // 관리자 전화번호
	    private String organization;      // 소속 기관
	    private String location;          // 소속 위치
		public String getAdmin_id() {
			return admin_id;
		}
		public void setAdmin_id(String admin_id) {
			this.admin_id = admin_id;
		}
		public String getPwd() {
			return pwd;
		}
		public void setPwd(String pwd) {
			this.pwd = pwd;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getPhone_number() {
			return phone_number;
		}
		public void setPhone_number(String phone_number) {
			this.phone_number = phone_number;
		}
		public String getOrganization() {
			return organization;
		}
		public void setOrganization(String organization) {
			this.organization = organization;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}

	    
}



