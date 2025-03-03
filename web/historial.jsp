<%-- 
    Document   : orders
    Created on : 17/04/2021, 04:33:53 AM
    Author     : droperdev
--%>
<%@page import="model.pedido.PedidoDAOImpl"%>
<%@page import="dto.PedidoDTO"%>
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
                    <li class="nav-item">
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
                        <a class="nav-link " href="Main?action=pedidos">
                            <img class="icon" src="assets/order.svg">
                            <span clasS="text-wrap">Pedidos</span>
                        </a>
                    </li>
                    <li class="nav-item show">
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
                <span class="title">Historial de Pedidos</span>
            </div>
        </div>
        <div class="content">
             <% int[] ids = {3, 4}; %>
            <% List<PedidoDTO> pedidos = new PedidoDAOImpl().obtenerPedidos(ids); %>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Cliente</th>
                            <th>Dirección</th>
                            <th>Método de Pago</th>
                            <th>Comprobante</th>
                            <th>Tipo de pedido </th>
                            <th>Repartidor</th>
                            <th>Total</th>
                            <th class="text-center">Estado</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%! PedidoDTO pedido;%>
                        <% for (int i = 0; i < pedidos.size(); i++) { %>
                        <% pedido = pedidos.get(i);%>
                        <tr>
                            <td><%=pedido.getId()%></td>
                            <td><%=pedido.getCliente().getNombre()%></td>
                            <td>
                                <%=pedido.getDireccion().getDireccion()%> <br>
                                <%=pedido.getDireccion().getReferencia()%>
                            </td>
                            <td><%=pedido.getMetodoPago().getNombre()%></td>
                            <td><%=pedido.getComprobante().getNombre()%></td>
                            <td><%=pedido.getTipoPedido().getNombre()%></td>
                            <% if (pedido.getUsuario().getNombre() != null) {%>
                            <td class="font-weight-bold"><%=pedido.getUsuario().getNombre()+ " " + pedido.getUsuario().getApellido()%></td>
                            <% } else {%>
                            <td class="font-weight-bold">-</td>
                            <%}%>
                            <td class="font-weight-bold text-success">S/&nbsp;<%=String.format("%.2f", pedido.getTotal())%></td>
                            <td class="text-center"><span class="<%=pedido.getEstado().getNombreClase()%>"><%=pedido.getEstado().getNombre()%></span></td>
                            <td class="text-center">
                                <div class="dropdown">
                                    <a class="btn fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">                                   
                                        <button class="dropdown-item" onclick="abrirDetallePedido('<%=pedido.getId()%>');"><i class="fa fa-file-text-o"></i>&nbsp;&nbsp;&nbsp;Ver pedido</button>
                                        <button class="dropdown-item" onclick="abrirMapa('<%=pedido.getId()%>');" ><i class="fa fa-map"></i>&nbsp;&nbsp;&nbsp;Ver mapa</button>                                    
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
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