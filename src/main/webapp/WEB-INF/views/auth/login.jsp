<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Condomínio — Entrar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --dnn-red: #bf2329;
            --dnn-red-dark: #8e1016;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        body { background: linear-gradient(135deg, #1a1d23 0%, #2d3139 100%); }
        a:hover { color: var(--dnn-red); }
        .login-card {
            max-width: 420px;
            border: none;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,.35);
            animation: fadeUp .45s ease both;
        }
        .login-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dnn-red);
        }
        .login-dot {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--dnn-red);
            margin-right: 4px;
            vertical-align: middle;
        }
        .btn-primary {
            background: var(--dnn-red);
            border-color: var(--dnn-red);
            transition: background .18s ease, box-shadow .18s ease, transform .12s ease;
        }
        .btn-primary:hover {
            background: var(--dnn-red-dark);
            border-color: var(--dnn-red-dark);
            box-shadow: 0 4px 14px rgba(191,35,41,.45);
        }
        .btn-primary:active { transform: scale(.97); }
        .form-control:focus { border-color: var(--dnn-red); box-shadow: 0 0 0 .2rem rgba(191,35,41,.18); }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100">
    <div class="card login-card p-4 w-100 mx-3">
        <div class="text-center mb-4">
            <div class="login-brand"><span class="login-dot"></span><i class="bi bi-building"></i> Condomínio</div>
            <p class="text-muted small mt-1">Sistema de Chamados</p>
        </div>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger py-2 small">E-mail ou senha incorretos.</div>
        </c:if>
        <c:if test="${param.logout != null}">
            <div class="alert alert-success py-2 small">Você saiu com sucesso.</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="mb-3">
                <label for="email" class="form-label fw-semibold small">E-mail</label>
                <input id="email" type="email" name="username"
                       class="form-control" placeholder="seu@email.com"
                       required autofocus>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label fw-semibold small">Senha</label>
                <input id="password" type="password" name="password"
                       class="form-control" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Entrar</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
