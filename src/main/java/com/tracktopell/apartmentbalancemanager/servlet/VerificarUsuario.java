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
        String encodedBaParams = request.getRequestURI().replace(request.getContextPath() + request.getServletPath() + "/", "");
        String decodedParams = null;
        String[] allParams = null;
        HashMap<String, String> paramsDecoded = new HashMap<String, String>();
        String email = null;
        Usuario usuario = null;
        String resultado = "";
        if (encodedBaParams.length() > 10) {
            decodedParams = new String(Base64Coder.decode(encodedBaParams));
            System.out.println("->encodedBaParams:" + encodedBaParams);
            System.out.println("->decodedParams:" + decodedParams);

            allParams = decodedParams.split("&");

            System.out.println("->allParams:" + Arrays.asList(allParams));
            for (String pv : allParams) {
                String[] paramValue = pv.split("=");
                System.out.println("\t->param:" + Arrays.asList(paramValue));
                paramsDecoded.put(paramValue[0], paramValue[1]);
            }
            email = paramsDecoded.get("email");
            usuario = UsuarioDAOFactory.getUsuarioDAO().get(email);
        }

        PrintWriter out = response.getWriter();
        try {
            out.print("<!DOCTYPE HTML>\n"
                + "<html>\n"
                + "\n"
                + "    <head>\n"
                + "        <title>A.B.M. - login</title>\n"
                + "        <meta name=\"description\"  content=\"website description\" />\n"
                + "        <meta name=\"keywords\"     content=\"website keywords, website keywords\" />\n"
                + "        <link rel=\"stylesheet\" type=\"text/css\" href=\"" + request.getContextPath() + "/css/style.css\" />\n"
                + "        <script type=\"text/javascript\" src=\"" + request.getContextPath() + "/js/modernizr-1.5.min.js\"></script>\n"
                + "    </head>\n"
                + "\n"
                + "    <body>\n"
                + "        <div id=\"main\">\n"
                + "            <header>\n"
                + "                <div id=\"logo\">\n"
                + "                    <div id=\"logo_text\">\n"
                + "                        <!-- class=\"logo_colour\", allows you to change the colour of the text -->\n"
                + "                        <h1><a href=\"" + request.getContextPath() + "/index.jsp\">APARTMENT | <span class=\"logo_colour\"> balance manager</span></a></h1>\n"
                + "                        <h2>Sistema de administraci&oacute;n de cuentas de apartamento.</h2>\n"
                + "                    </div>\n"
                + "                </div>\n"
                + "                <nav>\n"
                + "                    <ul class=\"sf-menu\" id=\"nav\">\n"
                + "\n"
                + "                    </ul>\n"
                + "                </nav>\n"
                + "            </header>\n"
                + "            <div id=\"site_content\">\n"
                + "                <ul id=\"images\">\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/1.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_one\" /></li>\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/2.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_two\" /></li>\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/3.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_three\" /></li>\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/4.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_four\" /></li>\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/5.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_five\" /></li>\n"
                + "                    <li><img src=\"" + request.getContextPath() + "/images/6.jpg\" width=\"600\" height=\"300\" alt=\"gallery_buildings_six\" /></li>\n"
                + "                </ul>\n"
                + "                <div id=\"sidebar_container\">\n"
                + "                    <div class=\"sidebar\">\n"
                + "                        <h3>NOTICIAS</h3>\n"
                + "\n"
                + "                        <h4>Registro de Servicios extras.</h4>\n"
                + "                        <h5>1 de julio del 2014</h5>\n"
                + "                        <p>Ahora pudes registrar los servicios extras como vigilancia, aseo, lavado de autos.<br /><a href=\"#\">Read more</a></p>\n"
                + "\n"
                + "                    </div>\n"
                + "                </div>\n"
                + "                <div class=\"content\">\n"
                + "");
            if (email != null) {
                out.println("<h3>email : " + email + "</h3>");
                if (usuario != null) {
                    out.println("<h3>usuario.nombre: " + usuario.getNombre() + "</h3>");
                    out.println("<h3>usuario.habilitado : " + usuario.getHabilitado() + "</h3>");
                    if (usuario.getHabilitado() == 0) {
                        usuario.setHabilitado(1);
                        try {
                            UsuarioDAOFactory.getUsuarioDAO().update(usuario);
                            resultado = "<h2>OK, se confirmo satistactoriamente</h2>";
                        } catch (EntityAlreadyExsist ex) {
                            resultado = "<h3>Error :" + ex.getMessage() + "</h3>";
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
            out.println("<a href=\"" + request.getContextPath() + "/pages/home.jsp\">ACCESO</a>");
            out.print("                </div>\n"
                + "            </div>\n"
                + "            <footer>\n"
                + "                <p>Copyright &copy; <a id=\"bottomLoginPage\">Sistemas NONEX</a> | <a href=\"http://www.sistemasnonex.com/\">Tienda Nonex</a> | <a href=\"http://www.seguridad-nonex.com/\">Seguridad y control de acceso</a></p>\n"
                + "            </footer>\n"
                + "        </div>\n"
                + "        <p>&nbsp;</p>\n"
                + "        <!-- javascript at the bottom for fast page loading -->\n"
                + "        <script type=\"text/javascript\" src=\"" + request.getContextPath() + "/js/jquery.js\"></script>\n"
                + "        <script type=\"text/javascript\" src=\"" + request.getContextPath() + "/js/jquery.easing-sooper.js\"></script>\n"
                + "        <script type=\"text/javascript\" src=\"" + request.getContextPath() + "/js/jquery.sooperfish.js\"></script>\n"
                + "        <script type=\"text/javascript\" src=\"" + request.getContextPath() + "/js/jquery.kwicks-1.5.1.js\"></script>\n"
                + "        <script type=\"text/javascript\">\n"
                + "            $(document).ready(function() {\n"
                + "                $('#images').kwicks({\n"
                + "                    max: 600,\n"
                + "                    spacing: 2\n"
                + "                });\n"
                + "                $('ul.sf-menu').sooperfish();\n"
                + "                $('html, body').animate({\n"
                + "                    scrollTop: $(\"#bottomLoginPage\").offset().top\n"
                + "                }, 2000);"
                + "            });\n"
                + "        </script>\n"
                + "    </body>\n"
                + "</html>\n"
                + "");
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
