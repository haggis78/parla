<?xml version="1.0" encoding="UTF-8"?>
<!-- whc 31-JUL-2023: This is a separate version of the XSLT using the div formatting proposed by Nicole S at ILiADS. -->
<!-- WHC 09-FEB-2023: The purpose for this XSLT is to create a display version of each edition 
    IN TWO PARALLEL COLUMNS as an html file. 
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
    <xsl:variable name="negreteFiles" select="collection('../XML/negrete-1803/?select=*.xml')"/>
    <xsl:variable name="negText" select="document('../XML/negrete-1803/spanish.xml')"/>
    <xsl:variable name="negTrans" select="document('../XML/negrete-1803/english.xml')"/>
    <xsl:variable name="Lex" select="document('../XML/auth-files/lexicon.xml')"/>
    <xsl:variable name="Pers" select="document('../XML/auth-files/persons.xml')"/>
    <xsl:variable name="Place" select="document('../XML/auth-files/locations.xml')"/>

    <xsl:strip-space elements="app"/>   <!-- whc: 01-AUG-2023: prevents adding extra whitespace after app elements when punctuation follows -->
    
    <xsl:template match="$negText">
            <xsl:result-document method="xhtml" indent="yes" href="../site/negrete-1803/spanish-comparison.html"> 
                <html lang="es" class="notranslate" translate="no">
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                        <meta name="google" content="notranslate"/>
                        <link rel="stylesheet" type="text/css" href="../css/style.css" />
                        <title>Negrete: Comparación de Textos</title>
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
                                        <a href="../negrete-1803/text-trans-notes.html">Translation</a>
                                        <a href="../negrete-1803/spanish-comparison.html">Comparison of Editions</a>                
                                    </div>
                                </div>      
                                
                                <a href="about.html">About</a>
                                
                                <div class="dropdown">
                                    <button class="dropbtn">Resources</button>
                                    <div class="dropdown-content">
                                        <a href="../resources/students.html">For students</a>
                                        <a href="../resources/educators.html">For educators</a>
                                        <a href="../resources/scholars.html">For scholars</a>
                                    </div>                                 
                                </div>
                            </div>
                            <div class="footer"></div>  
                        </div>
                        
                        <div class="content"><div class="indent">
                           <h1>Negrete 1803</h1>
                            
                            <div class="responsive-two-column-grid">

                                <div><h2>Textual Comparison</h2></div>
                                <div><h2>Comparación de Textos</h2></div>
                                
                                
                                <div><p>The Parlamento of Negrete of 1803 has been published twice. The first publication was undertaken
                                    by Corporación Ayún, a Mapuche group. More recently, a new edition was published by José Manuel Zavala Cepeda.</p></div>   
                                <div><p>El Parlamento de Negrete de 1803 cuenta con dos publicaciones. La primera publicación fue realizada por la Corporación Ayún, una agrupación Mapuche, y la segunda publicación corresponde a una nueva edición llevada a cabo más recientemente por José Manuel Zavala Cepeda.</p>          </div>                                  
      
                                <div><p>The Ayun version updated the original spelling, punctuation, and grammar for easier reading by a modern audience, while the Zavala edition was a more literal transcription of the text as it appears in the archival documents. Zavala's text is thus appropriate for 
                                    scholarly purposes. Moreover, several paragraphs of the original text were omitted entirely from the Corporación Ayún edition. Therefore, the 
                                    English translation that appears on this site was completed using Zavala's as the base text.</p></div>
                                <div><p>La versión realizada por la Corporación Ayún contiene actualizaciones de ortografía, puntuación y gramática originales con el propósito de facilitarle al público moderno la lectura de ésta, mientras que la edición de Zavala se trata de una trascripción más literal del texto tal como aparece en los documentos de archivo. Este último, es más apropiado para propósitos académicos, ya que varios párrafos del texto original se omitieron por completo en la edición de la Corporación Ayún. Por lo tanto, la traducción al inglés que se incluye en este sitio se finalizó utilizando la edición de Zavala como texto de partida.</p></div>                                
                                
                                <div><p>The page below includes the Zavala and Corporación Ayún editions in parallel columns to allow readers to examine the differences between
                                    the two versions. To facilitate comparative reading, the passages where they differ are shown in <span class="variant">dark red</span>.
                                    Most significantly, the Corporación Ayún editors added or expanded some headings that do not appear in the surviving archival documents, and also
                                    omitted a long section of text (more than one full page's worth in the Zavala edition) that does appear in the documents.</p></div>
                                <div><p>La página a continuación incluye las ediciones de Zavala y de la Corporación Ayún presentadas en columnas paralelas para que el lector pueda apreciar las diferencias entre las dos versiones. Con el fin de facilitar una lectura comparativa, se han marcado de color <span class="variant">rojo oscuro</span> las diferencias entre las dos secciones. Cabe destacar que en la edición de la Corporación Ayún aparecen algunos títulos adicionales o ampliados que no son parte de los documentos de archivo que se conservan, además de la omisión de extensas secciones de texto que aparecen en los documentos originales (el equivalente de más de una página completa en la edición realizada por Zavala).</p></div>                                

                                <div><p>A casual glance will show a great many smaller discrepancies between the versions, but readers should not immediately infer that the Corporación Ayún
                                    edition is as inaccurate as it may seem. First, many of the discrepancies relate to the Corporación Ayún editors' decision to 
                                    modernize spelling, including in the use of accent marks. This is not an error; it was a legitimate editorial choice, and Zavala simply
                                    made a different legitimate editorial choice. Second, the nature of the TEI XML encoding on which this comparison is built
                                    often required several words to be tagged together as a divergence between the two versions, even when there is only a small change in a single
                                    word. This is especially the case where a group of words are tagged as a term, a personal name, or a place name: it was more
                                    straightforward to tag the string of words as a variant reading rather than to tag only one word or a few letters. Any reader wishing to 
                                    analyze the Corporación Ayún editors' work will need to decide what is of importance to them and to compare the texts in detail.</p></div>
                                <div><p>A primera vista se aprecian algunas diferencias menores entre las versiones, pero el lector no debería suponer de forma inmediata que la edición de la Corporación Ayún es inexacta como podría parecer. En primer lugar, muchas de las diferencias se relacionan con la decisión de los editores de la Corporación Ayún de modernizar la ortografía, incluyendo el uso de acentos. Esto no es un error, fue una decisión editorial válida y Zavala simplemente tomó una decisión editorial válida diferente. En segundo lugar, la naturaleza de la codificación de texto TEI XML que se utilizó para crear esta comparación requiere, por lo general, de varias palabras etiquetadas a la vez como una separación entre las dos versiones, incluso cuando solamente hay un pequeño cambio en una sola palabra. Este es el caso, especialmente, cuando se etiqueta un grupo de palabras como un término, un nombre personal, o un nombre de un lugar: era más sencillo etiquetar una cadena de palabras como una variación de lectura que etiquetar solamente una palabra o unas pocas letras. Todo lector que desee analizar el trabajo de los editores de la Corporación Ayún tendrá que decidir lo que es más importante y comparar los textos detalladamente.</p></div>                               
                            </div>
                           
                            <hr/>    
                            <h3 id="skip">Pase a la sección:<xsl:text>   </xsl:text>
                            <xsl:for-each select="//body/div">
                                <a href="#sect-{data(@n)}"><xsl:value-of select='data(@n)'/></a>  
                                <xsl:text>   </xsl:text>
                            </xsl:for-each></h3>
                            
                            <div class="responsive-two-column-grid" id="document">
                                
                                    <div><h2>Texto: Zavala</h2></div>
                                    <div><h2>Texto: Corporación Ayún</h2></div>
                                
                                    <div><xsl:apply-templates select="//bibl[data(@xml:id)='Z']"/></div>
                                    <div><xsl:apply-templates select="//bibl[data(@xml:id)='A']"/></div>
                                
                                <div><hr/></div><div><hr/></div>
                                
                                <xsl:apply-templates select="//body/div"/>
                            </div>
                            </div>  
                        </div>
                    </body>
                </html>
            </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div">
        
            <xsl:if test="not(@n)"><!--whc 19-JUN-2023: This is so head divs that only appear in A (the editorial insertions),
                which will not be numbered, do not include an id="sect-" attribute and value on them, and will include a note explaining
                the absence of text from the Z column.--> 
                <div><p>[trans to Span:] <i>A heading not in the original document was inserted here by the Ayun editors only.</i></p></div>
                    <div><xsl:apply-templates select="head" mode="A-head"/></div>
                </xsl:if>
        
            <xsl:if test="@n">
                    
                        <xsl:if test="./head">
                            <div id="sect-{data(@n)}">
                        <p><b>[&#167;<xsl:value-of select="data(@n)"/>]
                                 <xsl:apply-templates select="head" mode="Z-head"/></b></p></div>
                        <div><p><b>[&#167;<xsl:value-of select="data(@n)"/>]
                                <xsl:apply-templates select="head" mode="A-head"/></b></p></div>
                        </xsl:if>
                
                      <xsl:if test="./ab">
                          <div id="sect-{data(@n)}">
                      <p><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>
                      <xsl:apply-templates select="ab" mode="Z-block"/> </p></div>
                      <div><p><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>
                      <xsl:apply-templates select="ab" mode="A-block"/> </p></div>
                      </xsl:if>   
                  
             </xsl:if>
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
        <p><b>Editor(es): </b><xsl:apply-templates select="editor"/></p> 
        <p><b>Título de publicación: </b><i><xsl:value-of select="title"/></i></p>
        <p><b>Editorial: </b><xsl:value-of select="publisher"/></p>
        <p><b>Lugar de publicación: </b><xsl:value-of select="pubPlace"/></p>
        <p><b>Fecha de publicación: </b><xsl:value-of select="date"/></p>
        <p><b>Intervalo de página: </b><xsl:value-of select="biblScope"/></p>
      
    </xsl:template>
    
    <xsl:template match="rdg" mode="#all">
        <span class="variant"><xsl:apply-templates/></span>
    </xsl:template>
    <!--whc 17-FEB-2023: mode="#all" is necessary to get template rules to match on descendant nodes
        of nodes controlled at a higher level with modal XSLT. -->
    
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
