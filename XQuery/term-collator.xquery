declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option saxon:output "method=html";

declare variable $span := doc('../xml/negrete-1803-unified-1.xml');
declare variable $eng := doc('../xml/negrete-1803-english.xml');
declare variable $parla := ($span, $eng);

(:whc 1 April 2023: This runs over the text XML and creates a table listing and
numbering the <term> words. :)

<html>
<head><title>terms</title>

</head>
<body>
<h1>Terms tagged in Negrete 1803 XML: as of 14-JUN-2023</h1>
<p>This HTML is created by running the file term-collator.xquery over the Negrete Parlamento
XML files, including BOTH the Spanish and English. 
Below is a set of three tables created by that XQuery. Each includes a list of terms by number as assigned in the n="" attribute values on 
the term elements. </p>
<h1>All terms</h1>
<table style="border:1px solid;">
<tr style="border:1px solid;"><th>No.</th><th>Terms</th><th>Language</th></tr>
{let $terms := $parla//term
for $term in $terms
order by $term/data(@n)=>string-length(), $term/data(@n)
return 
<tr style="border:1px solid;"><td style="border:1px solid;">{$term/data(@n)}</td><td style="border:1px solid;">{$term/string()}</td>
<td style="border:1px solid;">
{if ($term/ancestor::TEI/teiHeader//titleStmt/title/contains(., 'of')) then "English"
else "Spanish"
}
</td></tr>
}
</table>
<h1>Spanish terms</h1>
<table>
<tr><th>No.</th><th>Term (Spanish)</th></tr>
{let $terms := $span//term
for $term in $terms
order by $term/data(@n)=>string-length(), $term/data(@n)
return 
<tr><td>{$term/data(@n)}</td><td>{$term/string()}</td></tr>
}
</table>
<h1>English terms</h1>
<table>
<tr><th>No.</th><th>Term (English)</th></tr>
{let $terms := $eng//term
for $term in $terms
order by $term/data(@n)=>string-length(), $term/data(@n)
return 
<tr><td>{$term/data(@n)}</td><td>{$term/string()}</td></tr>
}
</table>
</body>
</html>
