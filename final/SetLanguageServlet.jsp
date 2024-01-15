<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    // Your HTML or JSP code here

    // Java code from SetLanguageServlet

    String language = request.getParameter("language");

    // Setare cookie cu limba selectată
    Cookie languageCookie = new Cookie("language", language);
    languageCookie.setMaxAge(30 * 24 * 60 * 60); // Valabilitate: 30 de zile
    response.addCookie(languageCookie);

    // Redirecționare către pagina de autentificare sau altă pagină relevantă
    response.sendRedirect("Authentification.jsp");

    // More HTML or JSP code if needed
%>
