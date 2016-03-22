package com.scs.dao;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.scs.model.FileDocument;

public interface FileDAO extends MongoRepository<FileDocument, String> {
	
	@Query("{'path' : {$regex : ?0}}")
	public List<FileDocument> findByPathClone(String path);

	public FileDocument findById(int id);

	public List<FileDocument> findByPath(String path);

	public FileDocument findByNameAndIsRootFolder(String fileName,
			boolean isRoot);

	public List<FileDocument> findByParentNodeId(String parentNodeId);
	
	@Query("{ 'name' : ?0 }")
	public FileDocument findByName(String fileName);

}
