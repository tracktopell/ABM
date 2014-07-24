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
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        String verUsuarioRegistro = null;
        Usuario usuarioSeleccionado = null;

        verUsuarioRegistro = (String) request.getParameter("verUsuarioRegistro");
        if (verUsuarioRegistro != null) {
            usuarioSeleccionado = UsuarioDAOFactory.getUsuarioDAO().get(verUsuarioRegistro);
        }
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
                        <li class="selected"><a href="<%=request.getContextPath()%>/admin/agregarRegistro.jsp?email=<%=usuarioSeleccionado.getEmail()%>" >+Registro</a></li>
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
                    <h1>Registros</h1>
                    <%
                        double saldoFinal = 0.0;
                        List<Registro> registroList = null;
                        DecimalFormat df = new DecimalFormat("$ ###,###,##0.00");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

                        System.out.println("-> verUsuarioRegistro:" + verUsuarioRegistro);

                        if (verUsuarioRegistro != null) {
                            usuarioSeleccionado = UsuarioDAOFactory.getUsuarioDAO().get(verUsuarioRegistro);
                            registroList = RegistroDAOFactory.getRegistroDAO().getAllRegistroBy(verUsuarioRegistro);
                    %>
                    <h3>REGISTROS DE <%=usuarioSeleccionado.getNombre()%> (<%=usuarioSeleccionado.getEmail()%>)</h3>
                    <%
                    } else {
                        usuarioSeleccionado = UsuarioDAOFactory.getUsuarioDAO().get(request.getUserPrincipal().getName());
                        registroList = RegistroDAOFactory.getRegistroDAO().getAllRegistroBy(usuarioSeleccionado.getEmail());
                    %>
                    <h2>BIENVENIDO : <%=usuarioSeleccionado.getNombre()%></h2>
                    <%
                        }
                        System.out.println("-> registroList:" + registroList);
                    %>

                    <%
                        if (request.isUserInRole("ADMINISTRADOR")) {
                    %>

                    <%
                    %>

                    <table border="1" align="center">
                        <tr>
                            <td  align="center">FECHA</td>
                            <td  width="250px" align="center">CONCEPTO</td>
                            <td  align="center">CARGO</td>
                            <td  align="center">ABONO</td>
                        </tr>
                        <%                            for (Registro r : registroList) {
                                saldoFinal += r.getImporte();

                        %>
                        <tr>
                            <td width="150px" align="right"><%=sdf.format(r.getFecha())%></td>
                            <td width="300px" ><%=r.getConcepto()%></td>
                            <td width="120px" align="right"><%=r.getImporte() >= 0 ? df.format(r.getImporte()) : "&nbsp;"%></td>
                            <td width="120px" align="right"><%=r.getImporte() < 0 ? df.format(r.getImporte() * -1) : "&nbsp;"%></td>                            
                        </tr>
                        <%
                                }
                            }
                        %>	
                        <tr>
                            <td colspan="4" align="right">SALDO TOTAL :</td>
                            <td align="right"><%=df.format(saldoFinal)%></td>
                        </tr>
                    </table>

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
