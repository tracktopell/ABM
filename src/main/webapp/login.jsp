<!DOCTYPE HTML>
<html>

    <head>
        <title>A.B.M. - login</title>
        <meta name="description"  content="website description" />
        <meta name="keywords"     content="website keywords, website keywords" />
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
        <!-- modernizr enables HTML5 elements and feature detects -->
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-1.5.min.js"></script>
        <style>
            .tableLogin{
                width: 500px;
                left: 600px;
                border: solid;

            }
            .centerAlign{
                margin: auto;
                width: 500px;
                text-align: center;                
            }
            .leftAlign{
                text-align: left;                
            }
            .rightAlign{
                text-align: right;                
            }
            .errorLogin{
                color: red;
            }
        </style>
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

                    </ul>
                </nav>
            </header>
            <div id="site_content">
                <ul id="images">
                    <li><img src="<%=request.getContextPath()%>/images/1.jpg" width="600" height="300" alt="gallery_buildings_one" /></li>
                    <li><img src="<%=request.getContextPath()%>/images/2.jpg" width="600" height="300" alt="gallery_buildings_two" /></li>
                    <li><img src="<%=request.getContextPath()%>/images/3.jpg" width="600" height="300" alt="gallery_buildings_three" /></li>
                    <li><img src="<%=request.getContextPath()%>/images/4.jpg" width="600" height="300" alt="gallery_buildings_four" /></li>
                    <li><img src="<%=request.getContextPath()%>/images/5.jpg" width="600" height="300" alt="gallery_buildings_five" /></li>
                    <li><img src="<%=request.getContextPath()%>/images/6.jpg" width="600" height="300" alt="gallery_buildings_six" /></li>
                </ul>
                <!--
                <div id="sidebar_container">
                    <div class="sidebar">
                        <h3>NOTICIAS</h3>

                        <h4>Registro de Servicios extras.</h4>
                        <h5>1 de julio del 2014</h5>
                        <p>Ahora pudes registrar los servicios extras como vigilancia, aseo, lavado de autos.<br /><a href="#">Read more</a></p>

                    </div>
                </div>
                -->
                <div class="content">
                    <h1>inicie sesi&oacute;n para continuar</h1>       
                    <form action="j_security_check" method="post" id="loginForm" >
                        <div class="centerAlign"> 
                            <table border="0" align="center">
                                <tr>
                                    <td width="100px" class="rightAlign"><h3>email de usuario :</h3></td>
                                    <td width="100px" class="leftAlign"><h3><input type="text" name="j_username" id="j_username" value="" size="19"/></h3></td>
                                </tr>
                                <tr>
                                    <td width="100px" class="rightAlign"><h3>contrase&ntilde;a :</h3></td>
                                    <td width="100px" class="leftAlign"><h3><input type="password" name="j_password" id="j_password" value="" size="10"/></h3></td>
                                </tr>
                                <tr>
                                    <td class="centerAlign" colspan="2"><input type="submit" value="ENVIAR"/></td>
                                </tr>
                            </table>

                            <%
                                if (request.getParameter("error") != null) {
                            %>									

                            <div>
                                <h4 class="errorLogin">Error en email o contrase&ntilde;a</h4>                                
                            </div>
                            <%
                            } else {
                            %>
                            <br/>
                            <br/>
                            <%    }
                            %>									

                        </div>


                    </form>
                </div>
            </div>
            <footer>
                <!--
                <p>Copyright &copy; <a id="bottomLoginPage">Sistemas NONEX</a> | <a href="http://www.sistemasnonex.com/">Tienda Nonex</a> | <a href="http://www.seguridad-nonex.com/">Seguridad y control de acceso</a></p>
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
                $('#j_username').focus();
                $('html, body').animate({
                    scrollTop: $("#j_username").offset().top
                }, 2000);
            });
        </script>
    </body>
</html>
