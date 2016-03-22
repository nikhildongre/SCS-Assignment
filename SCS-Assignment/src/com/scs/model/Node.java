package com.scs.model;

import java.util.Date;
import java.util.List;

public class Node {

	private String id;
	private String fileName;
	private String text;
	private String parentNodeId;
	private String icon;
	private boolean children;
	private String type;
	private boolean isFile;
	private NodeAttributes a_attr;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public boolean isFile() {
		return isFile;
	}

	public void setFile(boolean isFile) {
		this.isFile = isFile;
	}

	public String getIcon() {
		return (isFile() ? (this.a_attr.isLocked() ? "resources/images/lockedFile.png":"resources/images/file.png")
				: "resources/images/folder.png");
	}

	public boolean isChildren() {

		return isFile() ? false : true;
	}

	public String getText() {
		return fileName;
	}

	public String getType() {

		return isFile() ? "file" : "";
	}

	

	public NodeAttributes getA_attr() {
		return a_attr;
	}

	public void setA_attr(NodeAttributes a_attr) {
		this.a_attr = a_attr;
	}

	public String getParentNodeId() {
		return parentNodeId;
	}

	public void setParentNodeId(String parentNodeId) {
		this.parentNodeId = parentNodeId;
	}
	

}
