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
    <xsl:variable name="negIntro" select="document('../XML/negrete-1803/intro.xml')"/>
    <xsl:variable name="Lex" select="document('../XML/auth-files/lexicon.xml')"/>
    <xsl:variable name="Pers" select="document('../XML/auth-files/persons.xml')"/>
    <xsl:variable name="Place" select="document('../XML/auth-files/locations.xml')"/>
    <xsl:variable name="negNotes" select="document('../XML/negrete-1803/negrete-notes.xml')"/>
    <xsl:strip-space elements="app"/>   <!-- whc: 01-AUG-2023: prevents adding extra whitespace after app elements when punctuation follows -->
    
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
                                    <button class="dropbtn">Parlamento 1803</button>
                                    <div class="dropdown-content">
                                        <a href="../negrete-1803/text-trans-notes.html">Translation</a>
                                        <a href="../negrete-1803/spanish-comparison.html">Comparison of Editions</a>                
                                    </div>
                                </div>      
                                
                                <a href="../about.html">About</a>
                                
                                <div class="dropdown">
                                    <button class="dropbtn">Resources</button>
                                    <div class="dropdown-content">
                                        <a href="../resources/eng-glossary.html">Glossary</a>
                                        <a href="../resources/geography.html">Geography and Maps</a>
                                    </div>                                 
                                </div>
                            </div>
                            <div class="footer"></div>  
                        </div>
                        
                        <div class="content">
                            <div class="indent">
                            <h1><xsl:apply-templates select="$negText//titleStmt/title"/></h1>
                            <hr/>
                                <h2 id="introduction">Introduction</h2>
                           
                                <div class="responsive-two-column-grid-unequal">
                                    <div><xsl:for-each select="$negIntro//body//p">
                                        <p><xsl:apply-templates/></p>
                                    </xsl:for-each>
                                        </div>
                                    <div><h2>Annotations</h2>
                                        <div class="notes">
                                            <i><a href="#text">Click here to skip down to text and translation</a></i><br/><br/>
                                                    <i>Click each triangle below to expand/collapse note</i><br/>
 
                                                    <xsl:if test="$negIntro//body//term">
                                                    <h3><b>Terms</b></h3> <!--whc 01-AUG-2023: This is now set up to give the Spanish term or an untranslated term in italics; the English term not in italics, if it has been translated; 
                                                            and the English definition. It has NOT been copied over to the XSLT making a table structure page. -->
                                                        <xsl:for-each-group select="$negIntro//body//term" group-by="data(@n)">
                                                        <xsl:variable name="term-n" select="./data(@n)"/>
                                                        <xsl:variable name="sense-n" select="./data(@select)"/>
                                                        <xsl:variable name="this-term-span" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
                                                        <xsl:variable name="this-term-eng" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']"/>
                                                        <details><summary><b><span class="term">
                                                            <xsl:if test="@type='untrans'"><i><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></i></xsl:if>
                                                            <xsl:if test="not(@type='untrans')"><xsl:apply-templates select="$this-term-eng//string-join(./orth, '; ')"/>
                                                                <xsl:text> / </xsl:text>
                                                                <i><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></i></xsl:if>
                                                        </span></b></summary>
                                                            <i><xsl:apply-templates select="$this-term-span//pos"/></i> <xsl:text>. </xsl:text>
                                                            <!--whc 27-JUN-2023: The next two lines allow us to choose from among multiple <sense> definitions. A <term> in the XML can have a @select attribute which tells it which <sense n=""> we want to call for in this instance. If there is no @select attribute, it defaults to <sense n="1">. -->
                                                            <xsl:if test="@select"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=$sense-n]"/></xsl:if>
                                                            <xsl:if test="not(@select)"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=1]"/></xsl:if>
                                                            <br/></details>
                                                    </xsl:for-each-group>        </xsl:if>
                                                
                                                    <xsl:if test="$negIntro//body//persName">
                                                    <h3><b>Persons</b></h3>
                                                        <xsl:for-each-group select="$negIntro//body//persName" group-by="data(@n)">
                                                        <xsl:variable name="pers-n" select="./data(@n)"/>
                                                        <xsl:variable name="this-pers" select="$Pers//person[data(@n)=$pers-n]"/>
                                                        <details><summary><b><span class="pers"><xsl:apply-templates select="$this-pers/persName/name"/></span></b></summary>
                                                            <xsl:apply-templates select="$this-pers//note[data(@xml:lang)='eng']/p"/><br/></details>
                                                    </xsl:for-each-group>        </xsl:if>
                                                
                                                    <xsl:if test="$negIntro//body//placeName">
                                                    <h3><b>Places</b> [<a href="../resources/geography.html#negrete-map" target="_blank">Map</a>]</h3>
                                                        <xsl:for-each-group select="$negIntro//body//placeName" group-by="data(@n)">
                                                        <xsl:variable name="place-n" select="./data(@n)"/>
                                                        <xsl:variable name="this-place" select="$Place//place[data(@n)=$place-n]"/>
                                                        <details><summary><b><span class="place"><xsl:apply-templates select="$this-place/concat
                                                            (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></span></b></summary>
                                                            <xsl:apply-templates select="$this-place/note[data(@xml:lang)='eng']"/><br/>
                                                        </details>
                                                    </xsl:for-each-group>        </xsl:if>
                                                
                                                <!--whc 01-AUG-2023: this enables notes on the intro text (category 4 in the sidebar) and has not been duplicated on the XSLT using the HTML table format.-->                                                
                                                    <xsl:if test="$negIntro//body//span">
                                                    <h3><b>Notes</b></h3>
                                                        <xsl:for-each select="$negIntro//body//span">
                                                        <xsl:variable name="note-id" select="./data(@corresp)"/>
                                                        <xsl:variable name="this-note" select="$negNotes//div[@n='0']/interp[data(@corresp)=$note-id]"/>
                                                        <xsl:variable name="note-number" select="count(preceding::span[@corresp]) + 1"/>
                                                        <details><summary><b><span class="note"><sup><xsl:value-of select="$note-number"/></sup>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:apply-templates select="$note-id!replace(.,'_',' ')"/></span></b></summary>
                                                            <xsl:apply-templates select="$this-note!string()"/><br/></details>
                                                    </xsl:for-each>        
                                                </xsl:if>  
                                        </div> </div>
                                </div>
                            <hr/>
                                <h2 id="text"><xsl:text>Text and Translation</xsl:text></h2>
                            
                            <h3 id="skip">Skip to section:<xsl:text>   </xsl:text>
                                <xsl:for-each select="$negText//body/div[@n]">
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
                                        <p><b>Note:</b> The Spanish text has been published in multiple versions. See <a href="spanish-comparison.html">this page</a> for a comparison of the versions.</p>
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
                                        <xsl:for-each select="$negNotes//respStmt">
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
                                            
                                            <xsl:if test="./ab">
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
                                                    or $negTrans//div[data(@n)=$div-n]//placeName
                                                    or $negTrans//div[data(@n)=$div-n]//span[@corresp]">
                                                    <!--whc 24-JUN-2023: needed to use xpath from translation to test for term/persName/placeName because otherwise it would call for them if they appeared in the Spanish in Ayun but not Zavala. Also occasionally a name etc is inserted into the translation for clarity even if it does not occur in the Spanish. Ditto all the filepaths for the if tests and for-each-group selects that follow. This is not in the Zavala-Ayun comparison XSLT as it is not needed there, so these are simpler there. This might not be needed either in  an XSLT in the future that runs from a single-witness Spanish source XML, except for the possibility of some names etc that had been inserted in the translation for clarity.-->
                                                    <p><b>[&#167;<xsl:value-of select="data(@n)"/>]</b><xsl:text>  </xsl:text>
                                                        <i>Click each triangle to expand/collapse note</i><br/>
                                                        <a href="#">Top of page</a><xsl:text> | </xsl:text><a href="#document">Top of text</a></p>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//term">
                                                        <h3><b>Terms</b></h3> <!--whc 01-AUG-2023: This is now set up to give the Spanish term or an untranslated term in italics; the English term not in italics, if it has been translated; 
                                                            and the English definition. It has NOT been copied over to the XSLT making a table structure page. -->
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//term" group-by="data(@n)">
                                                            <xsl:variable name="term-n" select="./data(@n)"/>
                                                            <xsl:variable name="sense-n" select="./data(@select)"/>
                                                            <xsl:variable name="this-term-span" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
                                                            <xsl:variable name="this-term-eng" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']"/>
                                                            <details><summary><b><span class="term">
                                                                <xsl:if test="@type='untrans'"><i><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></i></xsl:if>
                                                                <xsl:if test="not(@type='untrans')"><xsl:apply-templates select="$this-term-eng//string-join(./orth, '; ')"/>
                                                                    <xsl:text> / </xsl:text>
                                                                    <i><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></i></xsl:if>
                                                            </span></b></summary>
                                                                <i><xsl:apply-templates select="$this-term-span//pos"/></i> <xsl:text>. </xsl:text>
                                                                <!--whc 27-JUN-2023: The next two lines allow us to choose from among multiple <sense> definitions. A <term> in the XML can have a @select attribute which tells it which <sense n=""> we want to call for in this instance. If there is no @select attribute, it defaults to <sense n="1">. -->
                                                                <xsl:if test="@select"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=$sense-n]"/></xsl:if>
                                                                <xsl:if test="not(@select)"><xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='eng']/sense[data(@n)=1]"/></xsl:if>
                                                                <br/></details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//persName">
                                                        <h3><b>Persons</b></h3>
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//persName" group-by="data(@n)">
                                                            <xsl:variable name="pers-n" select="./data(@n)"/>
                                                            <xsl:variable name="this-pers" select="$Pers//person[data(@n)=$pers-n]"/>
                                                            <details><summary><b><span class="pers"><xsl:apply-templates select="$this-pers/persName/name"/></span></b></summary>
                                                                <xsl:apply-templates select="$this-pers//note[data(@xml:lang)='eng']/p"/><br/></details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    
                                                    <xsl:if test="$negTrans//div[data(@n)=$div-n]//placeName">
                                                        <h3><b>Places</b> [<a href="../resources/geography.html#negrete-map" target="_blank">Map</a>]</h3>
                                                        <xsl:for-each-group select="$negTrans//div[data(@n)=$div-n]//placeName" group-by="data(@n)">
                                                            <xsl:variable name="place-n" select="./data(@n)"/>
                                                            <xsl:variable name="this-place" select="$Place//place[data(@n)=$place-n]"/>
                                                            <details><summary><b><span class="place"><xsl:apply-templates select="$this-place/concat
                                                                (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></span></b></summary>
                                                                <xsl:apply-templates select="$this-place/note[data(@xml:lang)='eng']"/><br/>
                                                            </details>
                                                        </xsl:for-each-group>        </xsl:if>
                                                    
                                       <!--whc 01-AUG-2023: this enables notes (category 4 in the sidebar) and has not been duplicated on the XSLT using the HTML table format.-->                                                
                                                <xsl:if test="$negTrans//div[data(@n)=$div-n]//span">
                                                    <h3><b>Notes</b></h3>
                                                    <xsl:for-each select="$negTrans//div[data(@n)=$div-n]//span">
                                                        <xsl:variable name="note-id" select="./data(@corresp)"/>
                                                        <xsl:variable name="this-note" select="$negNotes//div[data(@n)=$div-n]/interp[data(@corresp)=$note-id]"/>
                                                        <xsl:variable name="note-number" select="count(preceding-sibling::span[@corresp]) + 1"/>
                                                        <details><summary><b><span class="note"><sup><xsl:value-of select="$note-number"/></sup>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:apply-templates select="$note-id!replace(.,'_',' ')"/></span></b></summary>
                                                            <xsl:apply-templates select="$this-note!string()"/><br/></details>
                                                    </xsl:for-each>        
                                                </xsl:if>  
                                                    <!--<a class="top-btn" href="#">Top of page</a><a class="top-btn" href="#document">Top of text</a>-->
                                                </xsl:if>
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
        <span class="pers"><xsl:apply-templates/></span>  
   </xsl:template>
    
    <xsl:template match="body//term[not(@type='untrans')]" mode="#all">
        <span class="term"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="body//term[@type='untrans']" mode="#all">
        <span class="term"><i><xsl:apply-templates/></i></span>
    </xsl:template>  
  
    <xsl:template match="body//placeName" mode="#all">
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template> 

    <!--whc 01-AUG-2023: this enables notes on the translation (category 4 in the sidebar) and has not been duplicated on the XSLT using the HTML table format.-->                                                
    <xsl:template match="body//div//span[@corresp]" mode="#all">
        <xsl:for-each-group select="." group-by="@corresp">
                <xsl:if test="not(../p)"><xsl:variable name="note-number" select="count(preceding-sibling::span[@corresp]) + 1"/>
                    <xsl:apply-templates/>
                    <sup><b><xsl:value-of select='$note-number'/></b></sup>
                </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="$negIntro//body//div//span[@corresp]"><!--whc 19-SEP-2023: this does the numbered notes on the intro only. The stylesheet works just fine but throws an "Ambiguous rule match" message.-->
        <xsl:for-each-group select="." group-by="@corresp">
            <xsl:variable name="note-number" select="count(preceding::span[@corresp]) + 1"/>
                    <xsl:apply-templates/>
                    <sup><b><xsl:value-of select='$note-number'/></b></sup>
        </xsl:for-each-group>
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
