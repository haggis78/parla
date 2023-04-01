declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option saxon:output "method=html";
(:whc 1 April 2023: This runs over the text XML and creates a table listing and
numbering the <term> words. :)
<html><head></head><body>
<h1>Terms tagged in Negrete 1803 XML</h1>
<p>This HTML is created by running the file term-finder.xquery over the Negrete Parlamento
XML file. Below is a table created by that XQuery. It includes a non-repeating list of terms 
(though thus far it is case-sensitive) and a number for each. We can use this to assign numbers 
for term n="" attribute values, which can then be plugged back into the XML file for the next steps.
Some de-duplicating will have to be done manually, 
but that's fine: Those numbers will stay unused for the moment and can be used for
additional terms tagged in the future.</p>
<table>
<tr><th>No.</th><th>Term</th></tr>
{let $terms := //term/string()
for $term in $terms=>distinct-values()
order by $term
count $pos
return 
<tr><td>{$pos}</td><td>{$term}</td></tr>
}
</table></body>
</html>