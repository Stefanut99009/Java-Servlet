<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page import="java.io.*" %>
<%
    // Retrieve form data
    String userid = request.getParameter("userid");
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String den_c = request.getParameter("den_c");
    String cant_p = request.getParameter("cant_p");
    String suma_f = request.getParameter("suma_f");
    String data_f = request.getParameter("data_f");
    String nr_ore_po = request.getParameter("nr_ore_po");
    String loc_cli = request.getParameter("loc_cli");
    String den_p = request.getParameter("den_p");

    // Database connection parameters
    
    // Database connection
    
    PreparedStatement preparedStatement = null;

    Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");
        // rest of the code
        conn.setAutoCommit(false);
        // Insert data into the database
        String sql = "INSERT INTO proiect (userid, first_name, last_name, den_c, cant_p, suma_f, data_f, nr_ore_po, loc_cli, den_p) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        preparedStatement = conn.prepareStatement(sql);

        preparedStatement.setString(1, userid);
        preparedStatement.setString(2, first_name);
        preparedStatement.setString(3, last_name);
        preparedStatement.setString(4, den_c);
        preparedStatement.setString(5, cant_p);
        preparedStatement.setString(6, suma_f);
        preparedStatement.setString(7, data_f);
        preparedStatement.setString(8, nr_ore_po);
        preparedStatement.setString(9, loc_cli);
        preparedStatement.setString(10, den_p);

        int result = preparedStatement.executeUpdate();


        if (result > 0) {
            out.println("Registration successful");
            conn.commit(); // Commit the transaction
            
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
            if (preparedStatement != null) preparedStatement.close();

            if (conn != null) {
                conn.setAutoCommit(true); // Restore auto-commit to true before closing
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
