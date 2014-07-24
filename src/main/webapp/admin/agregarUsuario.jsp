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
        <title>A.B.M. - AGREGAR USUARIO</title>
        <meta name="description"  content="website description" />
        <meta name="keywords"     content="website keywords, website keywords" />
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
        <!-- modernizr enables HTML5 elements and feature detects -->
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-1.5.min.js"></script>
    </head>
    <%
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
                        <li class="unselected"><a href="#" >+Usuario</a></li>
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
                    <h1>Agregar usuario</h1>
                    <form action="<%=request.getContextPath()%>/admin/agregarUsuario.jsp" method="POST">

                        <%
                            String usuarioUsuario = null;
                            Usuario usuario = null;
                            String password = request.getParameter("password");
                            String contextPath = request.getScheme()
                                + "://"
                                + request.getServerName()
                                + ":"
                                + request.getServerPort()
                                + request.getContextPath();

                            if (password == null) {
                                password = "";
                            }
                            String passwordVerif = request.getParameter("passwordVerif");
                            if (passwordVerif == null) {
                                passwordVerif = "";
                            }
                            String email = request.getParameter("email");
                            if (email == null) {
                                email = "";
                            }
                            String nombre = request.getParameter("nombre");
                            if (nombre == null) {
                                nombre = "";
                            }
                            String departamento = request.getParameter("departamento");
                            if (departamento == null) {
                                departamento = "";
                            }

                            String actionType = request.getParameter("actionType");
                            String validationError = null;
                            if (actionType != null && actionType.equals("ACEPTAR")) {
                                try {

                                    Usuario UsuarioNuevo = new Usuario();
                                    UsuarioNuevo.setNombre(nombre);
                                    UsuarioNuevo.setEmail(email);
                                    UsuarioNuevo.setDepartamento(departamento);
                                    UsuarioNuevo.setHabilitado(0);
                                    UsuarioNuevo.setSaldo(0.0);

                                    if (nombre.trim().length() <= 5) {
                                        throw new Exception("Error en el nombre(" + nombre + "), debe ser > 5 caracteres");
                                    }

                                    if (email.trim().length() <= 5) {
                                        throw new Exception("Error en el nombre, debe ser > 5 caracteres");
                                    }
                                    Pattern p = Pattern.compile("^[^@]+@[^@]+$", Pattern.CASE_INSENSITIVE);
                                    Matcher m = p.matcher(email);
                                    if (!m.find()) {
                                        throw new Exception("Error en el email, formato incorrecto");
                                    }

                                    if (password.trim().length() <= 5) {
                                        throw new Exception("Error en el passord, debe ser >= 6 caracteres");
                                    }

                                    if (!password.equals(passwordVerif)) {
                                        throw new Exception("Error en la contraseña, no coinciden");
                                    } else {
                                        UsuarioNuevo.setPassword(password);
                                    }

                                    if (departamento.trim().length() == 0 || departamento.trim().length() > 5) {
                                        throw new Exception("Error en el departamento, no puede ser vacio, y hasta 5 caracteres");
                                    }

                                    try {
                                        UsuarioNuevo.setHabilitado(1);
                                        System.out.println("==>>ACEPTAR: contextPath=" + contextPath);
                                        UsuarioDAOFactory.getUsuarioDAO().set(UsuarioNuevo);
                                        //SendGMailSMTPMail.sendVerificationEmail(email, contextPath);
                                        response.sendRedirect("../pages/home.jsp");
                                    } catch (Exception ex) {
                                        throw new Exception("No se pudo insertar :" + ex.getMessage());
                                    }

                                } catch (Exception e) {
                                    validationError = "Error en los datos: " + e.getMessage();
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
                        <h1>Agregar Usuario</h1>
                        <table style="border: 1px solid black;">
                            <tr>
                                <td>email:</td>
                                <td><input type="text" name="email" size="15" maxlength="32" value="<%=email%>"/></td>
                            </tr>
                            <tr>
                                <td>nombre :</td>
                                <td><input type="text"   name="nombre" size="25" maxlength="255" value="<%=nombre%>"/></td>
                            </tr>
                            <tr>
                                <td>password :</td>
                                <td><input type="password"   name="password" size="25" maxlength="255" value="<%=password%>"/></td>
                            </tr>
                            <tr>
                                <td>verificar password :</td>
                                <td><input type="password"   name="passwordVerif" size="25" maxlength="255" value="<%=passwordVerif%>"/></td>
                            </tr>

                            <tr>
                                <td>departamento :</td>
                                <td><input type="text" name="departamento" size="7" maxlength="10" value="<%=departamento%>"/></td>
                            </tr>
                            <tr>
                                <td style="text-align: center" colspan="2">
                                    <input type="submit" name="actionType" value="ACEPTAR"/>
                                    <input type="submit" name="actionType" value="CANCELAR"/>
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
