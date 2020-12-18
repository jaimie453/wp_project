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

        <div class="w3-container">
            <h3 class="w3-center">Login</h3>
            <br>
            <form class="w3-center" action="/login" method="POST">
                <div>
                    <div>User Name:</div>
                    <div><input type="text" size="30" maxlength="30" name="username"/><br></div>
                </div>
                <br>
                <div>
                    <div>Password:</div>  
                    <div><input type="text" size="30" maxlength="30" name="password"/><br></div>
                </div>
                <input type="text" size="30" maxlength="30" name="csrf_token" value="{{csrf_token}}"/ hidden><br>
                <input type="submit" name="login" value="Login"/>
            </form>
        </div>

        %include("footer.tpl")
    </body>
</html>