package com.scs.model;

import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

@Document(collection = "scs_filestructure")
public class FileDocument {

	@Id
	String id;
	String name;
	String path;
	String icon;
	String parentNodeId;
	String content;
	boolean children;
	
	
	
	boolean isLocked;
	String lockedBy;

	boolean isFile;
	boolean isRootFolder;

	String currentVersion;
	String extension;

	boolean isDeleted;
	String deletedBy;
	
	String createdBy;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	Date createdDate;
	 
	List<FileDocumentVersion> versions;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public boolean isChildren() {
		return children;
	}
	public void setChildren(boolean children) {
		this.children = children;
	}
	public boolean isLocked() {
		return isLocked;
	}
	public void setLocked(boolean isLocked) {
		this.isLocked = isLocked;
	}
	public String getLockedBy() {
		return lockedBy;
	}
	public void setLockedBy(String lockedBy) {
		this.lockedBy = lockedBy;
	}
	public boolean isFile() {
		return isFile;
	}
	public void setFile(boolean isFile) {
		this.isFile = isFile;
	}
	public boolean isRootFolder() {
		return isRootFolder;
	}
	public void setRoot(boolean isRootFolder) {
		this.isRootFolder = isRootFolder;
	}

	public String getCurrentVersion() {
		return currentVersion;
	}
	public void setCurrentVersion(String currentVersion) {
		this.currentVersion = currentVersion;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public boolean isDeleted() {
		return isDeleted;
	}
	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getDeletedBy() {
		return deletedBy;
	}
	public void setDeletedBy(String deletedBy) {
		this.deletedBy = deletedBy;
	}
	public List<FileDocumentVersion> getVersions() {
		return versions;
	}
	public void setVersions(List<FileDocumentVersion> versions) {
		this.versions = versions;
	}
	public FileDocument() {
		super();
	}
	public String getParentNodeId() {
		return parentNodeId;
	}
	public void setParentNodeId(String parentNodeId) {
		this.parentNodeId = parentNodeId;
	}
	
	
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public FileDocument(String id, String name, String path,
			boolean isLocked, String lockedBy,
			boolean isFile, boolean isRootFolder, String currentVersion,
			String extension, boolean isDeleted, String deletedBy,String parentNodeId,
			List<FileDocumentVersion> versions) {
		super();
		this.id = id;
		this.name = name;
		this.path = path;
		this.isLocked = isLocked;
		this.lockedBy = lockedBy;
		this.isFile = isFile;
		this.isRootFolder = isRootFolder;
		this.currentVersion = currentVersion;
		this.extension = extension;
		this.isDeleted = isDeleted;
		this.deletedBy = deletedBy;
		this.parentNodeId = parentNodeId;
		this.versions = versions;
	}
	
	
	@Override
	public String toString() {
		return "FileDocument [id=" + id + ", name=" + name + ", path=" + path
				+ ", icon=" + icon + ", parentNodeId=" + parentNodeId
				+ ", content=" + content + ", children=" + children
				+ ", isLocked=" + isLocked + ", lockedBy=" + lockedBy
				+ ", isFile=" + isFile + ", isRootFolder=" + isRootFolder
				+ ", currentVersion=" + currentVersion + ", extension="
				+ extension + ", isDeleted=" + isDeleted + ", deletedBy="
				+ deletedBy + ", createdBy=" + createdBy + ", createdDate="
				+ createdDate + ", versions=" + versions + "]";
	}
	
	
	
}
