/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools , Templates
 * and open the template in the editor.
 */
package com.tracktopell.apartmentbalancemanager.model.dao;

import com.tracktopell.apartmentbalancemanager.model.dto.Usuario;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
public class UsuarioDAO {

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

	public UsuarioDAO(DataSource ds) {
		this.ds = ds;
	}

	public List<Usuario> getAllUsuario() {
		List<Usuario> list = null;
		
		Connection conn=null;
		Statement st = null;
		try {
            conn= getConnection();
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT EMAIL,NOMBRE,PASSWORD,DEPARTAMENTO,HABILITADO,SALDO  FROM USUARIO");
			list = new ArrayList<Usuario>();
			while(rs.next()){
				Usuario entity = new Usuario();
				
				entity.setEmail(rs.getString(1));
				entity.setNombre(rs.getString(2));
				entity.setPassword(rs.getString(3));
				entity.setDepartamento(rs.getString(4));
				entity.setHabilitado(rs.getInt(5));
				entity.setSaldo(rs.getDouble(6));
				
				list.add(entity);
			}
            conn.close();
		}catch(SQLException e){
		}
		
		return list;
	}
	
	public Usuario get(String email) {
		Usuario entity = null;
		
		Connection conn= getConnection();
		PreparedStatement st = null;
		try {
			st = conn.prepareStatement("SELECT EMAIL,NOMBRE,PASSWORD,DEPARTAMENTO,HABILITADO,SALDO FROM USUARIO WHERE EMAIL=?");
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while(rs.next()){
				entity = new Usuario();
				
				entity.setEmail(rs.getString(1));
				entity.setNombre(rs.getString(2));
				entity.setPassword(rs.getString(3));
				entity.setDepartamento(rs.getString(4));
				entity.setHabilitado(rs.getInt(5));
				entity.setSaldo(rs.getDouble(6));
								
			}
            conn.close();
		}catch(SQLException e){
		}
		
		return entity;
	}

	public Usuario set(Usuario entity) throws EntityAlreadyExsist{
		System.out.println("->UsuarioDAO.set: affected="+entity.getEmail());
		Connection conn=null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("INSERT INTO USUARIO(EMAIL,NOMBRE,PASSWORD,DEPARTAMENTO,HABILITADO,SALDO) VALUES (?,?,?,?,?,?)");
			
			st.setString   (1, entity.getEmail());
			st.setString   (2, entity.getNombre());
			st.setString   (3, getMD5Encrypted(entity.getPassword()));
			st.setString   (4, entity.getDepartamento());
			st.setInt      (5, entity.getHabilitado());
			st.setDouble   (6, entity.getSaldo());
			
			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			
			st = conn.prepareStatement("INSERT INTO ROL_USUARIO (ROL,EMAIL) VALUES (?,?)");
			st.setString(1, "INQUILINO");
			st.setString(2, entity.getEmail());
			
			affected = st.executeUpdate();
			
			st.close();
			
			System.out.println("->set: affected="+affected);
			conn.close();
		} catch(SQLException e){			
			e.printStackTrace(System.err);
		}
		return entity;
	}

	public Usuario update(Usuario entity) throws EntityAlreadyExsist{
		System.out.println("->UsuarioDAO.set: affected="+entity.getEmail());
		Connection conn= null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("UPDATE USUARIO SET NOMBRE=?,PASSWORD=?,DEPARTAMENTO=?,HABILITADO=?,SALDO=? WHERE EMAIL=?");
			
			st.setString   (1, entity.getNombre());
			st.setString   (2, entity.getPassword());
			st.setString   (3, entity.getDepartamento());
			st.setInt      (4, entity.getHabilitado());
			st.setDouble   (5, entity.getSaldo());
			
			st.setString   (6, entity.getEmail());
			
			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			
			st.close();
			conn.close();
		} catch(SQLException e){			
			e.printStackTrace(System.err);
		}
		return entity;
	}

	public void delete(Usuario entity) {
		Connection conn= null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
            conn= getConnection();
			st = conn.prepareStatement("DELETE FROM USUARIO WHERE EMAIL=?");
			
			st.setString   (1, entity.getEmail());

			int affected = st.executeUpdate();
			System.out.println("->set: affected="+affected);
			
			st.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace(System.err);
		}
		
	}

	public static String getMD5Encrypted(String e) {

		MessageDigest mdEnc = null; // Encryption algorithm
		try {
			mdEnc = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException ex) {
			return null;
		}
		mdEnc.update(e.getBytes(), 0, e.length());
		return (new BigInteger(1, mdEnc.digest())).toString(16);
	}

}
