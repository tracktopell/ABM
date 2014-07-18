/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools , Templates
 * and open the template in the editor.
 */
package com.tracktopell.apartmentbalancemanager.model.dao;

import com.tracktopell.apartmentbalancemanager.model.dto.Concepto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

/**
 *
 * @author alfredo
 */
public class ConceptoDAO {

	private DataSource ds;
	private Connection internalConnconn;

	private Connection getConnection() {
		try {
			if (internalConnconn == null) {
				internalConnconn = ds.getConnection();

			} else {
				if (internalConnconn.isClosed()) {
					internalConnconn = null;
					internalConnconn = ds.getConnection();
				}
			}
		} catch (SQLException ex) {

		}

		return internalConnconn;
	}

	public ConceptoDAO(DataSource ds) {
		this.ds = ds;
	}

	public List<Concepto> getAllConcepto() {
		List<Concepto> list = null;
		
		Connection conn= null;
		Statement st = null;
		try {
            conn= getConnection();
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT ID,DESCRIPCION,FACTOR_CARGO_ABONO FROM CONCEPTO ORDER BY FACTOR_CARGO_ABONO ASC,DESCRIPCION DESC");
			list = new ArrayList<Concepto>();
			while(rs.next()){
				Concepto entity = new Concepto();
				
				entity.setId(rs.getInt(1));
				entity.setDescripcion(rs.getString(2));
				entity.setFactorCargoAbono(rs.getInt(3));
				
				list.add(entity);
			}
            conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
		return list;
	}
	
	public Concepto get(Integer id) {
		Concepto enttity = null;
		
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
		
			st = conn.prepareStatement("SELECT ID,DESCRIPCION,FACTOR_CARGO_ABONO FROM CONCEPTO WHERE ID=?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
			while(rs.next()){
				Concepto entity = new Concepto();
				
				entity.setId(rs.getInt(1));
				entity.setDescripcion(rs.getString(2));
				entity.setFactorCargoAbono(rs.getInt(3));
			}
            conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
		return enttity;
	}

	public Concepto set(Concepto entity) {
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("INSERT INTO CONCEPTO(DESCRIPCION,FACTOR_CARGO_ABONO) VALUES (?,?)");
			
			st.setString   (1, entity.getDescripcion());
			st.setDouble   (2, entity.getFactorCargoAbono());
			
			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			ResultSet rs = st.getGeneratedKeys();
			
			if(rs.next()){	
				entity.setId(rs.getInt(1));
				System.out.println("->set: 1) \taid=="+entity.getId());
			}
			
			st.close();			
			conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}

		return entity;
	}

	public void delete(Concepto entity) {
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("DELETE FROM CONCEPTO WHERE ID=?");
			
			st.setInt(1, entity.getId());
			
			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			
			st.close();			
			conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}

	}

}
