<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>SALIR</title>
    </head>
    <%
        session.invalidate();
        response.sendRedirect(request.getContextPath()+"/");
    %>
    <body>	
        <br/>
        <br/>
        <br/>

        <h3>
            <a href="<%=request.getContextPath()%>/">inicio</a>
        </h3>

        <br/>

    </body>	
</html>
