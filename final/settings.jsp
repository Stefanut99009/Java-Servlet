<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Settings</title>
</head>
<body>
    <form action="SetLanguageServlet.jsp" method="post">
        <label>Select language:</label>
        <select name="language">
            <option value="en">English</option>
            <option value="ro">Română</option>
            <!-- Adăugați opțiuni pentru alte limbi, dacă este necesar -->
        </select>
        <input type="submit" value="Save">
    </form>
</body>
</html>
