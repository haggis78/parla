declare default element namespace "http://www.tei-c.org/ns/1.0";
<html>
    <head>
        <title>Divergences between Ayun and Zavala</title>
    </head>
    <body>
{let $doc := //TEI//body
let $divs := $doc/div
for $div in $divs
return
<table>
<tr>
<th>Ayun readings</th><th>Zavala readings</th></tr>
    {let $apps := $div//app
        for $app in $apps
        return
        <tr><td>{$app/rdg[@wit="#A"]}</td>
        <td>{$app/rdg[@wit="#Z"]}</td></tr>}
</table>
}</body></html>