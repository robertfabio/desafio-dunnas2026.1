<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}" default="Condomínio"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --dnn-red:       #bf2329;
            --dnn-red-dark:  #8e1016;
            --dnn-red-light: #f8e6e7;
            --dnn-red-hover: #b0141a;
            --sidebar-bg:    #1a1d23;
            --sidebar-item:  #2d3139;
        }

        *, *::before, *::after { box-sizing: border-box; }
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-20px); }
            to   { opacity: 1; transform: translateX(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        .main-content .p-4 > * {
            animation: fadeUp .35s ease both;
        }
        .main-content .p-4 > *:nth-child(1) { animation-delay: .04s; }
        .main-content .p-4 > *:nth-child(2) { animation-delay: .10s; }
        .main-content .p-4 > *:nth-child(3) { animation-delay: .16s; }
        .main-content .p-4 > *:nth-child(4) { animation-delay: .22s; }

        .sidebar {
            width: 240px;
            min-height: 100vh;
            background: var(--sidebar-bg);
            flex-shrink: 0;
            animation: slideInLeft .4s ease both;
            transition: width .3s ease;
        }
        .sidebar .brand {
            font-size: 1.05rem;
            font-weight: 700;
            color: #fff;
            padding: 1.1rem 1.5rem;
            border-bottom: 1px solid var(--sidebar-item);
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .sidebar .brand-dot {
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--dnn-red);
            flex-shrink: 0;
        }
        .sidebar .nav-link {
            color: #adb5bd;
            border-radius: 7px;
            margin: 1px 8px;
            padding: .48rem 1rem;
            transition: background .18s ease, color .18s ease, padding-left .18s ease;
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .sidebar .nav-link:hover {
            background: var(--sidebar-item);
            color: #fff;
            padding-left: 1.25rem;
        }
        .sidebar .nav-link.active {
            background: var(--dnn-red);
            color: #fff;
        }
        .sidebar .nav-link.active:hover {
            background: var(--dnn-red-dark);
            padding-left: 1rem;
        }
        .sidebar .nav-section {
            font-size: .68rem;
            color: #6c757d;
            padding: .7rem 1.5rem .2rem;
            text-transform: uppercase;
            letter-spacing: .09em;
        }

        .main-content { flex: 1; overflow-y: auto; min-height: 100vh; }
        .topbar {
            background: #fff;
            border-bottom: 1px solid #e9ecef;
            padding: .7rem 1.5rem;
            animation: fadeIn .3s ease both;
        }

        .card {
            transition: box-shadow .22s ease, transform .22s ease;
        }
        .card:hover {
            box-shadow: 0 6px 24px rgba(0,0,0,.10) !important;
            transform: translateY(-1px);
        }

        .table tbody tr {
            transition: background .15s ease;
        }

        .btn { transition: background .18s ease, border-color .18s ease, color .18s ease, box-shadow .18s ease, transform .12s ease; }
        .btn:active { transform: scale(.97); }

        .btn-primary {
            background: var(--dnn-red);
            border-color: var(--dnn-red);
        }
        .btn-primary:hover, .btn-primary:focus {
            background: var(--dnn-red-dark);
            border-color: var(--dnn-red-dark);
            box-shadow: 0 4px 12px rgba(191,35,41,.35);
        }
        .btn-outline-primary {
            color: var(--dnn-red);
            border-color: var(--dnn-red);
        }
        .btn-outline-primary:hover {
            background: var(--dnn-red);
            border-color: var(--dnn-red);
        }
        .btn-light:hover {
            color: #fff;
            background-color: var(--dnn-red);
            border-color: var(--dnn-red);
        }

        a { transition: color .15s ease; }
        a:hover { color: var(--dnn-red-hover); }

        .alert {
            animation: fadeUp .3s ease both;
        }

        .badge {
            transition: opacity .15s ease, transform .15s ease;
        }
        .badge:hover { opacity: .85; transform: scale(1.05); }

        .stat-card {
            border-left: 4px solid var(--dnn-red) !important;
            transition: box-shadow .22s ease, transform .22s ease, border-color .22s ease;
        }
        .stat-card:hover {
            border-left-color: var(--dnn-red-dark) !important;
            transform: translateY(-2px);
            box-shadow: 0 8px 28px rgba(0,0,0,.12) !important;
        }
        .stat-card .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--dnn-red-light);
            color: var(--dnn-red);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            transition: background .2s, color .2s;
        }
        .stat-card:hover .stat-icon {
            background: var(--dnn-red);
            color: #fff;
        }

        @media (max-width: 768px) {
            body.d-flex { flex-direction: column; }
            .sidebar {
                width: 100%;
                min-height: auto;
                animation: fadeUp .3s ease both;
            }
            .sidebar .nav-link:hover { padding-left: 1rem; }
            .main-content { min-height: auto; }
        }
    </style>
</head>
<body class="d-flex">

<nav class="sidebar d-flex flex-column">
    <div class="brand">
        <img src="${pageContext.request.contextPath}/images/logo-white.svg"
             alt="Dunnas Residences" height="52">
    </div>
    <ul class="nav flex-column mt-2 flex-grow-1">

        <sec:authorize access="hasRole('ADMIN')">
            <li class="nav-section">Administração</li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2 me-2"></i>Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/blocks">
                    <i class="bi bi-buildings me-2"></i>Blocos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                    <i class="bi bi-people me-2"></i>Usuários
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/ticket-types">
                    <i class="bi bi-tags me-2"></i>Tipos de Chamado
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/ticket-statuses">
                    <i class="bi bi-diagram-3 me-2"></i>Status de Chamado
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('ADMIN','COLLABORATOR')">
            <li class="nav-section">Atendimento</li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/tickets">
                    <i class="bi bi-inbox me-2"></i>Fila de Chamados
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="hasRole('RESIDENT')">
            <li class="nav-section">Minha Área</li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/resident/dashboard">
                    <i class="bi bi-house me-2"></i>Início
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/resident/tickets">
                    <i class="bi bi-ticket me-2"></i>Meus Chamados
                </a>
            </li>
        </sec:authorize>
    </ul>

    <div class="p-3 border-top border-secondary">
        <form method="post" action="${pageContext.request.contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button class="btn btn-sm btn-outline-secondary w-100">
                <i class="bi bi-box-arrow-left me-1"></i>Sair
            </button>
        </form>
    </div>
</nav>

<div class="main-content d-flex flex-column">
    <div class="topbar d-flex align-items-center justify-content-between">
        <h6 class="mb-0 fw-semibold"><c:out value="${pageTitle}" default=""/></h6>
        <span class="text-muted small">
            <i class="bi bi-person-circle me-1"></i>
            <sec:authentication property="name"/>
        </span>
    </div>

    <div class="p-4 flex-grow-1">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <c:out value="${successMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <c:out value="${errorMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
