<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.transform.TransformerFactory, javax.xml.transform.Transformer, javax.xml.transform.TransformerException, javax.xml.transform.dom.DOMSource, javax.xml.transform.stream.StreamResult" %>
<%@ page import="java.io.File" %>


<%
    // Retrieve selected IDs from the form
    String[] selectedIds = request.getParameterValues("selectedIds");

    // Create a new XML document
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    Document doc = dBuilder.newDocument();

    // Create the root element
    Element rootElement = doc.createElement("selectedData");
    doc.appendChild(rootElement);

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Establish a connection to your database (replace "url", "user", and "password" with your database credentials)
        String url = "jdbc:mysql://localhost:3306/isi";
        String user = "root";
        String password = "";
        connection = DriverManager.getConnection(url, user, password);
        connection.setAutoCommit(false);
        // Iterate through each selected ID
        // Iterate through each selected ID
        for (String id : selectedIds) {
            // Perform a SQL query to delete records based on the ID
            String query = "DELETE FROM proiect WHERE id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, id);
        
            // Use executeUpdate() for DELETE operation
           preparedStatement.executeUpdate();
        
    // Create an element for each selected ID and add attributes/data
   
}
// Commit the transaction after processing all selected IDs
connection.commit();

            
        

        out.println("Data deleted from SQL successfully!");
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close database resources
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            out.println("Error closing database resources: " + e.getMessage());
        }
    }

%>
