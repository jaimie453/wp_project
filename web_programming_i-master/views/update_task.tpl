<html>
<head>
    <title>Todo List 0.001</title>
    <link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet" />
</head>
<body>
    %include("header.tpl")
    <div style="width: 50%; margin: auto;">
        <p class="w3-center">Update task description:</p>
        <form class="w3-center" action="/update_task" method="POST">
            <input type="text" size="75" maxlength="100" name="updated_task" value="{{row['task']}}"/>
            <input type="submit" name="update_button" value="Update"/>
        </form>
    </div>
    %include("footer.tpl")
</body>
</html>