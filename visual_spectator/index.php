<!DOCTYPE html>
<html>
    <head>
        <meta charset=utf-8 />
        <title></title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" media="screen" href="css/master.css" />
    </head>
    <body>
        <div class="container">
            <?php
                if ($handle = opendir('../log')) {
                    while (false !== ($entry = readdir($handle))) {
                        if(preg_match('/(.*)\.json/', $entry, $matches))
                        {
                            echo "<h3><a href='game.php?file={$matches[1]}'>{$matches[1]}</a></h3>";
                        }
                    }
                    closedir($handle);
                }
            ?>
        </div>
    </body>
</html>