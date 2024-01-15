<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");

        conn.setAutoCommit(false); // Set auto-commit to false

        String query = "INSERT INTO login (username, password) VALUES (?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("Registration successful");
            conn.commit(); // Commit the transaction
            response.sendRedirect("Authentification.jsp");
        } else {
            out.println("Registration failed. Please try again.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
        try {
            if (conn != null) conn.rollback(); // Rollback the transaction on error
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) {
                conn.setAutoCommit(true); // Restore auto-commit to true before closing
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
