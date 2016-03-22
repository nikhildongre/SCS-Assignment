package com.scs.dao;

import org.springframework.data.mongodb.repository.MongoRepository;


import org.springframework.stereotype.Repository;

import com.scs.model.User;
/**
 * This Repository to maintain the user Data  
 * Authors : Sumit
 */
@Repository
public interface UserDAO extends MongoRepository<User, String> {
	
	
	public User findByUsername(String username);
	public User findById(String id);

}
