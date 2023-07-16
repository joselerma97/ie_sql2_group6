<?php
function draw_sql($sql, $columns){
    // Establish a database connection
    $servername = "92.249.44.156";
    $username = "u433398063_group6";
    $password = "E7KGuhWe|";
    $database = "u433398063_ie";
    $port = 3306;

    $conn = mysqli_connect($servername, $username, $password, $database, $port);

    // Check the connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    //Draw SQL
    echo ' <blockquote style="text-align: justify" >'.$sql.'</p> </blockquote>';

    //Draw Table

    $table_columns = '';
    $table_rows = '';

    foreach($columns as $column){
        $table_columns = $table_columns.'<th>'.$column.'</th>';
    }

    $result = mysqli_query($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            $table_rows = $table_rows.'<tr>';
            foreach($columns as $column){
                $table_rows = $table_rows.'<td>'.$row[$column].'</td>';
            }
            $table_rows = $table_rows.'</tr>';
        }
    } else {
        echo "No results found.";
    }

    echo '
    <table class="responsive-table centered">
        <thead>
          <tr>
            '.$table_columns.'
          </tr>
          </thead>
          
          <tbody>
            '.$table_rows.'
          </tbody>
          
    </table>    
    ';

    mysqli_close($conn);
}