/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tracktopell.apartmentbalancemanager.model.dto;

import java.sql.Timestamp;

/**
 *
 * @author alfredo
 */
public class Registro {
	private Integer id;
	private String email;
	private Integer conceptoId;
	private Double importe;
	private Timestamp fecha;
    private String concepto;

	private String nombre;

	public Registro() {
	}

	public Registro(Integer id, String Email, Integer conceptoId, Double importe, Timestamp fecha) {
		this.id = id;
		this.email = Email;
		this.conceptoId = conceptoId;
		this.importe = importe;
		this.fecha = fecha;
	}

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the Email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param Email the Email to set
	 */
	public void setEmail(String Email) {
		this.email = Email;
	}

	/**
	 * @return the conceptoId
	 */
	public Integer getConceptoId() {
		return conceptoId;
	}

	/**
	 * @param conceptoId the conceptoId to set
	 */
	public void setConceptoId(Integer conceptoId) {
		this.conceptoId = conceptoId;
	}

	/**
	 * @return the importe
	 */
	public Double getImporte() {
		return importe;
	}

	/**
	 * @param importe the importe to set
	 */
	public void setImporte(Double importe) {
		this.importe = importe;
	}

	/**
	 * @return the fecha
	 */
	public Timestamp getFecha() {
		return fecha;
	}

	/**
	 * @param fecha the fecha to set
	 */
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNombre() {
		return nombre;
	}

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }

    public String getConcepto() {
        return concepto;
    }
    
    
	
}
