# Decisões Técnicas — Desafio Dunnas N° 0004/2026

## 1. Arquitetura em pacotes por domínio (DDD)

O projeto segue Domain-Driven Design com pacotes no formato `<domínio>/{entity,repository,service,controller,dto}`.

**Motivação:** Cada domínio (ticket, user, block, comment, audit) é coeso e independente. Facilita localizar, modificar e testar um domínio sem impacto colateral nos demais. A alternativa — organizar por camada (`controller/`, `service/`, `repository/`) — fragmenta a lógica de negócio de forma oposta ao DDD.

---

## 2. JSP em vez de Thymeleaf

**Motivação:** O requisito do desafio especifica JSP. Além disso, JSP com JSTL é amplamente suportado no ecossistema Java EE/Jakarta EE sem dependências adicionais além de `jakarta.servlet.jsp.jstl`.

**Trade-off:** JSP exige compilação em tempo de execução (precisa de JDK, não apenas JRE). Por isso a imagem Docker usa `eclipse-temurin:21-jdk-alpine` em ambos os estágios do multi-stage build.

---

## 3. WAR em vez de JAR

Spring Boot gera JAR executável por padrão. O projeto usa `<packaging>war</packaging>` e `DesafioApplication extends SpringBootServletInitializer` para suportar o servidor de aplicação embutido e o classpath correto para resolução de JSPs.

---

## 4. Palavra reservada EL: `default` e `final`

A Expression Language (EL) do JSP tem `default` e `final` como palavras reservadas. Acessar `${status.default}` resulta em `ELException` em tempo de execução.

**Solução:** usar notação de colchetes: `${status['default']}` e `${status['final']}`. Aplica-se a qualquer propriedade cujo nome coincida com palavra reservada Java/EL.

---

## 5. Auditoria via AOP com `@Auditable`

Em vez de chamar `AuditService.log(...)` manualmente em cada service, criamos:
- `@Auditable(action, entityType)` — anotação de marcação
- `AuditAspect` — `@Around` que intercepta métodos anotados, captura usuário autenticado e IP, e persiste o `AuditLog`

**Vantagens:** os services de negócio não conhecem o mecanismo de auditoria (separação de responsabilidades). Falha na auditoria é não-bloqueante (capturada com `log.warn`).

**Captura de IP:** tenta `X-Forwarded-For` (proxy/load balancer) antes de `HttpServletRequest.getRemoteAddr()`.

---

## 6. Spring Security — `FORWARD` e `ERROR` devem ser permitidos primeiro

```java
http.authorizeHttpRequests(auth -> auth
    .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
    // demais regras...
);
```

Sem essa linha, o Spring Security bloqueia o `RequestDispatcher.forward()` interno do MVC JSP, resultando em 403 em todas as páginas após autenticação bem-sucedida.

---

## 7. Testes: `@WebMvcTest` com `SecurityConfig`

Para testar controllers com restrições de role, é necessário:

```java
@WebMvcTest(TicketController.class)
@Import(SecurityConfig.class)
class TicketControllerTest {
    @MockBean RoleBasedSuccessHandler roleBasedSuccessHandler;
    // ...
}
```

`@WebMvcTest` carrega apenas a camada MVC. `SecurityConfig` precisa ser importado explicitamente para que as regras de autorização sejam avaliadas. `RoleBasedSuccessHandler` precisa de `@MockBean` pois é um bean do Spring Security não carregado automaticamente pelo slice test.

---

## 8. Especificação dinâmica de filtros com `JpaSpecificationExecutor`

`TicketRepository` estende `JpaSpecificationExecutor<Ticket>`. Filtros da listagem (tipo, status, texto) são combinados dinamicamente em `TicketSpecification` usando predicates JPA Criteria API, evitando múltiplas variantes de queries ou QueryDSL.

---

## 9. Segurança de upload de arquivos

- Filename sanitizado: apenas o nome base é extraído via `StringUtils.cleanPath()` do Spring
- Extensões não são restritas no MVP, mas o `content_type` é armazenado para validação futura
- Arquivos são salvos fora do classpath (`/uploads/`) para evitar acesso direto via URL estática

---

## 10. Hash de senha com BCrypt

`PasswordEncoder` configurado com BCrypt (padrão Spring Security, fator de custo 10). Nunca armazenamos senha em texto plano. O seed `V6` usa hash pré-computado para inserção via SQL sem expor credenciais no código.
