<!DOCTYPE HTML>
<html>

    <head>
        <title>A.B.M.</title>
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
                        <li class="selected"><a href="<%=request.getContextPath()%>/pages/home.jsp">Entrar</a></li>
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
                    <h1>¡ Bienvenido !</h1>
                    <p>Este sistema te ayudara a tener un control de las cuentas de registro de conceptos de cargo/abono de los inquilinos de tu edificio.</p>
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
