declare default element namespace "http://www.tei-c.org/ns/1.0";
<html>
    <head><title>Divergences between Ayun and Zavala</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    </head>
    <body>
    <h1>Tables: Divergences between Ayun and Zavala</h1>
{let $divs := //TEI//body/div
for $div at $pos in $divs
return(
<h2>Section {$pos}</h2>,
<table>
<tr><th>Variant no.</th><th>Ayun readings</th><th>Zavala readings</th></tr>
    {let $apps := $div//app
        for $app at $pos in $apps
        return
        <tr><td>{$pos}</td><td>{$app/rdg[@wit="#A"]/text()}</td>
        <td>{$app/rdg[@wit="#Z"]/text()}</td></tr>
        }
</table>)
}</body></html>