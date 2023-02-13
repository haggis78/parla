<?xml version="1.0" encoding="UTF-8"?>
<!-- WHC 09-FEB-2023: The purpose for this XSLT is to create a display version of each edition 
    IN TWO PARALLEL COLUMNS (actually in a table element) as an html file. 
    I moved away from the whole way the selection of rdg elements worked in Brecon to make a much cleaner, more elegant
    stylesheet. It is static, meaning that it will not make different versions appear and disappear at a click like Brecon.
    That would have been very tricky to manage, maybe impossible, once a separate file with the English translation 
    was added. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
            <xsl:result-document method="xhtml" indent="yes" href="../site/1803-display-2cols.html"> 
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                        <link rel="stylesheet" type="text/css" href="style.css" />
<!-- whc 07-FEB-2023: I removed the js link that made tick boxes work. Will need to add back in, plus relevant 
                        css, to be able to change color/bold/whatever for names/places/terms etc.-->
                      <title>Negrete: Text Comparison</title>
                    </head>
                    <body>
                        
                        <div class="content">
                            <h1><xsl:apply-templates select="//titleStmt/title"/></h1>
                            <h3>Skip to section:<xsl:text>   </xsl:text>
                            <xsl:for-each select="//body/div">
                                <a href="#sect-{count(preceding-sibling::div)+1}"><xsl:value-of select='count(preceding-sibling::div)+1'/></a>  
                                <xsl:text>   </xsl:text>
                            </xsl:for-each></h3>
                            <table>
                                <tr>
                                    <td><xsl:apply-templates select="//bibl[data(@xml:id)='Z']"/></td>
                                    <td><xsl:apply-templates select="//bibl[data(@xml:id)='A']"/></td>
                                    <th></th>
                                </tr>
                                <tr><th><h2>Text: Zavala</h2></th><th><h2>Text: Ayun</h2></th><th><h2>Notes</h2></th></tr>

                                <xsl:for-each select="//body/div">
                                    <xsl:if test="./head">
                                        <tr id="sect-{count(preceding-sibling::div)+1}">
                                            <th>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  
                                                <xsl:apply-templates select="head" mode="Z-head"/></th>
                                            <th>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  
                                                <xsl:apply-templates select="head" mode="A-head"/></th>
                                            <td><b>Notes</b> (Click on terms in text to view)</td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="./ab">
                                        <tr id="sect-{count(preceding-sibling::div)+1}">
                                            <td><b>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  </b>
                                                <xsl:apply-templates select="ab" mode="Z-block"/> </td>
                                            <td><b>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  </b>
                                                <xsl:apply-templates select="ab" mode="A-block"/> </td>
                                            <td><b>Notes</b> (Click on terms in text to view)</td>
                                        </tr>
                                    </xsl:if>
                                </xsl:for-each>
                            </table>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="head" mode="Z-head">
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    <xsl:template match="rdg[@wit[not(contains(., 'Z'))]]" mode="Z-rdg"/>
    <!--whc: this suppresses non-Z rdg elements when called for by mode to create Z text-->
    
    <xsl:template match="head" mode="A-head">
        <xsl:apply-templates mode="A-rdg"/>
    </xsl:template>
    
    <xsl:template match="rdg[@wit[not(contains(., 'A'))]]" mode="A-rdg"/>
    <!--whc: this suppresses non-A rdg elements when called for by mode to create A text-->
    
    <xsl:template match="ab" mode="Z-block">
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    
    <xsl:template match="ab" mode="A-block">
        <xsl:apply-templates mode="A-rdg"/>
    </xsl:template>
    
    <xsl:template match="bibl">
            <p><b>Editor(s): </b> <xsl:apply-templates select="editor"/></p> 
            <p><b>Publication title: </b><i><xsl:value-of select="title"/></i></p>
            <p><b>Publisher: </b><xsl:value-of select="publisher"/></p>
            <p><b>Publisher location: </b><xsl:value-of select="pubPlace"/></p>
            <p><b>Publication date: </b><xsl:value-of select="date"/></p>
            <p><b>Page range: </b><xsl:value-of select="biblScope"/></p>
            <p><b>Notes: </b><i><xsl:value-of select="note"/></i></p>     
    </xsl:template>
  <!--WHC 09-FEB-2023: for some reason the persName template below seems not to
      work. I can't get anything to match on persName even when using the test version of
      the xml that has some. Not sure why yet.-->
    <xsl:template match="persName">
      <b><xsl:apply-templates/></b>  
   </xsl:template>
    

</xsl:stylesheet>