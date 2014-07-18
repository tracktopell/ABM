/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tracktopell.apartmentbalancemanager.servlet;

import com.tracktopell.apartmentbalancemanager.model.dao.EntityAlreadyExsist;
import com.tracktopell.apartmentbalancemanager.model.dao.UsuarioDAOFactory;
import com.tracktopell.apartmentbalancemanager.model.dto.Usuario;
import com.tracktopell.util.Base64Coder;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author alfredo
 */
public class VerificarUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String encodedBaParams = request.getRequestURI().replace(request.getContextPath()+request.getServletPath()+"/","");
        String decodedParams   = null;
        String[] allParams = null;
        HashMap<String,String> paramsDecoded = new HashMap<String,String>();
        String email = null;
        Usuario usuario = null;
        String resultado = "";
        if(encodedBaParams.length()>10){
            decodedParams = new String(Base64Coder.decode(encodedBaParams));
            System.out.println("->encodedBaParams:"+encodedBaParams);
            System.out.println("->decodedParams:"+decodedParams);
            
            allParams     = decodedParams.split("&");
            
            System.out.println("->allParams:"+Arrays.asList(allParams));
            for(String pv:allParams){
                String[] paramValue = pv.split("=");
                System.out.println("\t->param:"+Arrays.asList(paramValue));
                paramsDecoded.put(paramValue[0],paramValue[1]);
            }
            email = paramsDecoded.get("email");        
            usuario = UsuarioDAOFactory.getUsuarioDAO().get(email);
        }
        
        
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerificarUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>VerificarUsuario</h1>");
            /*
            out.println("<h3>ContextPath : " + request.getContextPath() + "</h3>");
            out.println("<h3>QueryString :" + request.getQueryString() + "</h3>");
            out.println("<h3>ServletPath :" + request.getServletPath() + "</h3>");
            out.println("<h3>URI :" + request.getRequestURI() + "</h3>");
            out.println("<h3>encodedBaParams : " + encodedBaParams + "</h3>");
            out.println("<h3>paramsDecoded : " + paramsDecoded + "</h3>");
            */
            if(email != null){
                out.println("<h3>email : " + email + "</h3>");
                if(usuario != null) {
                    out.println("<h3>usuario.nombre: " + usuario.getNombre()+ "</h3>");
                    out.println("<h3>usuario.habilitado : " + usuario.getHabilitado()+ "</h3>");
                    if(usuario.getHabilitado() == 0) {
                        usuario.setHabilitado(1);
                        try {
                            UsuarioDAOFactory.getUsuarioDAO().update(usuario);
                            resultado = "<h2>OK, se confirmo satistactoriamente</h2>";                            
                        } catch (EntityAlreadyExsist ex) {
                            resultado = "<h3>Error :"+ex.getMessage()+"</h3>";
                        }
                    } else {
                        resultado = "<h2>Este usuario ya estaba confirmado</h2>";
                    }
                } else {
                    resultado = "<h2>Usuario no existe</h2>";
                }
            } else {
                resultado = "<h2>Error en acceso</h2>";
            }
            
            out.println(resultado);
            out.println("<a href=\""+request.getContextPath()+"/pages/home.jsp\">ACCESO</a>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
