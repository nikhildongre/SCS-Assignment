package com.scs.utility;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.scs.model.FileDocument;
import com.scs.model.FileDocumentVersion;
import com.scs.model.Node;
import com.scs.model.NodeAttributes;
import com.scs.model.NodeVersion;

@Component(value="JsonUtility")
public class JsonUtility {
public Node createJson(FileDocument file){
		
		Node rootNode = new Node();
		rootNode.setId(file.getId());
		rootNode.setFileName(file.getName());
		rootNode.setFile(file.isFile());
		rootNode.setParentNodeId(file.getParentNodeId());
		NodeAttributes attr = new NodeAttributes();
		attr.setCreatedDate(new Date());
		attr.setCurrentVersion(file.getCurrentVersion());
		attr.setLocked(file.isLocked());
		attr.setLockedBy(file.getLockedBy());
		attr.setPath(file.getPath());
		attr.setRoot(file.isRootFolder());
		rootNode.setA_attr(attr);
		return rootNode;
	}
	
	public List<Node> createJsonForChildNodes(List<FileDocument> files){
		
		List<Node> childNodes = new ArrayList<Node>();
		for(FileDocument file : files){
			if(!file.isDeleted()){
				Node rFile = new Node();
				NodeAttributes attr = new NodeAttributes();
				rFile.setId(file.getId());
				rFile.setFileName(file.getName());
				rFile.setFile(file.isFile());
				rFile.setParentNodeId(file.getParentNodeId());
				attr.setCreatedDate(new Date());
				attr.setCurrentVersion(file.getCurrentVersion());
				attr.setLocked(file.isLocked());
				attr.setLockedBy(file.getLockedBy());
				attr.setPath(file.getPath());
				attr.setRoot(file.isRootFolder());
				if(file.getVersions() != null && file.getVersions().size() > 0){
					List<NodeVersion> NodeVersions = new ArrayList<NodeVersion>();
					for(FileDocumentVersion fileDocumentVersion : file.getVersions()){
						NodeVersion version = new NodeVersion();
						version.setComment(fileDocumentVersion.getComments());
						version.setModifiedBy(fileDocumentVersion.getModifiedBy());
						version.setVersionNumber(fileDocumentVersion.getVersionNo());
						version.setRevisionNumber(fileDocumentVersion.getRevisionNo());
						version.setModifiedDate(new Date());
						version.setContent(fileDocumentVersion.getContent());
						NodeVersions.add(version);
					}
					attr.setVersions(NodeVersions);
				}
				rFile.setA_attr(attr);
				childNodes.add(rFile);
			  }	
			}
		return childNodes;
	}
}
