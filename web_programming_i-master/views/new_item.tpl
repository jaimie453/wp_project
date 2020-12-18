<html>
<head>
    <title>Todo List 0.001</title>
    <link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet" />
</head>
<body>
    %include("header.tpl")
    <div style="width: 60%; margin: auto;">
        <p class="w3-center">Create a new task:</p>
        <form class="w3-center" action="/new_item" method="POST">
            <input type="text" size="75" maxlength="100" name="new_task" placeholder="Do the dishes..."/>
            <input type="submit" name="save" value="Save"/>
        </form>
    </div>

    %include("footer.tpl")
</body>
</html>