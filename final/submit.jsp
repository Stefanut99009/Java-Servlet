
    <%-- JSP code for processing form data --%>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
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

            // Add your processing logic here

            // For demonstration purposes, printing the values
            out.println("<h2>Submitted Data</h2>");
            out.println("<p>Userid: " + userid + "</p>");
            out.println("<p>First name: " + first_name + "</p>");
            out.println("<p>Last name: " + last_name + "</p>");
            out.println("<p>Denumire categorie: " + den_c + "</p>");
            out.println("<p>Cantitate produs: " + cant_p + "</p>");
            out.println("<p>Suma factura: " + suma_f + "</p>");
            out.println("<p>Data factura: " + data_f + "</p>");
            out.println("<p>Numar ore pontaj: " + nr_ore_po + "</p>");
            out.println("<p>Locatie client: " + loc_cli + "</p>");
            out.println("<p>Denumire produs: " + den_p + "</p>");
        }
    %>

