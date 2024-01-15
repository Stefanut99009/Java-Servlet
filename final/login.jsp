<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
   

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");

        conn.setAutoCommit(false);
        String query = "SELECT * FROM login WHERE username=? AND password=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            out.println("Login successful");
            conn.commit(); // Commit the transaction
            response.sendRedirect("Formular.jsp");
        } else {
            out.println("Login failed. Please check your username and password.");
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
