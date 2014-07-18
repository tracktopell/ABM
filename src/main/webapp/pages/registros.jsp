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
 <h1>Registros</h1>
                    <%
                        if (request.isUserInRole("ADMINISTRADOR")) {
                    %>
                    <h1><a href="home.jsp">Todos Inquilinos</a></h1>
                    <%
                        }
                    %>

                    <%
                        String verUsuarioRegistro = null;
                        List<Registro> registroList = null;
                        Usuario usuarioSeleccionado = null;
                        DecimalFormat df = new DecimalFormat("$ ###,###,##0.00");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

                        verUsuarioRegistro = (String) request.getParameter("verUsuarioRegistro");

                        System.out.println("-> verUsuarioRegistro:" + verUsuarioRegistro);

                        if (verUsuarioRegistro != null) {
                            usuarioSeleccionado = UsuarioDAOFactory.getUsuarioDAO().get(verUsuarioRegistro);
                            registroList = RegistroDAOFactory.getRegistroDAO().getAllRegistroBy(verUsuarioRegistro);
                    %>
                    <h3>REGISTROS DE <%=usuarioSeleccionado.getNombre()%></h3>
                    <%
                    } else {
                        usuarioSeleccionado = UsuarioDAOFactory.getUsuarioDAO().get(request.getUserPrincipal().getName());
                        registroList = RegistroDAOFactory.getRegistroDAO().getAllRegistroBy(usuarioSeleccionado.getEmail());
                    %>
                    <h2>BIENVENIDO : <%=usuarioSeleccionado.getNombre()%></h2>
                    <h3>MIS REGISTROS</h3>
                    <%
                        }
                        System.out.println("-> registroList:" + registroList);
                    %>

                    <%
                        if (request.isUserInRole("ADMINISTRADOR")) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/agregarRegistro.jsp?email=<%=usuarioSeleccionado.getEmail()%>" >+ AGREGAR REGISTRO</a>
                    <%
                    %>

                    <table width="800px" border="1" align="center">
                        <tr>
                            <!--
                            <td >ID</td>
                            <td >EMAIL</td>
                            <td >NOMBRE</td>
                            -->
                            <td  width="250px" align="center">CONCEPTO</td>
                            <td  align="center">CARGO</td>
                            <td  align="center">ABONO</td>
                            <td  align="center">FECHA</td>
                        </tr>
                        <%
                            for (Registro r : registroList) {
                        %>
                        <tr>
                            <!--
                            <td><%=r.getId()%></td>
                            <td><%=r.getEmail()%></td>
                            <td><%=r.getNombre()%></td>
                            -->
                            <td><%=r.getConcepto()%></td>
                            <td width="120px" align="right"><%=r.getImporte() >= 0 ? df.format(r.getImporte()) : "&nbsp;"%></td>
                            <td width="120px" align="right"><%=r.getImporte() < 0 ? df.format(r.getImporte() * -1) : "&nbsp;"%></td>
                            <td width="200px" align="right"><%=sdf.format(r.getFecha())%></td>
                        </tr>
                        <%
                                }
                            }
                        %>	
                    </table>

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
