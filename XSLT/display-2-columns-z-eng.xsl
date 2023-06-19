<?xml version="1.0" encoding="UTF-8"?>
<!-- WHC 24-May-2023: The purpose for this XSLT is to create a display version with Zavala and English translation 
    IN TWO PARALLEL COLUMNS (actually in a table element) as an html file, with a third column for notes. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:variable name="negreteFiles" select="collection('../XML/test-versions/?select=*.xml')"/>
    <xsl:variable name="negText" select="document('../XML/test-versions/negrete-test.xml')"/>
    <xsl:variable name="negTrans" select="document('../XML/test-versions/english-translation-test.xml')"/>
    <xsl:variable name="negLex" select="document('../XML/test-versions/negrete-lexicon-test.xml')"/>
    <xsl:variable name="negPers" select="document('../XML/test-versions/negrete-persons-test.xml')"/>
    <xsl:variable name="negPlace" select="document('../XML/test-versions/negrete-locations-test.xml')"/>
    
    <!--whc 18-FEB-2023: will need to change the varables' filepaths and file handles when it's time to run over the real files-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="$negText">
            <xsl:result-document method="xhtml" indent="yes" href="../site/negrete-1803/1803-display-2cols-z-eng.html"> 
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                        <link rel="stylesheet" type="text/css" href="../css/style.css" />

                        <title>Negrete: Translation</title>
                    </head>
                    <body>
                        <img src="../images/heading-bickham-font.png" width="1100"
                            alt="header with image of the words Parlamentos Project in historic script" />
                        <hr />
                        <div class="content">
                            <h1><xsl:apply-templates select="$negText//titleStmt/title"/><xsl:text>: Text and Translation</xsl:text></h1>
                            <h3>Skip to section:<xsl:text>   </xsl:text>
                                <xsl:for-each select="$negText//body/div">
                                    <a href="#sect-{data(@n)}"><xsl:value-of select='data(@n)'/></a>  
                                    <xsl:text>   </xsl:text>
                                </xsl:for-each>
                            </h3>
                            <table>
                                <tr>
                                    <td><xsl:apply-templates select="$negText//bibl[data(@xml:id)='Z']" mode="span"/></td>
                                    <td><xsl:apply-templates select="$negText//bibl[data(@xml:id)='Z']" mode="eng"/></td>
                                    <th></th>
                                </tr>
                                <tr><th><h2>Text: Zavala</h2></th>
                                    <th><h2>Text: English Translation</h2></th>
                                    <th><h2>Notes</h2></th></tr>

<!--whc 24-May-2023: while <xsl:apply-templates select="$negText//body/div"/> approach was used in the XSLT for two columns
                                of Spanish versions, I've needed to switch to an xsl:for-each loop here to be able to pull both the Zavala text from
                                the Spanish XML and the corresponding English divs from that separate XML file. -->
                                
                                <xsl:for-each select=".//div">
                                    <xsl:if test="@n"><!--whc: to screen out any divs that only appear in Ayun, which will have no numbers in the Spanish XML file-->
                                    <xsl:variable name="div-n" select="./data(@n)"/>
                                    <xsl:variable name="this-div-eng" select="$negTrans//body/div[data(@n)=$div-n]"/>
                                    
                                    <xsl:if test="./head">
                                        <tr id="sect-{$div-n}">
                                            <th>[&#167;<xsl:value-of select="data(@n)"/>]
                                                <xsl:apply-templates select="head" mode="Z-head"/></th>
                                            <th>[&#167;<xsl:value-of select="data(@n)"/>]  
                                                <xsl:apply-templates select="$negTrans//div[data(@n)=$div-n]/head"/></th>
                                             <td><b>Notes</b> <i> Click on category to expand/collapse</i>
                                                <a class="top-btn" href="#">Top of page</a></td>
<!-- whc 24-May-2023: I have not yet done the Notes column, which will go right here.  -->                                            
                                        </tr>
                                    </xsl:if>
                                        
                                        <xsl:if test="./ab">
                                            <tr id="sect-{$div-n}">
                                                <td><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>
                                                    <xsl:apply-templates select="ab" mode="Z-block"/> </td>
                                                <td><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>  
                                                    <xsl:apply-templates select="$negTrans//div[data(@n)=$div-n]/ab"/></td>
                                                <td><b>Notes</b> <i> Click on category to expand/collapse</i>
                                                    <a class="top-btn" href="#">Top of page</a></td>
 <!-- whc 24-May-2023: I have not yet done the Notes column, which will go right here.  -->
                                            </tr>
                                        </xsl:if>     
                                        
                                    </xsl:if>
                                </xsl:for-each>
                                
                            </table>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div">
            <xsl:if test="./head">
                <tr id="sect-{data(@n)}">
                    <th><xsl:if test="@n">[&#167;<xsl:value-of select="data(@n)"/>] </xsl:if>  
                        <xsl:apply-templates select="head" mode="Z-head"/></th>
                    <th>[&#167;<xsl:value-of select="data(@n)"/>]  
                    <xsl:apply-templates select="head" mode="Eng-head"/></th>
                <td><b>Notes</b> <i> Click on category to expand/collapse</i>
                    <a class="top-btn" href="#">Top of page</a></td>
            </tr>
        </xsl:if>
        <!--whc 18-FEB-2023: Notes on div/head will follow exactly the same pattern as they do on div/ab.
            Get them working perfectly on div/ab and then just copy the whole thing to div/head; or figure out a way
            to make the notes etc. their own template rule that can be called from either type of div.-->
        <xsl:if test="./ab">
            <tr id="sect-{count(preceding-sibling::div)+1}">
                <td><b>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  </b>
                    <xsl:apply-templates select="ab" mode="Z-block"/> </td>
                <td><b>[&#167;<xsl:value-of select="count(preceding-sibling::div)+1"/>]  </b>
                    <xsl:apply-templates select="ab" mode="A-block"/> </td>
                
                <td>
                    <xsl:if test="ab[.//term or .//persName or .//placeName]">
                        <span class="title"><b>Notas</b></span> <i> Haga clic en cada categoría para ampliar/contraer</i>
                        <a class="top-btn" href="#">Inicio de página</a><hr/>
                    </xsl:if>
                    <xsl:if test="ab[not(.//term or .//persName or .//placeName)]">
                        <i>No hay notas en esta sección.</i>
                        <a class="top-btn" href="#">Inicio de página</a>
                    </xsl:if>
                    
                    <xsl:if test=".//term">
                        <details>
                            <summary><span class="title"><b>Términos</b></span></summary> <i>Haga clic en cada término para ampliar/contraer</i>
                        <p>
                <xsl:for-each-group select=".//term" group-by="data(@n)">
                    <xsl:variable name="term-n" select="./data(@n)"/>
                    <xsl:variable name="this-term-span" select="$negLex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
                    <details><summary><b><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></b></summary>
                        <i><xsl:apply-templates select="$this-term-span//pos"/></i>
                        <xsl:text>. </xsl:text>
                        <xsl:for-each select="$this-term-span//sense">
                            <xsl:value-of select="./data(@n)"/><xsl:text>. </xsl:text>
                            <xsl:apply-templates/><xsl:text>. </xsl:text>
                        </xsl:for-each><br/>
                        <u>Notas</u><xsl:text>: </xsl:text><xsl:apply-templates select="$this-term-span//note"/><br/></details>
                </xsl:for-each-group> </p>   </details>    </xsl:if>
                    
                    
                    <xsl:if test=".//persName">
                        <details><summary><span class="title"><b>Personas</b></span></summary> <i>Haga clic en cada nombre para ampliar/contraer</i>
                            <p>
                        <xsl:for-each-group select=".//persName" group-by="data(@n)">
                            <xsl:variable name="pers-n" select="./data(@n)"/>
                            <xsl:variable name="this-pers" select="$negPers//person[data(@n)=$pers-n]"/>
                            <details><summary><b><xsl:apply-templates select="$this-pers/persName/name"/></b></summary>
                                <xsl:apply-templates select="$this-pers/note[data(@xml:lang)='span']"/><br/></details>
                        </xsl:for-each-group>   </p></details>     </xsl:if>
                    
                    <xsl:if test=".//placeName">
                        <details><summary><span class="title"><b>Lugares</b></span></summary> <i>Haga clic en cada lugar para ampliar/contraer</i>
                            <p>
                                <xsl:for-each-group select=".//placeName" group-by="data(@n)">
                                    <xsl:variable name="place-n" select="./data(@n)"/>
                                    
                                    <xsl:variable name="this-place" select="$negPlace//place[data(@n)=$place-n]"/>
                                    <details><summary><b><xsl:apply-templates select="$this-place/concat
                                        (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></b></summary>
                                        <xsl:apply-templates select="$this-place/note[data(@xml:lang)='span']"/><br/>
                                        <a href="{$this-place/note[data(@type)='map-link']}" target="_blank" rel="noopener noreferrer">Map (opens in new tab)</a>
                                    </details>
                                </xsl:for-each-group>   </p></details>     </xsl:if>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="head" mode="Z-head">
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    <xsl:template match="rdg[@wit[not(contains(., 'Z'))]]" mode="Z-rdg"/>
    <!--whc: this suppresses non-Z rdg elements when called for by mode to create Z text-->
    

    
    <xsl:template match="ab" mode="Z-block">
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    

    
        <xsl:template match="bibl" mode="eng">
            <p><b>Editor(s): </b> <xsl:apply-templates select="editor"/></p> 
            <p><b>Publication title: </b><i><xsl:value-of select="title"/></i></p>
            <p><b>Publisher: </b><xsl:value-of select="publisher"/></p>
            <p><b>Publisher location: </b><xsl:value-of select="pubPlace"/></p>
            <p><b>Publication date: </b><xsl:value-of select="date"/></p>
            <p><b>Page range: </b><xsl:value-of select="biblScope"/></p>
            <p><b>Notes: </b><i><xsl:value-of select="note[@xml:lang='eng']"/></i></p>     
    </xsl:template>
    <xsl:template match="bibl" mode="span">
            <p><b>Editor(es): </b><xsl:apply-templates select="editor"/></p> 
        <p><b>Título de publicación: </b><i><xsl:value-of select="title"/></i></p>
        <p><b>Editorial: </b><xsl:value-of select="publisher"/></p>
        <p><b>Lugar de publicación: </b><xsl:value-of select="pubPlace"/></p>
        <p><b>Fecha de publicación: </b><xsl:value-of select="date"/></p>
        <p><b>Intervalo de página: </b><xsl:value-of select="biblScope"/></p>
            <p><b>Notas: </b><i><xsl:value-of select="note[@xml:lang='span']"/></i></p>     
    </xsl:template>

    <xsl:template match="div//persName" mode="#all">
      <u><span class="pers"><xsl:apply-templates/></span></u>  
   </xsl:template>
    
    <xsl:template match="term" mode="#all">
        <b><span class="term"><xsl:apply-templates/></span></b>
    </xsl:template>
    
    <xsl:template match="placeName" mode="#all">
        <i><span class="place"><xsl:apply-templates/></span></i>
    </xsl:template>
    <!--whc 17-FEB-2023: mode="#all" is necessary to get template rules to match on descendant nodes
        of nodes controlled at a higher level with modal XSLT. -->

</xsl:stylesheet>