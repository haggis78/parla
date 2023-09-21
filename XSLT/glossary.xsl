<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:variable name="Lex" select="document('../XML/auth-files/lexicon.xml')"/>

    <xsl:template match="$Lex">
        <xsl:result-document method="xhtml" indent="yes" href="../site/resources/eng-glossary.html">
            <html lang="en" class="notranslate" translate="no">
                <head>
                    <meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
                    <meta name="google" content="notranslate"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" type="text/css" href="../css/style.css" />
                    <title>Parlamentos Glossary</title>
                </head>
                <body>
                    <!-- header -->
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
                                    <a href="eng-glossary.html">Glossary</a>
                                    <a href="geography.html">Geography and Maps</a>
                                </div>                                 
                            </div>
                        </div>
                        <div class="footer"></div>  
                    </div>
                    
 
 
                   <div id="content"> 
                   <div class="indent"> <h1>Glossary of terms used in Parlamentos on this site</h1>
                    <h2>Introduction</h2>
                    <p>In the translation process, some of these terms have been translated into English: for example, the Spanish <i>haciendas</i> has been translated as "estates".
                        However, other Spanish words have meanings specific enough that there is no equivalent in English, so that, for example, <i>Don</i> and <i>Señor</i>
                    do not have the same sense as their closest English terms, Mr. and Sir; or they may be technical terms in Spanish, such as
                        <i>Real Hacienda</i>; or they may be words that the Spanish themselves adopted from Mapudungun, the Indigenous language
                    of the Mapuches, as colonizers have often done. This is the case for many of the words that refer to Mapuche institutions (e.g. 
                    <i>Butalmapus</i>) or social ranks (e.g. <i>Cacique</i>).</p>
                    <p>In the entries that follow, if a Spanish or Mapudungun word has been used directly in our translations, it will appear as the 
                    headword of the entry in italics. If an English word has been used to translate it, that will appear as the first headword, and then the Spanish
                    or Mapudungun word will follow in italics. Where there are multiple spellings of a word in the original documents or in 
                    different editions of the original documents, those appear in the headword of the entry separated by semicolons.</p>
                   <hr/>
                    <h2>Terms and Definitions</h2>
                    
                    <xsl:for-each select=".//superEntry[entry[data(@xml:lang)='eng']//orth[1]=>string-length() > 0]"><!--whc: predicate filters out superEntry elements that do not yet have an English word entered, since these are blank entries-->
                        <xsl:sort select="./entry[data(@xml:lang)='eng']//orth[1]!lower-case(.)"/>
                        <h3>
                            <xsl:if test="./entry[data(@xml:lang)='eng']//orth[1] ne ./entry[data(@xml:lang)='span']//orth[1]">
                                <xsl:apply-templates select="./entry[data(@xml:lang)='eng']//string-join(./orth, '; ')"/> <xsl:text> / </xsl:text>
                            <i><xsl:apply-templates select="./entry[data(@xml:lang)='span']//string-join(./orth, '; ')"/></i></xsl:if>
                            <xsl:if test="./entry[data(@xml:lang)='eng']//orth[1] eq ./entry[data(@xml:lang)='span']//orth[1]">
                                <i><xsl:apply-templates select="./entry[data(@xml:lang)='eng']//string-join(./orth, '; ')"/></i></xsl:if>
                            <xsl:text> (</xsl:text><xsl:apply-templates select="./entry[data(@xml:lang)='eng']//pos"/>.)
                        </h3>
                        <xsl:for-each select="entry[data(@xml:lang)='eng']//sense">
                            <p><b><xsl:value-of select="data(@n)"/><xsl:text>. </xsl:text></b>
                            <xsl:apply-templates select="./def"/></p>
                        </xsl:for-each>
                        <p>
                        </p>
                        
                    </xsl:for-each></div></div>
                    
                </body>
            </html></xsl:result-document>
    </xsl:template>
</xsl:stylesheet>