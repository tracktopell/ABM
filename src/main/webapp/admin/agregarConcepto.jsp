<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dao.*"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dto.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.regex.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="Messages" />
<!DOCTYPE HTML>
<html>

    <head>
        <title>A.B.M. - AGREGAR CONCEPTO</title>
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
                        <%
                        if (request.isUserInRole("ADMINISTRADOR")) {                                
                        %>
                        <li class="selected"><a href="<%=request.getContextPath()%>/pages/home.jsp" >Inicio</a></li>
                        <li class="unselected"><a href="#" >+Concepto</a></li>
                        <li class="selected"><a href="<%=request.getContextPath()%>/admin/agregarUsuario.jsp" >+Usuario</a></li>
                        <%
                        }
                        %>
                        <li class="selected"><a href="<%=request.getContextPath()%>/salir.jsp">Salir</a></li>
                    </ul>
                </nav>
            </header>
            <div id="site_content">
                <img src="<%=request.getContextPath()%>/images/header_layer1.png"/>

                <div class="contentInHome">
                    <h1>Agregar concepto.</h1>
                    <form action="<%=request.getContextPath()%>/admin/agregarConcepto.jsp" method="POST">

                        <%
                            List<Concepto> conceptoList = ConceptoDAOFactory.getConceptoDAO().getAllConcepto();

                            String afectacion = request.getParameter("password");
                            int afectacionValue = -1;
                            if (afectacion == null) {
                                afectacion = "-1";
                            }
                            afectacionValue = Integer.valueOf(afectacion);

                            String concepto = request.getParameter("concepto");
                            if (concepto == null) {
                                concepto = "";
                            }

                            String actionType = request.getParameter("actionType");
                            String validationError = null;
                            if (actionType != null && actionType.equals("ACEPTAR")) {
                                try {
                                    Concepto conceptoNuevo = new Concepto();
                                    System.out.println("==>>ACEPTAR: concepto:" + concepto + ", afectacion:" + afectacion + ", value=" + afectacionValue);
                                    conceptoNuevo.setDescripcion(concepto);
                                    conceptoNuevo.setFactorCargoAbono(afectacionValue);

                                    ConceptoDAOFactory.getConceptoDAO().set(conceptoNuevo);
                                    response.sendRedirect("../pages/home.jsp");
                                } catch (EntityAlreadyExsist e1) {
                                    validationError = "Ya existe un concepto con este nombre.";
                                } catch (Exception e2) {
                                    validationError = "Error en los datos: " + e2.getMessage();
                                }
                            } else if (actionType != null && actionType.equals("CANCELAR")) {
                                System.out.println("==>>CANCELAR");
                                response.sendRedirect("../pages/home.jsp");
                            }
                            if (validationError != null) {
                        %>
                        <%=validationError%>
                        <%
                            }
                        %>


                        <table style="border: 0px none;">
                            <tr>
                                <td style="text-align: center">

                                    <table style="border: 1px solid black;">
                                        <tr>
                                            <td>Nuevo concepto:</td>
                                            <td><input type="text" name="concepto" size="35" maxlength="128" value="<%=concepto%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>Afectaci&oacute;n :</td>
                                            <td>
                                                <input type="radio" name="afectacion" value="-1" <%=afectacionValue == -1 ? "checked" : ""%>>CARGO</input>
                                                <input type="radio" name="afectacion" value="1"  <%=afectacionValue == 1 ? "checked" : ""%>>ABONO</input>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center" colspan="2">
                                                <input type="submit" name="actionType" value="ACEPTAR"/>
                                                <input type="submit" name="actionType" value="CANCELAR"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                </td><td>
                                <td style="text-align: center">
                                    <select size="4">
                                        <%
                                            for (Concepto c : conceptoList) {
                                        %>
                                        <option value="<%=c.getId()%>"><%=c.getDescripcion()%> [<%=c.getFactorCargoAbono() < 0 ? "ABONO" : "CARGO"%>]</opoption>
                                            <%
                                                }
                                            %>
                                    </select>

                                </td>
                            </tr>
                        </table>
                    </form>

                </div>
            </div>
            <footer>
                <!--
                <p>Copyright &copy; <a href="http://www.sistemasnonex.com/oferta-productos">Sistemas NONEX</a> | <a href="http://www.sistemasnonex.com/">Tienda Nonex</a> | <a href="http://www.seguridad-nonex.com/">Seguridad y control de acceso</a></p>
                -->
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
