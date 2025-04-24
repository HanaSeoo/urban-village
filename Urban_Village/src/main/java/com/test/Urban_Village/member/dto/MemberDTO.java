package com.test.Urban_Village.member.dto;

import java.sql.Date;

public class MemberDTO {
    
    private String id;                // 회원 ID
    private String pwd;               // 비밀번호
    private String email;             // 이메일
    private Date birth;               // 생년월일
    private String gender;            // 성별
    private String phonenumber;      // 전화번호
    private String name;              // 이름
    private Date regdate;             // 등록일
    private Date moddate;            // 수정일
    private String join_type;        //구글로 로그인 했을 때 회원가입 처리
    private String coupon_id;      //쿠폰아이디
    private int discount;         //할인율
    private String coupon_name;     //쿠폰이름
    private Date expiration_date;   //유효기간
    private String is_used;         //사용가능여부
    private Date used_date;
    
    
    public String getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(String coupon_id) {
		this.coupon_id = coupon_id;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public String getCoupon_name() {
		return coupon_name;
	}

	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}

	public Date getExpiration_date() {
		return expiration_date;
	}

	public void setExpiration_date(Date expiration_date) {
		this.expiration_date = expiration_date;
	}

	public String getIs_used() {
		return is_used;
	}

	public void setIs_used(String is_used) {
		this.is_used = is_used;
	}

	public Date getUsed_date() {
		return used_date;
	}

	public void setUsed_date(Date used_date) {
		this.used_date = used_date;
	}

	public String getJoin_type() {
		return join_type;
	}

	public void setJoin_type(String join_type) {
		this.join_type = join_type;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public Date getModdate() {
        return moddate;
    }

    public void setModdate(Date moddate) {
        this.moddate = moddate;
    }

	
}
