<html>
    <head>
        <title>Todo List 0.001</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet" />
    </head>
    <body>
        <div class="w3-bar w3-teal">
            <a href="/register" style="float: right;"><button class="w3-bar-item w3-button">Register</button></a>
        </div>

        <h2 class="w3-center" style="margin: 20px;">Basic Todo List</h2>
        <br>
        <div class="w3-container">
            <form class="w3-center" action="/" method="GET">
                That login attempt didn't work out.<br><br>
                <input type="submit" name="submit" value="OK"/>
            </form>
        </div>

        %include("footer.tpl")
    </body>
</html>