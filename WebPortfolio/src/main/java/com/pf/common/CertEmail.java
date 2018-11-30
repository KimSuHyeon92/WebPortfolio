package com.pf.common;

import java.util.Date;


import org.apache.ibatis.type.Alias;
@Alias("CertEmail")
public class CertEmail {
	
	private int idx;
	private String userEmail;
	private String sendEmail;
	private String certYn;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getSendEmail() {
		return sendEmail;
	}
	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}
	public String getCertYn() {
		return certYn;
	}
	public void setCertYn(String certYn) {
		this.certYn = certYn;
	}
	
	
	

}
