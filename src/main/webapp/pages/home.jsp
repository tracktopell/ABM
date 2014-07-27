<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dao.*"%>
<%@page import="com.tracktopell.apartmentbalancemanager.model.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
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
<%
    DecimalFormat df = new DecimalFormat("$ ###,###,##0.00");
    Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
    if (usuarioEnSesion == null) {
        usuarioEnSesion = UsuarioDAOFactory.getUsuarioDAO().get(request.getUserPrincipal().getName());
        session.setAttribute("usuarioEnSesion", usuarioEnSesion);
    }
    %>
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
                        <li class="selected"><a href="<%=request.getContextPath()%>/admin/agregarConcepto.jsp" >+Concepto</a></li>
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
                    <form action="<%=request.getContextPath()%>/pages/registros.jsp">

                        <h1>BIENVENIDO <%=usuarioEnSesion.getNombre().toUpperCase()%></h1>		
<%
        if (usuarioEnSesion.getHabilitado () != 0) {

            if (request.isUserInRole("ADMINISTRADOR")) {
                List<Usuario> usuarioList = UsuarioDAOFactory.getUsuarioDAO().getAllUsuario();
%>

                        <h2>INQUILINOS:</h2>

                        <table align="center" width="800px" border="1">	
                            <tr>
                                <td width="300px" align="center">NOMBRE</td>
                                <td width="200px" align="center">EMAIL</td>
                                <td width="100px" align="center">VERIFICADO</td>					
                                <td width="100px" align="center">DEPTO.</td>
                                <td width="100px" align="center">SALDO</td>
                            </tr>

<%
                double saldoTotal = 0.0;
                for (Usuario u : usuarioList) {
                    saldoTotal += u.getSaldo();
%>

                            <tr>
                                <td><a href="registros.jsp?verUsuarioRegistro=<%=u.getEmail()%>"> <%=u.getNombre()%></a></td>
                                <td align="right"><%=u.getEmail()%></td>
                                <td align="right"><%=u.getHabilitado() == 0 ? "NO" : "SI"%></td>
                                <td align="right"><%=u.getDepartamento()%></td>
                                <td align="right"><%=df.format(u.getSaldo())%></td>
                            </tr>
<%
                }
%>
                            <tr>    
                                <td align="right" colspan="5"><h4><%=df.format(saldoTotal)%></h4></td>
                            </tr>

                        </table>
<%
            } else if (request.isUserInRole("INQUILINO")) {
                System.out.println("->home redirect: registros.jsp");
                response.sendRedirect("registros.jsp");
            }
        } else {
%>
                        <h2>USUARIO NO VERIFICADO</h2>
<%
    }
%>		
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
