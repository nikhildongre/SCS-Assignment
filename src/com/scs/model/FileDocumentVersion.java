package com.scs.model;

import java.util.Date;

import org.bson.types.BSONTimestamp;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

public class FileDocumentVersion {

	 String versionNo;
	 Long revisionNo;
	 String comments;
	 String modifiedBy;
	 String content;
	 @DateTimeFormat(iso = ISO.DATE_TIME)
	 Date modifiedDate;
	
	 
	public String getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}
	
	public Long getRevisionNo() {
		return revisionNo;
	}
	public void setRevisionNo(Long revisionNo) {
		this.revisionNo = revisionNo;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public FileDocumentVersion() {
		super();
	}
	public FileDocumentVersion(String versionNo, Long revisionNo,
			String comments, String modifiedBy, String content,
			Date modifiedDate) {
		super();
		this.versionNo = versionNo;
		this.revisionNo = revisionNo;
		this.comments = comments;
		this.modifiedBy = modifiedBy;
		this.content = content;
		this.modifiedDate = modifiedDate;
	}
	 
	
	
	 
}
