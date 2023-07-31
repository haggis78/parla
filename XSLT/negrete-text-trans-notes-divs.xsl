<?xml version="1.0" encoding="UTF-8"?>

<!-- WHC 27-JUN-2023: When running this XSLT in oXygen, the Spanish file MUST be open and selected as the input XML -->

<!-- WHC 31-JUL-2023: The purpose for this XSLT is to create a display version with Zavala and English translation 
    in parallel columns as an html file, with a third column for notes. It does so using responsive divs, NOT a table layout. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    
    <xsl:variable name="negreteFiles" select="collection('../XML/negrete-1803/?select=*.xml')"/>
    <xsl:variable name="negText" select="document('../XML/negrete-1803/spanish.xml')"/>
    <xsl:variable name="negTrans" select="document('../XML/negrete-1803/english.xml')"/>
    <xsl:variable name="Lex" select="document('../XML/auth-files/lexicon.xml')"/>
    <xsl:variable name="Pers" select="document('../XML/auth-files/persons.xml')"/>
    <xsl:variable name="Place" select="document('../XML/auth-files/locations.xml')"/>
    <xsl:variable name="negNotes" select="document('../XML/negrete-1803/negrete-notes.xml')"/>
<!--    <xsl:strip-space elements="*"/>   whc: 27-JUN-2023: this seems to be causing spacing problems and not solving them -->
    
    <xsl:template match="$negText">
        <xsl:result-document method="xhtml" indent="yes" href="../site/negrete-1803/text-trans-notes.html">
                <html lang="en" class="notranslate" translate="no">
                    <head>
                        <meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
                        <meta name="google" content="notranslate"/>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <link rel="stylesheet" type="text/css" href="../css/style.css" />
                        <title>Negrete 1803: Translation</title>
                    </head>
                    <body>
                        
                        <div class="header">
                            <div class="figure">
                                <a href="../index.html">
                                    <img src="../images/parla-logo.png" class="image-main" alt="Parlamentos logo" width="210"/>
                                    <img src="../images/parla-logo-blue.png" class="image-hover" alt="Parlamentos logo" width="210"/></a>
                            </div>        
                        </div>
                        
                        <!-- navbar -->
                        <div id="navbar">
                            <div class="navbar">
                                
                                <a href="../index.html">Home</a>
                                
                                <div class="dropdown">
                                    <button class="dropbtn">The Parlamentos</button>
                                    <div class="dropdown-content">
                                        <a href="1803.html">Parlamento 1803</a>
                                        <a href="1804.html">Parlamento 1804</a>
                                        <a href="1805.html">Parlamento 1805</a>                 
                                    </div>
                                </div>      
                                
                                <a href="about.html">About</a>
                                
                                <div class="dropdown">
                                    <button class="dropbtn">Resources</button>
                                    <div class="dropdown-content">
                                        <a href="students.html">For students</a>
                                        <a href="educators.html">For educators</a>
                                        <a href="scholars.html">For scholars</a>
                                    </div>                                 
                                </div>
                            </div>
                            <div class="footer"></div>  
                        </div>
                        
                        <div class="content">
                            <div class="indent">
                            <h1><xsl:apply-templates select="$negText//titleStmt/title"/></h1>
                            <hr/>
                                <h2>Introduction</h2>
                            <a href="#text"><p>Skip down to text and translation</p></a>
                            <p>Para 1 of essay</p>
                            <p>Para 2</p>
                            <p>Para 3</p>
                            <p>Para 4</p>
                            <p>Para 5</p>
                            <p>Notes to introduction</p>
                            <hr/>
                                <h2 id="text"><xsl:text>Text and Translation</xsl:text></h2>
                            <p>Note: The Spanish text has been published in multiple versions. See <a href="spanish-comparison.html">this page</a> for a comparison of the versions.</p>
                            <h3 id="skip">Skip to section:<xsl:text>   </xsl:text>
                                <xsl:for-each select="$negText//body/div">
                                    <a href="#sect-{data(@n)}"><xsl:value-of select='data(@n)'/></a>  
                                    <xsl:text>   </xsl:text>
                                </xsl:for-each>
                            </h3>
                            
                            <div class="responsive-three-column-grid" id="document">
                                
                                    <div>
                                        <h2>Source bibliography</h2>
                                        <p><b>Editor: </b><xsl:apply-templates select="//bibl[data(@xml:id)='Z']/editor"/></p> 
                                        <p><b>Publication title: </b><i><xsl:value-of select="//bibl[data(@xml:id)='Z']/title"/></i></p>
                                        <p><b>Publisher: </b><xsl:value-of select="//bibl[data(@xml:id)='Z']/publisher"/></p>
                                        <p><b>Place of publication: </b><xsl:value-of select="//bibl[data(@xml:id)='Z']/pubPlace"/></p>
                                        <p><b>Date of publication: </b><xsl:value-of select="//bibl[data(@xml:id)='Z']/date"/></p>
                                        <p><b>Page range: </b><xsl:value-of select="//bibl[data(@xml:id)='Z']/biblScope"/></p>
                                        <p><b>Notes: </b><i><xsl:value-of select="//bibl[data(@xml:id)='Z']/note[@xml:lang='eng']"/></i></p>
                                        </div>
                                    <div>
                                       <h2>Digital metadata</h2>
                                        <h3>Spanish text</h3>
                                        <xsl:for-each select="$negText//respStmt">
                                            <p><b><xsl:apply-templates select="./resp"/></b> <xsl:text> by</xsl:text></p>
                                            <p><xsl:apply-templates select="string-join(persName, ' and ')"/>
                                            </p>
                                        </xsl:for-each>
                                        <h3>English text</h3>
                                        <xsl:for-each select="$negTrans//respStmt">
                                            <p><b><xsl:apply-templates select="./resp"/></b> <xsl:text> by</xsl:text></p>
                                            <p><xsl:apply-templates select="string-join(persName, ' and ')"/>
                                            </p>
                                        </xsl:for-each>
                                       
                                    </div>
                                    <div>
                                        <h2>Research and notes</h2>
                                        <xsl:for-each select="$Lex//respStmt">
                                            <p><b><xsl:apply-templates select="./resp"/></b> <xsl:text> by</xsl:text></p>
                                            <p><xsl:apply-templates select="string-join(persName, ' and ')"/>
                                            </p>
                                        </xsl:for-each>
                                        <xsl:for-each select="$Pers//respStmt">
                                            <p><b><xsl:apply-templates select="./resp"/></b> <xsl:text> by</xsl:text></p>
                                            <p><xsl:apply-templates select="string-join(persName, ' and ')"/>
                                            </p>
                                        </xsl:for-each>
                                        <xsl:for-each select="$Place//respStmt">
                                            <p><b><xsl:apply-templates select="./resp"/></b> <xsl:text> by</xsl:text></p>
                                            <p><xsl:apply-templates select="string-join(persName, ' and ')"/>
                                            </p>
                                        </xsl:for-each>
                                        
                                    </div>
                                
                                <div><h2>Text: Zavala Edition</h2></div>
                                    <div><h2>Text: English Translation</h2></div>
                                    <div><h2>Annotations</h2></div>

                                <xsl:for-each select=".//div"> <!--whc 24-May-2023: while <xsl:apply-templates select="$negText//body/div"/> approach was used in the XSLT for two columns of Spanish versions, I've needed to switch to an xsl:for-each loop here to be able to pull both the Zavala text from the Spanish XML and the corresponding English divs from that separate XML file. -->
                                    <xsl:if test="@n"><!--whc: to screen out any divs that only appear in Ayun, which will have no numbers in the Spanish XML file-->
                                    <xsl:variable name="div-n" select="./data(@n)"/>
                                    <xsl:variable name="this-div-eng" select="$negTrans//body/div[data(@n)=$div-n]"/>
                                    
                                            <xsl:if test="./head">
                                                <div id="sect-{$div-n}"><p><b>[&#167;<xsl:value-of select="data(@n)"/>]
                                                <xsl:apply-templates select="head" mode="Z-head"/></b></p></div>
                                                <div><p><b>[&#167;<xsl:value-of select="data(@n)"/>]  
                                                <xsl:apply-templates select="$negTrans//div[data(@n)=$div-n]/head"/></b></p></div>
                                            </xsl:if>
                                            
                                            <xsl:if test="./ab"> <!--whc 27-JUN-2023: @class="text" is to distinguish the text columns from the notes column so I can use CSS to style them separately-->
                                                <div id="sect-{$div-n}"><p><b>[&#167;<xsl:value-of select="data(@n)"/>] </b>
                                                    <xsl:apply-templates select="ab" mode="Z-block"/></p></div>
                                                <div><p><b>[&#167;<xsl:value-of select="data(@n)"/>] </b> 
                                                    <xsl:apply-templates select="$negTrans//div[data(@n)=$div-n]/ab"/></p></div>
                                            </xsl:if>
                                            
                                            <div class="notes">
                                                <xsl:if test="not(.//term or .//persName or .//placeName or .//span)">
                                                    <p><b>[&#167;<xsl:value-of select="data(@n)"/>]</b><xsl:text>  </xsl:text>
                                                    <i>No annotations on this section.</i></p><br/>
                                                    <a class="top-btn" href="#">Top of page</a><a class="top-btn" href="#document">Top of text</a>
                                                </xsl:if>
                                                
                                                <xsl:if test="$negTrans//div[data(@n)=$div-n]//term 
                                                    or $negTrans//div[data(@n)=$div-n]//persName 
                                                    or $negTrans//div[data(@n)=$div-n]//placeName">
                                                    <!--whc 24-JUN-2023: needed to use xpath from translation to test for term/persName/placeName because otherwise it would call for them if they appeared in the Spanish in Ayun but not Zavala. Also occasionally a name etc is inserted into the translation for clarity even if it does not occur in the Spanish. Ditto all the filepaths for the if tests and for-each-group selects that follow. This is not in the Zavala-Ayun comparison XSLT as it is not needed there, so these are simpler there. This might not be needed either in  an XSLT in the future that runs from a single-witness Spanish source XML, except for the possibility of some names etc that had been inserted in the translation for clarity.-->
                                                    <p><b>[&#167;<xsl:value-of select="data(@n)"/>]</b><xsl:text>  </xsl:text>
                                                        <i>Click each triangle to expand/collapse note</i></p>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//term">
                                                        <h2><b>Terms</b></h2> <!--whc 18-JUL-2023: This is currently set up to give the Spanish term and the English definition. -->
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//term" group-by="data(@n)">
                                                            <xsl:variable name="term-n" select="./data(@n)"/>
                                                            <xsl:variable name="sense-n" select="./data(@select)"/>
                                                            <xsl:variable name="this-term-span" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
                                                            <details><summary><b><span class="term"><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></span></b></summary>
                                                                <i><xsl:apply-templates select="$this-term-span//pos"/></i> <xsl:text>. </xsl:text>
                                                                <!--whc 27-JUN-2023: The next two lines allow us to choose from among multiple <sense> definitions. A <term> in the XML can have a @select attribute which tells it which <sense n=""> we want to call for in this instance. If there is no @select attribute, it defaults to <sense n="1">. -->
                                                                <xsl:if test="@select"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=$sense-n]"/></xsl:if>
                                                                <xsl:if test="not(@select)"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=1]"/></xsl:if>
                                                                <br/></details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//persName">
                                                        <h2><b>Persons</b></h2>
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//persName" group-by="data(@n)">
                                                            <xsl:variable name="pers-n" select="./data(@n)"/>
                                                            <xsl:variable name="this-pers" select="$Pers//person[data(@n)=$pers-n]"/>
                                                            <details><summary><b><span class="pers"><xsl:apply-templates select="$this-pers/persName/name"/></span></b></summary>
                                                                <xsl:apply-templates select="$this-pers/note[data(@xml:lang)='eng']"/><br/></details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//placeName">
                                                        <h2><b>Places</b></h2>
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//placeName" group-by="data(@n)">
                                                            <xsl:variable name="place-n" select="./data(@n)"/>
                                                            <xsl:variable name="this-place" select="$Place//place[data(@n)=$place-n]"/>
                                                            <details><summary><b><span class="place"><xsl:apply-templates select="$this-place/concat
                                                                (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></span></b></summary>
                                                                <xsl:apply-templates select="$this-place/note[data(@xml:lang)='eng']"/><br/>
                                                                <a href="{$this-place/note[data(@type)='map-link']}" target="_blank" rel="noopener noreferrer">Map (opens in new tab)</a>
                                                            </details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    <a class="top-btn" href="#">Top of page</a><a class="top-btn" href="#document">Top of text</a>
                                                </xsl:if>
                                                <!--      whc 26-JUL-2023: need to work this out: ready                                         
                                                <xsl:if test="$negTrans//div[data(@n)=$div-n]//span">
                                                    <h2><b>Notes</b></h2>
                                                    <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//span" group-by="data(@n)">
                                                        <xsl:variable name="note-n" select="./data(@n)"/>
                                                        <xsl:variable name="this-note" select="$negNotes//person[data(@n)=$note-n]"/>
                                                        <details><summary><b><span class="pers"><xsl:apply-templates select="$this-pers/persName/name"/></span></b></summary>
                                                            <xsl:apply-templates select="$this-pers/note[data(@xml:lang)='eng']"/><br/></details>
                                                    </xsl:for-each-group>        </xsl:if>   -->
                                            </div>                                            
                                        
                                    </xsl:if>
                                </xsl:for-each>       
                            </div>
                        </div>
                        
                        <!-- Footer -->
                        <div id="footer">
                            <div class="copyright">
                                <ul class="menu">
                                    <li>&#169; Parlamentos. All rights reserved</li>
                                    <!--whc: need to use &#169; rather than &copy; as escape character because oXygen does not recognize &copy; within XSLT-->
                                    <li>Original web design by <a href="https://www.greensburg.pitt.edu/academics/center-digital-text">the CDT at Pitt-Greensburg</a>.</li>
                                </ul>
                            </div></div>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="head" mode="Z-head"> <!--whc: this suppresses non-Z rdg elements when called for by mode to create Z text. Only necessary in Negrete 1803 as this is a 2-witness Spanish text.-->
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    <xsl:template match="ab" mode="Z-block">
        <xsl:apply-templates mode="Z-rdg"/>
    </xsl:template>
    <xsl:template match="rdg[@wit[not(contains(., 'Z'))]]" mode="Z-rdg"/>

    <xsl:template match="body//persName" mode="#all"> <!--whc 17-FEB-2023: mode="#all" is necessary to get template rules to match on descendant nodes of nodes controlled at a higher level with modal XSLT, specifically what calls for rdg elements from only one edition. -->
        <span class="pers"><xsl:apply-templates/></span><xsl:text> </xsl:text>  
   </xsl:template>
    
    <xsl:template match="body//term[not(@type='untrans')]" mode="#all">
        <span class="term"><xsl:apply-templates/></span><xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="body//term[@type='untrans']" mode="#all">
        <span class="term"><i><xsl:apply-templates/></i></span><xsl:text> </xsl:text>
    </xsl:template>  
    <!--whc 24-JUN-2023: the xsl:text is to make sure there's a space after a term, but so far it puts one there whether the next character is alphanumeric (good) or punctuation (bad). Thus there are sometimes spaces before periods and commas. -->
   
    <xsl:template match="body//placeName" mode="#all">
        <span class="place"><xsl:apply-templates/></span><xsl:text> </xsl:text>
    </xsl:template> 
    
    <xsl:template match="lb"  mode="#all"><br/></xsl:template>
    
    <xsl:template match="metamark[@rend='horizontal-line']" mode="#all"><hr/></xsl:template>
    
    <xsl:template match="table" mode="#all"><table>
        <xsl:for-each select="row">
            <tr>
                <xsl:for-each select="cell">
                    <td><xsl:apply-templates/></td>
                </xsl:for-each>
            </tr>
        </xsl:for-each>
    </table></xsl:template>
    
</xsl:stylesheet>

<!--whc 24-JUN-2023: commenting out but saving for now the variables for test versions
    <xsl:variable name="negreteFiles" select="collection('../XML/test-versions/?select=*.xml')"/>
    <xsl:variable name="negText" select="document('../XML/test-versions/negrete-test.xml')"/>
    <xsl:variable name="negTrans" select="document('../XML/test-versions/english-translation-test.xml')"/>
    <xsl:variable name="Lex" select="document('../XML/test-versions/negrete-lexicon-test.xml')"/>
    <xsl:variable name="Pers" select="document('../XML/test-versions/negrete-persons-test.xml')"/>
    <xsl:variable name="Place" select="document('../XML/test-versions/negrete-locations-test.xml')"/>   -->

<!--whc 24-JUN-2023: commenting out but saving the line to create test version
            <xsl:result-document method="xhtml" indent="yes" href="../site/negrete-1803/1803-display-2cols-z-eng.html">   -->

<!--    <xsl:template match="div">
        <tr id="sect-{data(@n)}">
            <xsl:if test="./head">
                    <th><xsl:if test="@n">[&#167;<xsl:value-of select="data(@n)"/>] </xsl:if>  
                        <xsl:apply-templates select="head" mode="Z-head"/></th>
                    <th>[&#167;<xsl:value-of select="data(@n)"/>]  
                    <xsl:apply-templates select="head" mode="Eng-head"/></th>
                <td><b>Notes</b> <i> Click on category to expand/collapse</i>
                    <a class="top-btn" href="#">Top of page</a></td>
            
        </xsl:if>  -->
<!--whc 18-FEB-2023: Notes on div/head will follow exactly the same pattern as they do on div/ab.
            Get them working perfectly on div/ab and then just copy the whole thing to div/head; or figure out a way
            to make the notes etc. their own template rule that can be called from either type of div.-->
<!--        <xsl:if test="./ab">
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
                    <xsl:variable name="this-term-span" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
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
                            <xsl:variable name="this-pers" select="$Pers//person[data(@n)=$pers-n]"/>
                            <details><summary><b><xsl:apply-templates select="$this-pers/persName/name"/></b></summary>
                                <xsl:apply-templates select="$this-pers/note[data(@xml:lang)='span']"/><br/></details>
                        </xsl:for-each-group>   </p></details>     </xsl:if>
                    
                    <xsl:if test=".//placeName">
                        <details><summary><span class="title"><b>Lugares</b></span></summary> <i>Haga clic en cada lugar para ampliar/contraer</i>
                            <p>
                                <xsl:for-each-group select=".//placeName" group-by="data(@n)">
                                    <xsl:variable name="place-n" select="./data(@n)"/>
                                    
                                    <xsl:variable name="this-place" select="$Place//place[data(@n)=$place-n]"/>
                                    <details><summary><b><xsl:apply-templates select="$this-place/concat
                                        (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></b></summary>
                                        <xsl:apply-templates select="$this-place/note[data(@xml:lang)='span']"/><br/>
                                        <a href="{$this-place/note[data(@type)='map-link']}" target="_blank" rel="noopener noreferrer">Map (opens in new tab)</a>
                                    </details>
                                </xsl:for-each-group>   </p></details>     </xsl:if>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>   -->
