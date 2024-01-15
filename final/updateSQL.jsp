<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    String JDBC_URL = "jdbc:mysql://your_database_host:3306/your_database_name";
    String JDBC_USER = "your_database_user";
    String JDBC_PASSWORD = "your_database_password";

    try {
        // Retrieve form data
        String userId = request.getParameter("userid");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String locCli = request.getParameter("loc_cli");
        String denP = request.getParameter("den_p");
        String cantP = request.getParameter("cant_p");
        String denC = request.getParameter("den_c");
        String sumaF = request.getParameter("suma_f");
        String dataF = request.getParameter("data_f");
        String nrOrePo = request.getParameter("nr_ore_po");

        // JDBC code to update data in the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");
        // rest of the code
        conn.setAutoCommit(false);
        // Insert data into the database
          String updateQuery = "UPDATE proiect SET first_name=?, last_name=?, loc_cli=?, den_p=?, cant_p=?, den_c=?, suma_f=?, data_f=?, nr_ore_po=? WHERE userid=?";
          preparedStatement = conn.prepareStatement(updateQuery);

       
          preparedStatement.setString(1, firstName);
                preparedStatement.setString(2, lastName);
                preparedStatement.setString(3, locCli);
                preparedStatement.setString(4, denP);
                preparedStatement.setString(5, cantP);
                preparedStatement.setString(6, denC);
                preparedStatement.setString(7, sumaF);
                preparedStatement.setString(8, dataF);
                preparedStatement.setString(9, nrOrePo);
                preparedStatement.setString(10, userId);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    // Update successful
                    response.sendRedirect("success.jsp");
                } else {
                    // Update failed
                    response.sendRedirect("failure.jsp");
                }
            }
        } catch (Exception e) {
        e.printStackTrace();
    }
%>
