<?php

?>

<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="css/fonts.googleapis.com_icon_family=Material+Icons.css" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/cdnjs.cloudflare.com_ajax_libs_materialize_1.0.0_css_materialize.min.css"  media="screen,projection"/>
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <meta charset="UTF-8">
    <link rel="icon" href="img/logo.webp">
    <title>SQL2</title>
</head>

<body>

<nav>
    <div class="nav-wrapper light-green darken-4">
        <img src="img/logo.webp" class="brand-logo right" style="height: 55px" alt="IE Logo">
        <div class="left">
            SQL2 Group Assignment
        </div>
    </div>
</nav>

<div class="col s12 center">
    <p class="flow-text">Group 6</p>
</div>

<ul class="collapsible">
    <li>
        <div class="collapsible-header"><i class="material-icons">person</i>Team Members</div>
            <?php include "content/team_members.php"?>
    </li>

    <li>
        <div class="collapsible-header"><i class="material-icons">insert_chart</i>1. Entity Relation Diagram (ERD)</div>
            <?php include "content/erd.php"?>
    </li>

    <li>
        <div class="collapsible-header"><i class="material-icons">keyboard</i>2. Data Inserts</div>
        <?php include "content/dml.php"?>
    </li>

    <li>
        <div class="collapsible-header"><i class="material-icons">find_in_page</i>3. Model Explanation</div>
        <?php include "content/model.php"?>
    </li>

    <li>
        <div class="collapsible-header"><i class="material-icons">question_answer</i>4. Questions</div>
        <?php include "content/questions.php"?>
    </li>

</ul>

<!--JavaScript at end of body for optimized loading-->
<script type="text/javascript" src="js/cdnjs.cloudflare.com_ajax_libs_materialize_1.0.0_js_materialize.min.js"></script>
<script>
    M.AutoInit();
</script>
</body>
</html>
