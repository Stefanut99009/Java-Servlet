<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="javax.xml.transform.TransformerFactory" %>
<%@ page import="javax.xml.transform.Transformer" %>
<%@ page import="javax.xml.transform.stream.StreamResult" %>
<%@ page import="javax.xml.transform.dom.DOMSource" %>
<%@ page import="org.xml.sax.InputSource" %>

<%! // Declare variables outside the method
    String xmlFilePath = "C:/xampp/tomcat/webapps/proiect/XML/selectedData.xml";
    String xlsFilePath = "C:/xampp/tomcat/webapps/proiect/XML/selectedData.xlst";

    // Function to parse XML and create Excel workbook
    void convertXmlToXls(String xmlFilePath, String xlsFilePath) throws Exception {
        Workbook workbook = new XSSFWorkbook(); // Initialize workbook

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(new InputSource(new FileInputStream(xmlFilePath)));

        NodeList nodeList = doc.getElementsByTagName("row");
        List<String[]> data = new ArrayList<>();

        for (int i = 0; i < nodeList.getLength(); i++) {
            Node node = nodeList.item(i);
            NodeList childNodes = node.getChildNodes();

            List<String> rowData = new ArrayList<>();

            for (int j = 0; j < childNodes.getLength(); j++) {
                Node childNode = childNodes.item(j);
                if (childNode.getNodeType() == Node.ELEMENT_NODE) {
                    rowData.add(childNode.getTextContent());
                }
            }

            data.add(rowData.toArray(new String[0]));
        }

        Sheet sheet = workbook.createSheet("Sheet1");

        for (int i = 0; i < data.size(); i++) {
            Row row = sheet.createRow(i);
            String[] rowData = data.get(i);

            for (int j = 0; j < rowData.length; j++) {
                Cell cell = row.createCell(j);
                cell.setCellValue(rowData[j]);
            }
        }

        // Write workbook to file
        try (FileOutputStream fileOut = new FileOutputStream(xlsFilePath)) {
            workbook.write(fileOut);
        }

        workbook.close();
    }
%>

<%
    // Perform the conversion
    convertXmlToXls(xmlFilePath, xlsFilePath);
%>

<html>
<head>
    <title>XML to XLST Conversion</title>
</head>
<body>
    <h2>XML to XLST Conversion</h2>
    <p>Conversion complete. Excel file saved at: <%= xlsFilePath %></p>
</body>
</html>
