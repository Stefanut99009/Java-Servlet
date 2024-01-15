<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>

<html>

<head>
    
    <title>Magazin de instrumente muzicale</title>
    <style>
        /* Style for the container */
        .form-container {
            display: flex;
            justify-content: space-between;
        }
    
        .on-row .checkbox-container {
            display: flex; /* Set display to flex for the checkbox container */
        }
        .on-row2{
            display: flex;
        }
        .on-row input[type="checkbox"] {
            margin-right: 10px; /* Adjust the margin as needed */
        }
        .on-row input[type="submit"] {
            margin-right: 10px; /* Adjust the margin as needed */
        }
        /* Style for each form */
        .ceva {
            width: 45%; /* Adjust the width as needed */
        }
    </style>
    <script>
    
        
        function checkFeeling() {
            // Ask the user if they are sure
            const feeling = confirm("Are you sure?");
    
            if (!feeling) {
                // If not feeling good, prevent the form from being submitted
                return false;
            }
    
            // If feeling good, set the cookie and close the window after a short delay
            if (feeling){
            setCookie("feeling", "good");
            closeWindowAfterDelay(100);
    
            // Prevent the form from being submitted
            return true;
            }
        }
    
        function setCookie(name, value) {
            // Set a cookie with the provided name and value
            document.cookie = `${name}=${value}; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
        }
    
        function closeWindowAfterDelay(delay) {
            // Close the window after a specified delay
            setTimeout(function () {
                window.close();
            }, delay);
        }
    </script>
    
</head>

<body>

    <h1>Magazin de instrumente muzicale</h1>
    
 

    <% 
    String sortBy = request.getParameter("sortBy");
    String sortOrder = request.getParameter("sortOrder");
    
    String sqlQuery = "SELECT * FROM proiect";
    if (sortBy != null && sortOrder != null) {
        sqlQuery += " ORDER BY " + sortBy + " " + sortOrder;
    }
    Class.forName("com.mysql.jdbc.Driver");
Connection conn = null;
// JDBC connection parameters

conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi?useSSL=false", "root", "");
// Create a statement after initializing the connection
conn.setAutoCommit(false);
Statement statement = conn.createStatement();
// rest of the code


// Establish a connection

// Execute a query to retrieve data from your database table
ResultSet resultSet = statement.executeQuery(sqlQuery);


%>

  
<fieldset>
    
    <input type="radio" name="sortBy" value="den_c"> Den_c
    <input type="radio" name="sortBy" value="loc_cli">Loc_cli
    <input type="radio" name="sortBy" value="den_p"> Den_p

    <br>

    <input type="radio" name="sortOrder" value="ASC"> Ascending
    <input type="radio" name="sortOrder" value="DESC"> Descending

    <br>
    <button id="filterButton" type="button">Filter</button>
    <table border="1">
        <tr>
            <th>id</th>
            <th>userid</th>
            <th>first_name</th>
            <th>last_name</th>
            <th>den_p</th>
            <th>den_c</th>
            <th>cant_p</th>
            <th>suma_f</th>
            <th>data_f</th>
            <th>nr_ore_po</th>
            <th>loc_cli</th>
            
            <!-- Add more columns as needed -->
        </tr>

        <% 
            // Iterate over the result set and display data in the table
            while (resultSet.next()) {
        %>
            <tr>
                <td><%= resultSet.getString("id") %></td>
                <td><%= resultSet.getString("userid") %></td>
                <td><%= resultSet.getString("first_name") %></td>
                <td><%= resultSet.getString("last_name") %></td>
                <td><%= resultSet.getString("den_p") %></td>
                <td><%= resultSet.getString("den_c") %></td>
                <td><%= resultSet.getString("cant_p") %></td>
                <td><%= resultSet.getString("suma_f") %></td>
                <td><%= resultSet.getString("data_f") %></td>
                <td><%= resultSet.getString("nr_ore_po") %></td>
                <td><%= resultSet.getString("loc_cli") %></td>
                <!-- Add more columns as needed -->
            </tr>
        <%
            }
            
        %>

    </table>
   

    <script>
        function applySort() {
            var sortBy = document.querySelector('input[name="sortBy"]:checked').value;
            var sortOrder = document.querySelector('input[name="sortOrder"]:checked').value;
    
            // Redirect to the same page with updated parameters
            window.location.href = '<%= request.getRequestURI() %>?sortBy=' + sortBy + '&sortOrder=' + sortOrder;
        }
    
        // Add an event listener to the filter button
        document.getElementById('filterButton').addEventListener('click', function() {
            applySort();
        });
    </script>

</fieldset>
    <%
        // Close resources
        resultSet.close();
        
        statement.close();
        conn.close();
    %>

<%
List<Integer> idList = new ArrayList<>(); 
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/isi", "root", "");
    Statement statement2 = connection.createStatement();
    connection.setAutoCommit(false);
   
    
    ResultSet resuSet = statement2.executeQuery("SELECT id FROM proiect");
    while (resuSet.next()) {
        int id = resuSet.getInt("id");
        idList.add(id);
    }
%>
<div class="form-container">
    <div class="on-row">
    <form action="processCheckbox.jsp" method="post">
        <div class="checkbox-container">
            <%-- Iterate over the idList and create checkboxes --%>
            <%
                for (Integer id : idList) {
            %>
            <input type="checkbox" name="selectedIds" value="<%=id%>"> <%=id%><br>
            <%
                }
            %>
        </div>
        <br>
        <div class="on-row2">
        <input type="submit" value="Create XML"style="background-color:  #0D98BA; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">
    </form>
    <form action="importXML.jsp" method="post">
    <input type="submit" value="Import XML" style="background-color:  #880808; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">
</form>
<form action="convertXML.jsp" method="post">
    <input type="submit" value="Convert to XLS" style="background-color:  #8B8000; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">
</form>
<form action="convertXML2.jsp" method="post">
    <input type="submit" value="Convert to XLST" style="background-color:  #343434; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">
</form>

</div>
</div>
</div>
<div class="form-container">
    <div class="on-row">
    <form action="processCheckbox2.jsp" method="post">
        <div class="checkbox-container">
            <%-- Iterate over the idList and create checkboxes --%>
            <%
                for (Integer id : idList) {
            %>
            <input type="checkbox" name="selectedIds" value="<%=id%>"> <%=id%><br>
            <%
                }
            %>
        </div>
        <br>
        <div class="on-row2">
        <input type="submit" value="Delete by id"style="background-color:  #0D98BA; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">

        </form>
        </div>
    </div>
</div>
<%
// Close resources
resultSet.close();

statement.close();
conn.close();
%>




  
<div class="form-container">
        
            
            <form class="ceva" action="forFormular.jsp" method="post" onsubmit="return checkFeeling()">

                 <!-- A form for user input -->
                 <fieldset>
        <h2>User Information</h2>

        <label for="userid">User id:</label><br>

        <input type="text" id="userid" name="userid" maxlength="50"required pattern="[1-9]{3}" placeholder="340"><br>

        <label for="first_name">First name:</label><br>

        <input type="text" id="first_name" name="first_name" maxlength="50" required placeholder="Raaj"><br>
        <label for="last_name">Last name:</label><br>

        <input type="text" id="last_name" name="last_name" maxlength="50" required placeholder="Kapuur"><br>
        <label for="loc_cli">Locatie client:</label><br>

        <input type="text" id="loc_cli" name="loc_cli" maxlength="50" required placeholder="India"><br>

    </fieldset>
 

        <!-- Contact Information -->
        <fieldset>

        <h2>Produse cumparate</h2>

        <label for="den_p">Denumire produs:</label><br>

        <input type="text" id="den_p" name="den_p" maxlength="50" required placeholder="Chitara"><br>

        <label for="cant_p">Cantitate produs:</label><br>

        <input type="text" id="cant_p" name="cant_p" maxlength="50" required pattern="[0-9]+" placeholder="3"><br>

        <label for="den_c">Denumire categorie</label><br>

        <input type="text" id="den_c" name="den_c" required  placeholder="Electronica"><br>
        </fieldset>
 

        <!-- Education -->
        <fieldset>

        <h2>Detalii factura</h2>

        <label for="suma_f">Suma factura:</label><br>

        <input type="text" id="suma_f" name="suma_f" maxlength="50" placeholder="500" pattern="[0-9]+" required><br>
        

        <label for="data_f">Data facturare:</label><br>

        <input type="text" id="data_f" name="data_f" placeholder="2024/4/14" pattern="\d{4}-\d{2}-\d{2}" maxlength="50" required><br>
        </fieldset>
 

        <!-- Skills -->
<fieldset>
        <h2>Detalii Angajat</h2>

        <label for="nr_ore_po">Numar ore pontaj:</label><br>

        <input type="text" id="nr_ore_po" name="nr_ore_po" maxlength="50" pattern="[0-9]+" placeholder="40" required><br>
        
    
    
    </fieldset>
 

        <!-- Submit Button -->

        <input type="submit"  value="Save in databse"style="background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">

    </form>
    <form class="ceva" action="submit.jsp" method="post" onsubmit="return checkFeeling()">

        <!-- A form for user input -->
        <fieldset>
        <h2>User Information</h2>

        <label for="userid">User id:</label><br>

        <input type="text" id="userid" name="userid" maxlength="50"required pattern="[1-9][0-9]{2}" placeholder="340"><br>

        <label for="first_name">First name:</label><br>

        <input type="text" id="first_name" name="first_name" maxlength="50" required placeholder="Raaj"><br>
        <label for="last_name">Last name:</label><br>

        <input type="text" id="last_name" name="last_name" maxlength="50" required placeholder="Kapuur"><br>
        <label for="loc_cli">Locatie client:</label><br>

        <input type="text" id="loc_cli" name="loc_cli" maxlength="50" required placeholder="India"><br>

    </fieldset>
 

        <!-- Contact Information -->
        <fieldset>

        <h2>Produse cumparate</h2>

        <label for="den_p">Denumire produs:</label><br>

        <input type="text" id="den_p" name="den_p" maxlength="50" required placeholder="Chitara"><br>

        <label for="cant_p">Cantitate produs:</label><br>

        <input type="text" id="cant_p" name="cant_p" maxlength="50" required pattern="[0-9]+" placeholder="3"><br>

        <label for="den_c">Denumire categorie</label><br>

        <input type="text" id="den_c" name="den_c" required  placeholder="Electronica"><br>
        </fieldset>
 

        <!-- Education -->
        <fieldset>

        <h2>Detalii factura</h2>

        <label for="suma_f">Suma factura:</label><br>

        <input type="text" id="suma_f" name="suma_f" maxlength="50" placeholder="500" pattern="[0-9]+" required><br>
        

        <label for="data_f">Data facturare:</label><br>

        <input type="text" id="data_f" name="data_f" placeholder="2024/4/14" pattern="\d{4}-\d{2}-\d{2}" maxlength="50" required><br>
        </fieldset>
 

        <!-- Skills -->
<fieldset>
        <h2>Detalii Angajat</h2>

        <label for="nr_ore_po">Numar ore pontaj:</label><br>

        <input type="text" id="nr_ore_po" name="nr_ore_po" maxlength="50" pattern="[0-9]+" placeholder="40" required><br>
        
    </fieldset>


<!-- Submit Button -->

<input type="submit"  value="See how it looks"style="background-color: #343434; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">

</form>
<form class="ceva" action="updateSQL.jsp" method="post" onsubmit="return checkFeeling()">

    <!-- A form for user input -->
    <fieldset>
    <h2>User Information</h2>

    <label for="userid">User id:</label><br>

    <input type="text" id="userid" name="userid" maxlength="50"required pattern="[1-9][0-9]{2}" placeholder="340"><br>

    <label for="first_name">First name:</label><br>

    <input type="text" id="first_name" name="first_name" maxlength="50" required placeholder="Raaj"><br>
    <label for="last_name">Last name:</label><br>

    <input type="text" id="last_name" name="last_name" maxlength="50" required placeholder="Kapuur"><br>
    <label for="loc_cli">Locatie client:</label><br>

    <input type="text" id="loc_cli" name="loc_cli" maxlength="50" required placeholder="India"><br>

</fieldset>


    <!-- Contact Information -->
    <fieldset>

    <h2>Produse cumparate</h2>

    <label for="den_p">Denumire produs:</label><br>

    <input type="text" id="den_p" name="den_p" maxlength="50" required placeholder="Chitara"><br>

    <label for="cant_p">Cantitate produs:</label><br>

    <input type="text" id="cant_p" name="cant_p" maxlength="50" required pattern="[0-9]+" placeholder="3"><br>

    <label for="den_c">Denumire categorie</label><br>

    <input type="text" id="den_c" name="den_c" required  placeholder="Electronica"><br>
    </fieldset>


    <!-- Education -->
    <fieldset>

    <h2>Detalii factura</h2>

    <label for="suma_f">Suma factura:</label><br>

    <input type="text" id="suma_f" name="suma_f" maxlength="50" placeholder="500" pattern="[0-9]+" required><br>
    

    <label for="data_f">Data facturare:</label><br>

    <input type="text" id="data_f" name="data_f" placeholder="2024/4/14" pattern="\d{4}-\d{2}-\d{2}" maxlength="50" required><br>
    </fieldset>


    <!-- Skills -->
<fieldset>
    <h2>Detalii Angajat</h2>

    <label for="nr_ore_po">Numar ore pontaj:</label><br>

    <input type="text" id="nr_ore_po" name="nr_ore_po" maxlength="50" pattern="[0-9]+" placeholder="40" required><br>
    
</fieldset>


<!-- Submit Button -->

<input type="submit"  value="Update by UserId"style="background-color: #0000FF; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer;">

</form>

</div>
</body>

</html>