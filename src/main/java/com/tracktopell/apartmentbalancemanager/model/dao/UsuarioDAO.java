/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools , Templates
 * and open the template in the editor.
 */
package com.tracktopell.apartmentbalancemanager.model.dao;

import com.tracktopell.apartmentbalancemanager.model.dto.RolUsuario;
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
		} catch(SQLException e){
            e.printStackTrace(System.err);
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
			ResultSet rs = st.executeQuery("SELECT U.EMAIL,U.NOMBRE,U.PASSWORD,U.DEPARTAMENTO,U.HABILITADO,U.SALDO,RU.ROL,RU.EMAIL  FROM USUARIO U,ROL_USUARIO RU WHERE U.EMAIL=RU.EMAIL");
			list = new ArrayList<Usuario>();
            Usuario entity=null;
            List<RolUsuario> roles=null;
            String rol=null;
            String email=null;
			while(rs.next()){
                email = rs.getString(1);
                rol   = rs.getString(7);                
                if(entity == null || (entity!=null && !email.equals(entity.getEmail())) ){
                    if(entity != null){
                        list.add(entity);
                    }
                    entity = new Usuario();
                    roles = new ArrayList<RolUsuario>();
                    roles.add(new RolUsuario(rol, email));
                    entity.setRoles(roles);                    
                    entity.setEmail(email);
                    entity.setNombre(rs.getString(2));
                    entity.setPassword(rs.getString(3));
                    entity.setDepartamento(rs.getString(4));
                    entity.setHabilitado(rs.getInt(5));
                    entity.setSaldo(rs.getDouble(6));
                } else if(entity!=null && email.equals(entity.getEmail())){
                    entity.getRoles().add(new RolUsuario(rol, email));
                }
			}
            conn.close();
		}catch(SQLException e){
            e.printStackTrace(System.err);
		}
		
		return list;
	}
	
	public Usuario get(String emailBuscar) {
        System.out.println("=>get:emailBuscar="+emailBuscar);
		Usuario entity = null;
		
		Connection conn= getConnection();
		PreparedStatement st = null;
		try {
			st = conn.prepareStatement("SELECT U.EMAIL,U.NOMBRE,U.PASSWORD,U.DEPARTAMENTO,U.HABILITADO,U.SALDO,RU.ROL,RU.EMAIL  FROM USUARIO U,ROL_USUARIO RU WHERE U.EMAIL=RU.EMAIL AND U.EMAIL=?");
			st.setString(1, emailBuscar);
			
            List<RolUsuario> roles=null;
            String rol=null;
            String email=null;
            ResultSet rs = st.executeQuery();
			while(rs.next()){
                email = rs.getString(1);
                rol   = rs.getString(7);
                System.out.println("=>get:\temail="+email+", rol="+rol);
                
                if(entity == null || (entity!=null && !email.equals(entity.getEmail())) ){
                    entity = new Usuario();
                    roles = new ArrayList<RolUsuario>();
                    roles.add(new RolUsuario(rol, email));
                    entity.setRoles(roles);                    
                    entity.setEmail(email);
                    entity.setNombre(rs.getString(2));
                    entity.setPassword(rs.getString(3));
                    entity.setDepartamento(rs.getString(4));
                    entity.setHabilitado(rs.getInt(5));
                    entity.setSaldo(rs.getDouble(6));
                } else if(entity!=null && email.equals(entity.getEmail())){
                    entity.getRoles().add(new RolUsuario(rol, email));
                }
           
			}
            conn.close();
		} catch(SQLException e){
            e.printStackTrace(System.err);
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
            List<RolUsuario> roles = entity.getRoles();
            for(RolUsuario r: roles){
                st.clearParameters();
                st.setString(1, r.getRol());            
                st.setString(2, entity.getEmail());			
                st.executeUpdate();
            }
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
			System.out.println("->update: affected="+affected);
			st.close();
            st = conn.prepareStatement("DELETE FROM ROL_USUARIO WHERE EMAIL=?");
			st.setString   (1, entity.getEmail());
            affected = st.executeUpdate();
			System.out.println("->update: deleted roles="+affected);
            st.close();
            
            st = conn.prepareStatement("INSERT INTO ROL_USUARIO (ROL,EMAIL) VALUES (?,?)");
            List<RolUsuario> roles = entity.getRoles();
            affected=0;
            for(RolUsuario r: roles){
                st.clearParameters();
                st.setString(1, r.getRol());            
                st.setString(2, entity.getEmail());			
                affected += st.executeUpdate();
            }
			st.close();
            System.out.println("->update: inserted roles="+affected);
            
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
