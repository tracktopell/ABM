/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tracktopell.apartmentbalancemanager.model.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author alfredo
 */
public class RegistroDAOFactory {
	private static DataSource getDataSource(){
		DataSource ds = null;
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/APTBLCMGR_DS");			
		} catch (NamingException ex) {
			ex.printStackTrace(System.err);
		}
		
		return ds;
	}
	
	public static RegistroDAO getRegistroDAO(){
		RegistroDAO dao = new RegistroDAO(getDataSource());
		return dao;
	}
	
}
