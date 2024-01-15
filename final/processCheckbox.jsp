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
    // Perform a SQL query to retrieve additional data based on the ID
    String query = "SELECT * FROM proiect WHERE id = ?";
    preparedStatement = connection.prepareStatement(query);
    preparedStatement.setString(1, id);
    resultSet = preparedStatement.executeQuery();

    // Create an element for each selected ID and add attributes/data
    while (resultSet.next()) {
        Element dataElement = doc.createElement("data");
        dataElement.setAttribute("id", id);
        // Add more attributes or data from the database as needed
        dataElement.setAttribute("userid", resultSet.getString("userid"));
        dataElement.setAttribute("first_name", resultSet.getString("first_name"));
        dataElement.setAttribute("last_name", resultSet.getString("last_name"));
        dataElement.setAttribute("den_c", resultSet.getString("den_c"));
        dataElement.setAttribute("cant_p", resultSet.getString("cant_p"));
        dataElement.setAttribute("suma_f", resultSet.getString("suma_f"));
        dataElement.setAttribute("data_f", resultSet.getString("data_f"));
        dataElement.setAttribute("nr_ore_po", resultSet.getString("nr_ore_po"));
        dataElement.setAttribute("loc_cli", resultSet.getString("loc_cli"));
        dataElement.setAttribute("den_p", resultSet.getString("den_p"));
        // Add more columns as needed
        rootElement.appendChild(dataElement);
    }
}
// Commit the transaction after processing all selected IDs
connection.commit();
out.println("Data saved to XML successfully!");
            
        

        out.println("Data saved to XML successfully!");
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
    String filePath = "C:/xampp/tomcat/webapps/proiect/XML/selectedData.xml"; // Specify the desired file path
    try {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(new File(filePath));

        transformer.transform(source, result);
        out.println("XML file saved successfully at: " + filePath);
    } catch (TransformerException e) {
        out.println("Error saving XML file: " + e.getMessage());
    }
%>
