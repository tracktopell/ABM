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
public class Concepto {
    private Integer id;
    private String descripcion;
    private Integer factorCargoAbono;

    public Concepto() {
    }

    public Concepto(Integer id, String descripcion, Integer factorCargoAbono) {
        this.id = id;
        this.descripcion = descripcion;
        this.factorCargoAbono = factorCargoAbono;
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
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the factorCargoAbono
     */
    public Integer getFactorCargoAbono() {
        return factorCargoAbono;
    }

    /**
     * @param factorCargoAbono the factorCargoAbono to set
     */
    public void setFactorCargoAbono(Integer factorCargoAbono) {
        this.factorCargoAbono = factorCargoAbono;
    }
}
