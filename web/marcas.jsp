<%-- 
    Document   : orders
    Created on : 17/04/2021, 04:33:53 AM
    Author     : droperdev
--%>
<%@page import="model.marca.Marca"%>
<%@page import="model.marca.MarcaDAOImpl"%>
<%@page import="java.util.List"%>
<%@page import="dto.UsuarioDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
    if (usuario != null) {
%>
<html lang="es">
    <head>
        <meta charset="utf-8" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema de Gas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/menu.css" >
        <link rel="stylesheet" href="css/header.css" >
        <link rel="stylesheet" href="css/common.css" >
        <link rel="stylesheet" href="css/main.css" >
        <link rel="stylesheet" href="css/marcas.css" >
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-inner">
                <div class="sidebar-user">
                    <div class="image">
                        <img class="image-circle" 
                             src="<%= usuario.getFotoPerfil()%>"
                             alt="icono de perfil">
                    </div>
                    <div class="info">
                        <span class="user"><%= usuario.getFullName()%></span><br>
                        <span class="role"><%= usuario.getRol().getNombre()%></span>
                    </div>
                </div>
                <hr>
                <ul class="sidebar-menu">
                    <li class="nav-item show">
                        <a class="nav-link" href="Main?action=marcas">
                            <img class="icon" src="assets/order.svg">
                            <span clasS="text-wrap">Marcas</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Main?action=productos">
                            <img class="icon" src="assets/order.svg">
                            <span clasS="text-wrap">Productos</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Main?action=pedidos">
                            <img class="icon" src="assets/order.svg">
                            <span clasS="text-wrap">Pedidos</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Main?action=historial">
                            <img class="icon" src="assets/order.svg">
                            <span clasS="text-wrap">Historial</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Main?action=logout">
                            <img class="icon" src="assets/logout.svg">
                            <span clasS="text-wrap">Cerrar sesión</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="header">
            <div class="content-header">
                <span class="title">Marcas</span>
                <button type="button" class="btn btn-primary" onclick="registrarMarca();">Agregar Marca</button>
            </div>
        </div>
        <div class="content">
            <div class="marcas">
                <% List<Marca> marcas = new MarcaDAOImpl().obtenerMarcas(); %>
                <%! Marca marca;%>
                <% for (int i = 0; i < marcas.size(); i++) { %>
                <% marca = marcas.get(i);%>
                <div class="card marca">
                    <div class="dropdown">
                        <a class="btn fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <button class="dropdown-item" onclick="actualizarMarca('<%=marca.getId()%>');" ><i class="fa fa-pencil"></i>&nbsp;&nbsp;&nbsp;Actualizar marca</button>
                            <button class="dropdown-item" onclick="eliminarMarca('<%=marca.getId()%>');" ><i class="fa fa-trash"></i>&nbsp;&nbsp;&nbsp;Eliminar marca</button>
                        </div>
                    </div>
                    <img src="<%=marca.getLogo()%>" />
                    <%=marca.getNombre()%>
                </div>
                <% }%>
            </div>
        </div>
        <div class="modal fade" id="MyModal" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="MyModalLabel"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="content-modal">

                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="scripts/main.js"></script>
    </body>
</html>
<%
    } else {
        response.sendRedirect("index.jsp");
    }
%>