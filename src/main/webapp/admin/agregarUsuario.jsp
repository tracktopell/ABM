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
                        <li class="selected"><a href="<%=request.getContextPath()%>/pages/home.jsp" >Inicio</a></li>
                        <li class="selected"><a href="<%=request.getContextPath()%>/admin/agregarConcepto.jsp" >+Concepto</a></li>
                        <li class="unselected"><a href="#" >+Usuario</a></li>
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
    String password = request.getParameter("password");
    
    String contextPath = request.getScheme()
        + "://"
        + request.getServerName()
        + ":"
        + request.getServerPort()
        + request.getContextPath();
    String admin    = null;
    String inquilino= null;
    String root     = null;

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
    System.out.println("->agregarUsuario.jsp: nombre="+nombre);
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
            admin       = request.getParameter("admin");            
            inquilino   = request.getParameter("inquilino");
            root        = request.getParameter("root");

            Usuario usuarioNuevo = new Usuario();
            usuarioNuevo.setNombre(nombre);
            usuarioNuevo.setEmail(email);
            usuarioNuevo.setDepartamento(departamento);
            usuarioNuevo.setHabilitado(0);
            usuarioNuevo.setSaldo(0.0);

            if (nombre.trim().length() <= 5) {
                throw new Exception("Error en el nombre: debe ser > 5 caracteres");
            }

            if (email.trim().length() <= 5) {
                throw new Exception("Error en el email: debe ser > 5 caracteres");
            }
            Pattern p = Pattern.compile("^[^@]+@[^@]+$", Pattern.CASE_INSENSITIVE);
            Matcher m = p.matcher(email);
            if (!m.find()) {
                throw new Exception("Error en el email: formato incorrecto");
            }

            if (password.trim().length() <= 5) {
                throw new Exception("Error en el password: debe ser >= 6 caracteres");
            }

            if (!password.equals(passwordVerif)) {
                throw new Exception("Error en el password: no coinciden con la verificaci&oacute;n");
            } else {
                usuarioNuevo.setPassword(password);
            }

            if (departamento.trim().length() == 0 || departamento.trim().length() > 5) {
                throw new Exception("Error en el departamento: no puede ser vacio, y hasta 5 caracteres");
            }

            try {                
                usuarioNuevo.setHabilitado(1);
                usuarioNuevo.setRoles(new ArrayList<RolUsuario>());
                if(root != null){
                    usuarioNuevo.getRoles().add(new RolUsuario("ROOT", usuarioNuevo.getEmail()));
                }
                if(admin != null){
                    usuarioNuevo.getRoles().add(new RolUsuario("ADMINISTRADOR", usuarioNuevo.getEmail()));
                }
                if(inquilino != null){
                    usuarioNuevo.getRoles().add(new RolUsuario("INQUILINO", usuarioNuevo.getEmail()));
                }
                System.out.println("==>>ACEPTAR: contextPath=" + contextPath+", admin="+admin);
                
                UsuarioDAOFactory.getUsuarioDAO().set(usuarioNuevo);
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
                        <table border="1"  width="400">
                            <tr>
                                <td>email:</td>
                                <td><input type="text" name="email" size="20" maxlength="32" value="<%=email%>"/></td>
                            </tr>
<%
    if(request.isUserInRole("ROOT")){                
%>                        
                            <tr>
                                <td>super-admnistrador:</td>
                                <td><input type="checkbox" name="root" value="1" <%=root!=null?"checked":""%>/></td>
                            </tr>
<%
    }
%>
                            
                            <tr>
                                <td>admnistrador:</td>
                                <td><input type="checkbox" name="admin" value="1" <%=admin!=null?"checked":""%>/></td>
                            </tr>
                            <tr>
                                <td>inquilino:</td>
                                <td><input type="checkbox" name="inquilino" value="1" <%=inquilino!=null?"checked":""%>/></td>
                            </tr>
                            <tr>
                                <td>nombre :</td>
                                <td><input type="text"   name="nombre" id="nombre" size="30" maxlength="255" value="<%=nombre%>"/></td>
                            </tr>
                            <tr>
                                <td>password :</td>
                                <td><input type="password"   name="password" id="password" size="10" maxlength="255" value="<%=password%>"/></td>
                            </tr>
                            <tr>
                                <td>verificar password :</td>
                                <td><input type="password"   name="passwordVerif" id="passwordVerif" size="10" maxlength="255" value="<%=passwordVerif%>"/></td>
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
                $('#nombre').val("");
                $('#password').val("");
                $('#passwordVerif').val("");
            });
        </script>
    </body>
</html>
