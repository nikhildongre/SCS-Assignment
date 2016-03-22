package test.com.scs.service;

import static org.junit.Assert.*;
import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;

import com.scs.service.MailService;

public class MailServiceTest {

	MailService mailService;
	
	@Before
	public void setUp() throws Exception {
		mailService=new MailService();
		
	}

	@Test
	public void test() {
		org.junit.Assert.assertEquals("abc", mailService.generatePassword());
		
	}

}
