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
        body { background: #f0f2f5; }
        a:hover { color: #b0141a; }
        .btn-light:hover {
            color: #fff;
            background-color: #bf2329;
            border-color: #bf2329;
        }
        .sidebar { width: 240px; min-height: 100vh; background: #1a1d23; flex-shrink: 0; }
        .sidebar .brand { font-size: 1.1rem; font-weight: 700; color: #fff; padding: 1.25rem 1.5rem; border-bottom: 1px solid #2d3139; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin: 2px 8px; padding: .5rem 1rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #2d3139; color: #fff; }
        .sidebar .nav-section { font-size: .7rem; color: #6c757d; padding: .75rem 1.5rem .25rem; text-transform: uppercase; letter-spacing: .08em; }
        .main-content { flex: 1; overflow-y: auto; min-height: 100vh; }
        .topbar { background: #fff; border-bottom: 1px solid #e9ecef; padding: .75rem 1.5rem; }
    </style>
</head>
<body class="d-flex">

<nav class="sidebar d-flex flex-column">
    <div class="brand"><i class="bi bi-building me-2"></i>Condomínio</div>
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
