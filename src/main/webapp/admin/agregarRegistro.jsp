<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dao.*"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.Timestamp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="Messages" />
<!DOCTYPE HTML>
<html>

    <head>
        <title>A.B.M. - Inicio</title>
        <meta name="description"  content="website description" />
        <meta name="keywords"     content="website keywords, website keywords" />
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
        <!-- modernizr enables HTML5 elements and feature detects -->
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-1.5.min.js"></script>
    </head>

    <body>
        <div id="main">
            <header>
                <div id="logo">
                    <div id="logo_text">
                        <!-- class="logo_colour", allows you to change the colour of the text -->
                        <h1><a href="<%=request.getContextPath()%>/index.jsp">APARTMENT | <span class="logo_colour"> balance manager</span></a></h1>
                        <h2>Sistema de administraci&oacute;n de cuentas de apartamento.</h2>
                    </div>
                </div>
                <nav>
                    <ul class="sf-menu" id="nav">                        
                        <li class="selected"><a href="<%=request.getContextPath()%>/salir.jsp">Salir</a></li>
                    </ul>
                </nav>
            </header>
            <div id="site_content">
                <img src="<%=request.getContextPath()%>/images/header_layer1.png"/>

                <div class="contentInHome">
                    <h1>Agregar registros</h1>
                    <form action="<%=request.getContextPath()%>/admin/agregarRegistro.jsp" method="POST">

                        <%
                            String usuarioRegistro = null;
                            Usuario usuario = null;
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                            String email = request.getParameter("email");
                            if (email != null) {
                                usuario = UsuarioDAOFactory.getUsuarioDAO().get(email);
                            }
                            String concepto = request.getParameter("concepto");
                            if (concepto == null) {
                                concepto = "";
                            }
                            String importe = request.getParameter("importe");
                            if (importe == null) {
                                importe = "0.00";
                            }
                            String fecha = request.getParameter("fecha");
                            if (fecha == null) {
                                fecha = sdf.format(new Date());
                            }
                            List<Concepto> conceptoList = ConceptoDAOFactory.getConceptoDAO().getAllConcepto();
                            String actionType = request.getParameter("actionType");
                            String validationError = null;
                            if (actionType != null && actionType.equals("ACEPTAR")) {
                                try {
                                    System.out.println("==>>ACEPTAR: email=" + email);
                                    Registro registroNuevo = new Registro();
                                    registroNuevo.setConcepto(concepto);
                                    registroNuevo.setEmail(email);
                                    try {
                                        registroNuevo.setFecha(new Timestamp(sdf.parse(fecha).getTime()));
                                    } catch (ParseException pe) {
                                        throw new Exception("La fecha no es correcta");
                                    }
                                    try {
                                        registroNuevo.setImporte(Double.parseDouble(importe));
                                    } catch (NumberFormatException nfe) {
                                        throw new Exception("El importe no es correcto");
                                    }
                                    try {
                                        System.out.println("==>>ACEPTAR");
                                        RegistroDAOFactory.getRegistroDAO().set(registroNuevo);
                                        response.sendRedirect("../pages/registros.jsp?verUsuarioRegistro=" + email);
                                    } catch (Exception ex) {
                                        throw new Exception("No se pudo insertar :" + ex.getMessage());
                                    }

                                } catch (Exception e) {
                                    validationError = "Error en los datos: " + e.getMessage();
                                }
                            } else if (actionType != null && actionType.equals("CANCELAR")) {
                                System.out.println("==>>CANCELAR");
                                response.sendRedirect("../pages/registros.jsp?verUsuarioRegistro=" + email);
                            }
                            if (validationError != null) {
                        %>
                        <%=validationError%>
                        <%
                            }
                        %>
                        <h1>Agregar registro a <%=usuario.getNombre()%></h1>
                        <input type="hidden" name="email"                            value="<%=email%>"/>
                        <table style="border: 1px solid black;">
                            <tr>
                                <td>CONCEPTO :</td>
                                <td>
                                    <input type="text"   name="concepto" size="25" maxlength="255" value="<%=concepto%>"/>
                                    <select id="concepto">
                                        <%
                                        for(Concepto c: conceptoList){
                                        %>
                                        <option id="<%=c.getId()%>"><%=c.getDescripcion()%> [<%=c.getFactorCargoAbono()%>]</option>
                                        <%
                                        }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>IMPORTE :</td>
                                <td><input type="text" name="importe" size="7" maxlength="10" value="<%=importe%>"/></td>
                            </tr>
                            <tr>
                                <td>FECHA (AAAA-MM-DD):</td>
                                <td><input type="text" name="fecha" size="10" maxlength="12" value="<%=fecha%>"/></td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><input type="submit" name="actionType" value="ACEPTAR"/></td>
                                <td style="text-align: left" ><input type="submit" name="actionType" value="CANCELAR"/></td>
                            </tr>

                            </tr>
                        </table>
                    </form>

                </div>
            </div>
            <footer>
                <p>Copyright &copy; <a href="http://www.sistemasnonex.com/oferta-productos">Sistemas NONEX</a> | <a href="http://www.sistemasnonex.com/">Tienda Nonex</a> | <a href="http://www.seguridad-nonex.com/">Seguridad y control de acceso</a></p>
            </footer>
        </div>
        <p>&nbsp;</p>
        <!-- javascript at the bottom for fast page loading -->
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easing-sooper.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.sooperfish.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.kwicks-1.5.1.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#images').kwicks({
                    max: 600,
                    spacing: 2
                });
                $('ul.sf-menu').sooperfish();
            });
        </script>
    </body>
</html>
