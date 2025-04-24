package com.test.Urban_Village.cleaner.dto;

import java.sql.Date;

public class CleanerDTO {
    private String member_id;         // 회원 ID
    private String address;           // 거주지 주소
    //private String income_proof;      // 소득 증빙서류 (파일 경로)
    private Date regdate;            // 등록 날짜
    private Date moddate;            // 수정 날짜
        private String memberName;
        private String memberPhone;
        private Date memberBirth;
        private String memberGender;
        private String incomeProof;


    public String getMemberName() {
			return memberName;
		}

		public void setMemberName(String memberName) {
			this.memberName = memberName;
		}

		public String getMemberPhone() {
			return memberPhone;
		}

		public void setMemberPhone(String memberPhone) {
			this.memberPhone = memberPhone;
		}

		public Date getMemberBirth() {
			return memberBirth;
		}

		public void setMemberBirth(Date memberBirth) {
			this.memberBirth = memberBirth;
		}

		public String getMemberGender() {
			return memberGender;
		}

		public void setMemberGender(String memberGender) {
			this.memberGender = memberGender;
		}

		public String getIncomeProof() {
			return incomeProof;
		}

		public void setIncomeProof(String incomeProof) {
			this.incomeProof = incomeProof;
		}

	public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

	/*
	 * public String getIncome_proof() { return income_proof; }
	 * 
	 * public void setIncome_proof(String income_proof) { this.income_proof =
	 * income_proof; }
	 */

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
