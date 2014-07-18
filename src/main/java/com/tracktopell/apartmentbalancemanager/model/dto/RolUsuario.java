/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tracktopell.apartmentbalancemanager.model.dto;

/**
 *
 * @author alfredo
 */
public class RolUsuario {
	private String rol;
	private String email;

	public RolUsuario() {
	}

	public RolUsuario(String rol, String email) {
		this.rol = rol;
		this.email = email;
	}
	
	/**
	 * @return the rol
	 */
	public String getRol() {
		return rol;
	}

	/**
	 * @param rol the rol to set
	 */
	public void setRol(String rol) {
		this.rol = rol;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

}
