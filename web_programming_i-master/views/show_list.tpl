<html>
<head>
  <title>Todo List 0.001</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
  <link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
  $(document).ready(function() {
    $.getJSON("http://jaimie6453.pythonanywhere.com/get_tasks", function(rows) {
        $.each(rows, function(i, row) {
            var statusId, iconName;
            if(row["status"]){
                status = 0;
                iconName = "check_box";
            } else {
                status = 1;
                iconName = "check_box_outline_blank";
            }

            $("#content").append(
                "<tr>"
                    + "<td class=\"w3-center\"><a href=\"/update_task/" + row["id"] + "\"><i class=\"material-icons\">edit</i></a></td>"
                    + "<td>" + row["task"] + "</td>"
                    + "<td class=\"w3-center\"><a href=\"/update_status/" + row["id"] + "/" + status + "\"><i class=\"material-icons\">" + iconName + "</i></a></td>"
                    + "<td class=\"w3-center\"><a href=\"/delete_item/" + row["id"] + "\"><i class=\"material-icons\">delete</i></a></td>"
                + "</tr>"
            );
        });
    });
  })
  </script>
</head>
<body>
%include("header.tpl", session=session)
<table style="width: 60%; margin:auto;" class="w3-table w3-bordered w3-border">
    <colgroup>
        <col span="1" style="width: 5%;">
        <col span="1" style="width: 85%;">
        <col span="1" style="width: 5%;">
        <col span="1" style="width: 5%;">
    </colgroup>

    <tbody id="content">

    </tbody>
</table>
%include("footer.tpl", session=session)
</body>
</html>