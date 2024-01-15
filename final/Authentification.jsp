<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <form action="login.jsp" method="post">
        <%-- Citiți valoarea cookie-ului de limbă --%>
    <% Cookie[] cookies = request.getCookies();
       String selectedLanguage = "";
       if (cookies != null) {
           for (Cookie cookie : cookies) {
               if (cookie.getName().equals("language")) {
                   selectedLanguage = cookie.getValue();
                   break;
               }
           }
       }
    %>
    <p>Selected Language: <%= selectedLanguage %></p>
    <%-- Restul codului pentru pagina de autentificare --%>

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        
        <input type="submit" value="Login">
    </form>
</body>
</html>
