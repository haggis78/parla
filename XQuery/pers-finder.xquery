declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option saxon:output "method=html";
declare variable $parla := doc('../XML/negrete-1803/spanish.xml');
(:whc 1 April 2023: This runs over the text XML and creates a table listing and
numbering the <persName> words. :)

<html><head></head><body>
<h1>Persons tagged in Negrete 1803 XML</h1>
<p>This HTML is created by running the file pers-finder.xquery over the Negrete Parlamento
XML file. Below is a table created by that XQuery. It includes a non-repeating list of names 
(though thus far it is case-sensitive) and a number for each. We can use this to assign numbers 
for term n="" attribute values, which can then be plugged back into the XML file for the next steps.
Some de-duplicating will have to be done manually. Because names are subject to greater spelling variation,
it is probably best NOT just to accept the ouptut numbers in this list, but to group the names on
 paper and assign them numbers there. (Otherwise many numbers would be skipped.)</p>
<table>
<tr><th>No.</th><th>Name</th></tr>
{let $names := $parla//persName
for $name in $names/string()!normalize-space()=>distinct-values()
order by $name
count $pos
return 
<tr><td>{$pos}</td><td>{$name}</td></tr>
}
</table></body>
</html>
