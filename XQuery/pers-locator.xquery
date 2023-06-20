declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option saxon:output "method=html";
declare variable $parla := doc('../xml/negrete-1803-unified-1.xml');
(:whc 1 April 2023: This runs over the text XML and creates a table listing and
numbering the <persName> words. :)

<html><head></head><body>
<h1>Persons tagged in Negrete 1803 XML</h1>
<p>This HTML is created by running the file pers-locator.xquery over the Negrete Parlamento
XML file. Below is a table created by that XQuery. It includes a non-repeating list of names 
(though including multiple spellings and instances of each) and the already-assigned attribute value 
n="" number for each.</p>
<table>
<tr><th>No.</th><th>Name</th></tr>
{let $names := $parla//persName
for $name in $names
order by $name/data(@n)=>string-length(), $name/data(@n)
count $pos
return 
<tr><td>{$name/data(@n)}</td><td>{$name}</td></tr>
}
</table></body>
</html>
