<html>
    <head>
        <title>Todo List 0.001</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                var get_tasks_url = '{{ base_url }}' + "get_tasks";
                $.getJSON(get_tasks_url , function(rows) {
                    console.log("tasks: ", rows);
                    if(rows.length === 0){
                        $("#task_empty").append(
                            "<p>No tasks to complete for the moment.</p>"
                        );
                    } else {
                        $.each(rows, function(i, row) {
                            var statusId, iconName;
                            if(row["status"]){
                                status = 0;
                                iconName = "check_box";
                            } else {
                                status = 1;
                                iconName = "check_box_outline_blank";
                            }

                            $("#tasks").append(
                                "<tr>"
                                    + "<td class=\"w3-center\"><a href=\"/update_task/" + row["id"] + "\"><i class=\"material-icons\">edit</i></a></td>"
                                    + "<td>" + row["task"] + "</td>"
                                    + "<td class=\"w3-center\"><a href=\"/update_status/" + row["id"] + "/" + status + "\"><i class=\"material-icons\">" + iconName + "</i></a></td>"
                                    + "<td class=\"w3-center\"><a href=\"/delete_item/" + row["id"] + "\"><i class=\"material-icons\">delete</i></a></td>"
                                + "</tr>"
                            );
                        });
                    }         
                });

                var get_completed_tasks_url = '{{ base_url }}' + "get_completed_tasks";
                $.getJSON(get_completed_tasks_url , function(rows) {
                    console.log("completed tasks: ", rows);
                    if(rows.length === 0){
                        $("#completed_task_extras").append(
                            "<p>No completed tasks at the moment.</p>"
                        );
                    } else {
                        $.each(rows, function(i, row) {
                            var statusId, iconName;
                            if(row["status"]){
                                status = 0;
                                iconName = "check_box";
                            } else {
                                status = 1;
                                iconName = "check_box_outline_blank";
                            }

                            $("#completed_tasks").append(
                                "<tr>"
                                    + "<td class=\"w3-center\"><a href=\"/update_task/" + row["id"] + "\"><i class=\"material-icons\">edit</i></a></td>"
                                    + "<td>" + row["task"] + "</td>"
                                    + "<td class=\"w3-center\"><a href=\"/update_status/" + row["id"] + "/" + status + "\"><i class=\"material-icons\">" + iconName + "</i></a></td>"
                                    + "<td class=\"w3-center\"><a href=\"/delete_item/" + row["id"] + "\"><i class=\"material-icons\">delete</i></a></td>"
                                + "</tr>"
                            );

                            
                        });
                        $("#completed_task_extras").append(
                            "<a style=\"display: block; margin: 15px auto; width: 170px; height: 40px;\" href=\"/new_item\">"
                            + "<button style=\"width: 170px; height: 40px;\" class=\"w3-button w3-teal\">Clear tasks</button>"
                            + "</a>"
                        );
                    }              
                });
            });
        </script>
    </head>
    <body>
        %include("header.tpl")

        <div class="w3-cell-row">
            <div class="w3-container w3-cell" style="width: 50%;">
                <h4 class="w3-center">Tasks To Complete</h4>
                <table style="width: 90%; margin:auto;" class="w3-table w3-bordered w3-border">
                    <colgroup>
                        <col span="1" style="width: 5%;">
                        <col span="1" style="width: 85%;">
                        <col span="1" style="width: 5%;">
                        <col span="1" style="width: 5%;">
                    </colgroup>

                    <tbody id="tasks">

                    </tbody>
                </table>
                <div class="w3-center" id="task_empty"></div>
                <a style="display: block; margin: 15px auto; width: 170px; height: 40px;" href="/new_item">
                    <button style="width: 170px; height: 40px;" class="w3-button w3-teal">Add a new task...</button>
                </a>
            </div>

            <div class="w3-container w3-cell" style="width: 50%;"> 
                <h4 class="w3-center">Completed Tasks</h4>
                <table style="width: 90%; margin:auto;" class="w3-table w3-bordered w3-border">
                    <colgroup>
                        <col span="1" style="width: 5%;">
                        <col span="1" style="width: 85%;">
                        <col span="1" style="width: 5%;">
                        <col span="1" style="width: 5%;">
                    </colgroup>

                    <tbody id="completed_tasks">

                    </tbody>
                </table>
                <div class="w3-center" id="completed_task_extras"></div>
            </div>
        </div>

        %include("footer.tpl")
    </body>
</html>