package com.scs.model;

public class FileLockedByUser {

	private String fileId;
	private String fileName;
	private String lockedByUserName;
	private boolean isLocked;
	
	public FileLockedByUser() {
	
	}

	public FileLockedByUser(String fileId, String fileName,
			String lockedByUserName, boolean isLocked) {
		super();
		this.fileId = fileId;
		this.fileName = fileName;
		this.lockedByUserName = lockedByUserName;
		this.isLocked = isLocked;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getLockedByUserName() {
		return lockedByUserName;
	}

	public void setLockedByUserName(String lockedByUserName) {
		this.lockedByUserName = lockedByUserName;
	}

	public boolean isLocked() {
		return isLocked;
	}

	public void setLocked(boolean isLocked) {
		this.isLocked = isLocked;
	}

	@Override
	public String toString() {
		return "FileLockedByUser [fileId=" + fileId + ", fileName=" + fileName
				+ ", lockedByUserName=" + lockedByUserName + ", isLocked="
				+ isLocked + "]";
	}
	
	
	
}
