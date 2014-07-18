/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools , Templates
 * and open the template in the editor.
 */
package com.tracktopell.apartmentbalancemanager.model.dao;

import com.tracktopell.apartmentbalancemanager.model.dto.Registro;
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
public class RegistroDAO {

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

	public RegistroDAO(DataSource ds) {
		this.ds = ds;
	}

	public List<Registro> getAllRegistro() {
		List<Registro> list = null;
		
		Connection conn= null;
		Statement st = null;
		try {
            conn= getConnection();
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT R.ID,R.EMAIL,R.CONCEPTO_ID,R.IMPORTE,R.FECHA,U.NOMBRE,C.DESCRIPCION FROM REGISTRO R, USUARIO U,CONCEPTO C WHERE R.EMAIL=U.EMAIL AND R.CONCEPTO_ID=C.ID ORDER BY U.NOMBRE,R.FECHA");
			list = new ArrayList<Registro>();
			while(rs.next()){
				Registro entity = new Registro();
				
				entity.setId(rs.getInt(1));
				entity.setEmail(rs.getString(2));
				entity.setConceptoId(rs.getInt(3));
				entity.setImporte(rs.getDouble(4));
				entity.setFecha(rs.getTimestamp(5));
				
				entity.setNombre(rs.getString(6));
                entity.setConcepto(rs.getString(7));
				
				list.add(entity);
			}
            conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
		return list;
	}
	
	public List<Registro> getAllRegistroBy(String email) {
		List<Registro> list = null;
		
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("SELECT R.ID,R.EMAIL,R.CONCEPTO_ID,R.IMPORTE,R.FECHA,U.NOMBRE,C.DESCRIPCION FROM REGISTRO R, USUARIO U,CONCEPTO C WHERE R.EMAIL=U.EMAIL AND R.CONCEPTO_ID=C.ID AND R.EMAIL=U.EMAIL AND R.EMAIL=? ORDER BY R.FECHA");
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			list = new ArrayList<Registro>();
			while(rs.next()){
				Registro entity = new Registro();
				
				entity.setId(rs.getInt(1));
				entity.setEmail(rs.getString(2));
				entity.setConceptoId(rs.getInt(3));
				entity.setImporte(rs.getDouble(4));
				entity.setFecha(rs.getTimestamp(5));
				
				entity.setNombre(rs.getString(6));
				entity.setConcepto(rs.getString(7));
                
				list.add(entity);
			}
			System.err.println("->getAllRegistroBy(String email="+email+"): list="+list.size());
            conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
		return list;
	}

	public Registro get(Integer id) {
		Registro enttity = null;
		
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
		
			st = conn.prepareStatement("SELECT R.ID,R.EMAIL,R.CONCEPTO_ID,R.IMPORTE,R.FECHA,U.NOMBRE,C.DESCRIPCION FROM REGISTRO R, USUARIO U,CONCEPTO C WHERE R.ID=?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
			while(rs.next()){
				Registro entity = new Registro();
				
				entity.setId(rs.getInt(1));
				entity.setEmail(rs.getString(2));
				entity.setConceptoId(rs.getInt(3));
				entity.setImporte(rs.getDouble(4));
				entity.setFecha(rs.getTimestamp(5));
				
				entity.setNombre(rs.getString(6));							
                entity.setConcepto(rs.getString(7));
			}
            conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
		return enttity;
	}

	public Registro set(Registro entity) {
		Connection conn= null;
		PreparedStatement st = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("INSERT INTO REGISTRO(EMAIL,CONCEPTO_ID,IMPORTE,FECHA) VALUES (?,?,?,?)");
			
			st.setString   (1, entity.getEmail());
			st.setInt      (2, entity.getConceptoId());
			st.setDouble   (3, entity.getImporte());
			st.setTimestamp(4, new Timestamp(entity.getFecha().getTime()));
			
			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			ResultSet rs = st.getGeneratedKeys();
			
			if(rs.next()){	
				entity.setId(rs.getInt(1));
				System.out.println("->set: 1) \taid=="+entity.getId());
			}
			
			st.close();
			
			st = conn.prepareStatement("UPDATE INTO USUARIO SET SALDO = SALDO+? WHERE EMAIL=?");
			
			st.setDouble   (1, entity.getImporte());
			st.setString   (2, entity.getEmail());
			
			affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			rs = st.getGeneratedKeys();
			
			if(rs.next()){	
				entity.setId(rs.getInt(1));
				System.out.println("->set: 2) \taid=="+entity.getId());
			}
			
			st.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}

		return entity;
	}

	public void delete(Registro entity) {

	}

}
