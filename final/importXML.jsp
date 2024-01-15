<%@ page import="java.sql.*, javax.xml.parsers.*, org.xml.sax.*, org.w3c.dom.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>XML to SQL Import</title>
</head>
<body>
    <%
        // Database connection parameters
        Connection conn = null;

        try {
            // Load JDBC driver and establish a connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");
            conn.setAutoCommit(false);

            // Parse XML file
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse("C:/xampp/tomcat/webapps/proiect/XML/selectedData.xml");
            doc.getDocumentElement().normalize();

            // Get a list of nodes
            NodeList nodeList = doc.getElementsByTagName("data");

            // Iterate through the nodes and insert data into the database
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;

                    // Extract data from XML elements
                    String userid = element.getAttribute("userid");
                    String first_name = element.getAttribute("first_name");
                    String last_name = element.getAttribute("last_name");
                    String den_c = element.getAttribute("den_c");
                    String cant_p = element.getAttribute("cant_p");
                    String suma_f = element.getAttribute("suma_f");
                    String data_f = element.getAttribute("data_f");
                    String nr_ore_po = element.getAttribute("nr_ore_po");
                    String loc_cli = element.getAttribute("loc_cli");
                    String den_p = element.getAttribute("den_p");

                    // Insert data into the database
                    String sql = "INSERT INTO proiect (userid, first_name,last_name, den_c, cant_p, suma_f, data_f, nr_ore_po, loc_cli,den_p) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
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
                    }
                }
            }

            // Close the database connection outside the loop
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <p>Data imported successfully!</p>
</body>
</html>
