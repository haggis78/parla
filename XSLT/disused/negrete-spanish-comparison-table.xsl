<?xml version="1.0" encoding="UTF-8"?>
<!-- WHC 09-FEB-2023: The purpose for this XSLT is to create a display version of each edition 
    IN TWO PARALLEL COLUMNS (actually in a table element) as an html file, with a third column for notes. 
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
                        
                        <div class="content"><div class="indent">
                           <h1>Negrete 1803</h1>
                            <table>
                                <tr>
                                   
                                    <td> <h2>Textual Comparison</h2><p>The Parlamento of Negrete of 1803 has been published twice. The first publication was undertaken
                                        by Corporación Ayún, a Mapuche group. More recently, a new edition was published by José Manuel Zavala Cepeda.</p>
                                        <p>The Ayun version updated the original spelling, punctuation, and grammar for easier reading by a modern audience, while the 
                                            Zavala edition was a more literal transcription of the text as it appears in the archival documents. Zavala's text is thus appropriate for 
                                            scholarly purposes. Moreover, several paragraphs of the original text were omitted entirely from the Corporación Ayún edition. Therefore, the 
                                            English translation that appears on this site was completed using Zavala's as the base text.</p>
                                        <p>The page below includes the Zavala and Corporación Ayún editions in parallel columns to allow readers to examine the differences between
                                            the two versions. To facilitate comparative reading, the passages where they differ are shown in <span class="variant">dark red</span>.
                                            Most significantly, the Corporación Ayún editors added or expanded some headings that do not appear in the surviving archival documents, and also
                                            omitted a long section of text (more than one full page's worth in the Zavala edition) that does appear in the documents.</p>
                                        <p>A casual glance will show a great many smaller discrepancies between the versions, but readers should not immediately infer that the Corporación Ayún
                                            edition is as inaccurate as it may seem. First, many of the discrepancies relate to the Corporación Ayún editors' decision to 
                                            modernize spelling, including in the use of accent marks. This is not an error; it was a legitimate editorial choice, and Zavala simply
                                            made a different legitimate editorial choice. Second, the nature of the TEI XML encoding on which this comparison is built
                                            often required several words to be tagged together as a divergence between the two versions, even when there is only a small change in a single
                                            word. This is especially the case where a group of words are tagged as a term, a personal name, or a place name: it was more
                                            straightforward to tag the string of words as a variant reading rather than to tag only one word or a few letters. Any reader wishing to 
                                            analyze the Corporación Ayún editors' work will need to decide what is of importance to them and to compare the texts in detail.</p></td>
                                    
                                    <td> <h2>Comparación de Textos</h2><p>El Parlamento de Negrete de 1803 cuenta con dos publicaciones. La primera publicación fue realizada por la Corporación Ayún, una agrupación Mapuche, y la segunda publicación corresponde a una nueva edición llevada a cabo más recientemente por José Manuel Zavala Cepeda.</p>
                                        
                                        <p>La versión realizada por la Corporación Ayún contiene actualizaciones de ortografía, puntuación y gramática originales con el propósito de facilitarle al público moderno la lectura de ésta, mientras que la edición de Zavala se trata de una trascripción más literal del texto tal como aparece en los documentos de archivo. Este último, es más apropiado para propósitos académicos, ya que varios párrafos del texto original se omitieron por completo en la edición de la Corporación Ayún. Por lo tanto, la traducción al inglés que se incluye en este sitio se finalizó utilizando la edición de Zavala como texto de partida.</p>
                                        
                                        <p>La página a continuación incluye las ediciones de Zavala y de la Corporación Ayún presentadas en columnas paralelas para que el lector pueda apreciar las diferencias entre las dos versiones. Con el fin de facilitar una lectura comparativa, se han marcado de color <span class="variant">rojo oscuro</span> las diferencias entre las dos secciones. Cabe destacar que en la edición de la Corporación Ayún aparecen algunos títulos adicionales o ampliados que no son parte de los documentos de archivo que se conservan, además de la omisión de extensas secciones de texto que aparecen en los documentos originales (el equivalente de más de una página completa en la edición realizada por Zavala).</p>
                                        
                                        <p>A primera vista se aprecian algunas diferencias menores entre las versiones, pero el lector no debería suponer de forma inmediata que la edición de la Corporación Ayún es inexacta como podría parecer. En primer lugar, muchas de las diferencias se relacionan con la decisión de los editores de la Corporación Ayún de modernizar la ortografía, incluyendo el uso de acentos. Esto no es un error, fue una decisión editorial válida y Zavala simplemente tomó una decisión editorial válida diferente. En segundo lugar, la naturaleza de la codificación de texto TEI XML que se utilizó para crear esta comparación requiere, por lo general, de varias palabras etiquetadas a la vez como una separación entre las dos versiones, incluso cuando solamente hay un pequeño cambio en una sola palabra. Este es el caso, especialmente, cuando se etiqueta un grupo de palabras como un término, un nombre personal, o un nombre de un lugar: era más sencillo etiquetar una cadena de palabras como una variación de lectura que etiquetar solamente una palabra o unas pocas letras. Todo lector que desee analizar el trabajo de los editores de la Corporación Ayún tendrá que decidir lo que es más importante y comparar los textos detalladamente.</p></td>
                                </tr>
                            </table>
                            
                            
                            
                                <div class="responsive-three-column-grid">
                                    <div><h2>Hipster Ipsum</h2></div>
                                    <div><h2>Textual Comparison</h2></div>
                                    <div><h2>Comparación de Textos</h2></div>
                                    
                                    <div><p>Cupidatat eu marfa gluten-free ut bruh. Mlkshk XOXO tempor et ex forage squid vice heirloom hot chicken tattooed ascot. Scenester snackwave forage swag umami cupidatat pug sriracha bruh cloud bread craft beer la croix enamel pin. Vaporware gastropub jawn, art party skateboard cillum irure jean shorts viral messenger bag wolf 3 wolf moon. Proident hashtag fingerstache plaid kombucha minim in activated charcoal fixie deep v.</p></div>
                                    <div><p>The Parlamento of Negrete of 1803 has been published twice. The first publication was undertaken
                                        by Corporación Ayún, a Mapuche group. More recently, a new edition was published by José Manuel Zavala Cepeda.</p></div>   
                                    <div><p>El Parlamento de Negrete de 1803 cuenta con dos publicaciones. La primera publicación fue realizada por la Corporación Ayún, una agrupación Mapuche, y la segunda publicación corresponde a una nueva edición llevada a cabo más recientemente por José Manuel Zavala Cepeda.</p>                        
                                    </div>  
                                    
                                    <div><p>Tattooed occaecat yuccie, Brooklyn iPhone tilde ut gluten-free single-origin coffee bitters bruh voluptate qui. Cray subway tile ullamco, cloud bread jean shorts snackwave biodiesel four dollar toast shoreditch est squid cornhole. Typewriter ugh fashion axe, est meggings irony cornhole. Cillum whatever adaptogen tumeric venmo bitters listicle mukbang tonx excepteur. Eiusmod mumblecore cold-pressed tumeric, migas tilde beard non green juice ex ullamco ut veniam.</p></div>        
                                    <div><p>The Ayun version updated the original spelling, punctuation, and grammar for easier reading by a modern audience, while the Zavala edition was a more literal transcription of the text as it appears in the archival documents. Zavala's text is thus appropriate for 
                                        scholarly purposes. Moreover, several paragraphs of the original text were omitted entirely from the Corporación Ayún edition. Therefore, the 
                                        English translation that appears on this site was completed using Zavala's as the base text.</p></div>
                                    <div><p>La versión realizada por la Corporación Ayún contiene actualizaciones de ortografía, puntuación y gramática originales con el propósito de facilitarle al público moderno la lectura de ésta, mientras que la edición de Zavala se trata de una trascripción más literal del texto tal como aparece en los documentos de archivo. Este último, es más apropiado para propósitos académicos, ya que varios párrafos del texto original se omitieron por completo en la edición de la Corporación Ayún. Por lo tanto, la traducción al inglés que se incluye en este sitio se finalizó utilizando la edición de Zavala como texto de partida.</p></div>
                                    
                                    <div><p>Listicle franzen ramps do, fashion axe scenester prism qui dolore tumeric next level. Waistcoat letterpress dolor four loko vaporware 90's tempor sus af marxism poke viral single-origin coffee jawn gastropub. Gentrify viral meh, fugiat kale chips voluptate cardigan meditation brunch la croix blue bottle taiyaki aliquip vice dolore. Salvia deep v cliche ullamco YOLO 3 wolf moon hammock 90's single-origin coffee excepteur godard yuccie roof party.</p></div>                                        
                                    <p>The page below includes the Zavala and Corporación Ayún editions in parallel columns to allow readers to examine the differences between
                                        the two versions. To facilitate comparative reading, the passages where they differ are shown in <span class="variant">dark red</span>.
                                        Most significantly, the Corporación Ayún editors added or expanded some headings that do not appear in the surviving archival documents, and also
                                        omitted a long section of text (more than one full page's worth in the Zavala edition) that does appear in the documents.</p>
                                    <p>La página a continuación incluye las ediciones de Zavala y de la Corporación Ayún presentadas en columnas paralelas para que el lector pueda apreciar las diferencias entre las dos versiones. Con el fin de facilitar una lectura comparativa, se han marcado de color <span class="variant">rojo oscuro</span> las diferencias entre las dos secciones. Cabe destacar que en la edición de la Corporación Ayún aparecen algunos títulos adicionales o ampliados que no son parte de los documentos de archivo que se conservan, además de la omisión de extensas secciones de texto que aparecen en los documentos originales (el equivalente de más de una página completa en la edición realizada por Zavala).</p>


                                    <div><p>In esse kickstarter gluten-free, aliquip 90's etsy cray dolore ex tote bag jean shorts asymmetrical. Jean shorts distillery organic, ea tote bag adaptogen raclette. Nostrud hoodie bushwick fam ramps 90's kickstarter polaroid irure direct trade narwhal neutra sus yes plz. Yr DIY affogato ugh hammock listicle minim ramps whatever blue bottle elit. Man bun helvetica excepteur twee hashtag vegan edison bulb tofu fit cornhole tumblr 90's. Four dollar toast dolor twee viral, meditation umami gorpcore tattooed austin synth kombucha chia pop-up proident. Neutral milk hotel duis cold-pressed dolor church-key heirloom butcher tempor. Normcore mixtape iceland, gastropub narwhal duis excepteur before they sold out grailed shaman street art cold-pressed edison bulb ascot YOLO. Quinoa XOXO letterpress celiac. Grailed food truck whatever dolore bicycle rights. 8-bit beard listicle affogato enim. Dummy text? More like dummy thicc text, amirite?</p></div>
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
                           
                           
                            <hr/>  </div>  
                            <h3 id="skip">Pase a la sección:<xsl:text>   </xsl:text>
                            <xsl:for-each select="//body/div">
                                <a href="#sect-{data(@n)}"><xsl:value-of select='data(@n)'/></a>  
                                <xsl:text>   </xsl:text>
                            </xsl:for-each></h3>
                            
                            <table class="document" id="document">
                                <tr>
                                    <td><xsl:apply-templates select="//bibl[data(@xml:id)='Z']"/></td>
                                    <td><xsl:apply-templates select="//bibl[data(@xml:id)='A']"/></td>
                                    <!--<th></th>-->
                                </tr>
                                <tr><th><h2>Texto: Zavala</h2></th>
                                    <th><h2>Texto: Corporación Ayún</h2></th>
                                    <!--<th><h2>Notas</h2></th>-->
                                </tr>

                                <xsl:apply-templates select="//body/div"/>
                                
                            </table>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div">
        
            <xsl:if test="not(@n)"><!--whc 19-JUN-2023: This is so head divs that only appear in A (the editorial insertions),
                which will not be numbered, do not include an id="sect-" attribute and value on them, and will include a note explaining
                the absence of text from the Z column.--> 
                <tr> <td>[trans to Span:] <i>A heading not in the original document was inserted here by the Ayun editors only.</i></td>
                    <th><xsl:apply-templates select="head" mode="A-head"/></th>
                    <!--     <td><i>No hay notas en esta sección.</i></td>whc 19-JUN-2023: assuming there will be no notes in these sections-->
                </tr></xsl:if>
        
            <xsl:if test="@n">
            <tr id="sect-{data(@n)}">
                <xsl:if test="./head">
                <th>[&#167;<xsl:value-of select="data(@n)"/>]
                    <xsl:apply-templates select="head" mode="Z-head"/></th>
                <th>[&#167;<xsl:value-of select="data(@n)"/>]
                    <xsl:apply-templates select="head" mode="A-head"/></th>
                </xsl:if>
                
              <xsl:if test="./ab">
                <td><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>
                    <xsl:apply-templates select="ab" mode="Z-block"/> </td>
                <td><b>[&#167;<xsl:value-of select="data(@n)"/>]  </b>
                    <xsl:apply-templates select="ab" mode="A-block"/> 
                    <a class="top-btn" href="#">Inicio de pagina</a><a class="top-btn" href="#document">Inicio de texto</a></td>
              </xsl:if>
                
                <!--             <td>
                    <xsl:if test="not(.//term or .//persName or .//placeName)">
                        <b>[&#167;<xsl:value-of select="data(@n)"/>]</b><xsl:text>  </xsl:text>
                        <i>No hay notas en esta sección.</i>
                        <a class="top-btn" href="#">Inicio de página</a>
                    </xsl:if>
                    
                   <xsl:if test=".//term or .//persName or .//placeName">
                        <b>[&#167;<xsl:value-of select="data(@n)"/>]</b><xsl:text>  </xsl:text>
                       <i> Haga clic en cada triángulo para ampliar/contraer notas</i>
                        <xsl:if test=".//term">
                            <h2><b>Términos</b></h2>
                                    <xsl:for-each-group select=".//term" group-by="data(@n)">
                                        <xsl:variable name="term-n" select="./data(@n)"/>
                                        <xsl:variable name="sense-n" select="./data(@select)"/>
                                        <xsl:variable name="this-term-span" select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']"/>
                                        <details><summary><b><xsl:apply-templates select="$this-term-span//string-join(./orth, '; ')"/></b></summary>
                                            <i><xsl:apply-templates select="$this-term-span//pos"/></i> <xsl:text>. </xsl:text>
                                            <xsl:apply-templates select="$Lex//superEntry[data(@n)=$term-n]/entry[data(@xml:lang)='span']/sense[data(@n)=$sense-n]"/>-->
                                            
                                            <!--whc: commenting out 19-JUN-2023: This is the code that would show every sense for every term, every time;
                                                disabling it so we can call for different senses from different instances of a given word
                                            <xsl:for-each select="$this-term-span//sense">
                                                <xsl:value-of select="./data(@n)"/><xsl:text>. </xsl:text>
                                                <xsl:apply-templates/><xsl:text>. </xsl:text>
                                            </xsl:for-each><br/>
                                            <u>Notas</u><xsl:text>: </xsl:text><xsl:apply-templates select="$this-term-span//note"/> -->
                                            
                                            <!--<br/></details>
                                    </xsl:for-each-group>        </xsl:if>
                                                
                        <xsl:if test=".//persName">
                            <h2><b>Personas</b></h2>
                                    <xsl:for-each-group select=".//persName" group-by="data(@n)">
                                        <xsl:variable name="pers-n" select="./data(@n)"/>
                                        <xsl:variable name="this-pers" select="$Pers//person[data(@n)=$pers-n]"/>
                                        <details><summary><b><xsl:apply-templates select="$this-pers/persName/name"/></b></summary>
                                            <xsl:apply-templates select="$this-pers/note[data(@xml:lang)='span']"/><br/></details>
                                    </xsl:for-each-group>        </xsl:if>
                        
                        <xsl:if test=".//placeName">
                            <h2><b>Lugares</b></h2>
                                    <xsl:for-each-group select=".//placeName" group-by="data(@n)">
                                        <xsl:variable name="place-n" select="./data(@n)"/>
                                        <xsl:variable name="this-place" select="$Place//place[data(@n)=$place-n]"/>
                                        <details><summary><b><xsl:apply-templates select="$this-place/concat
                                            (geogName, ' ', placeName, ', ', region,', ', country)!normalize-space()"/></b></summary>
                                            <xsl:apply-templates select="$this-place/note[data(@xml:lang)='span']"/><br/>
                                            <a href="{$this-place/note[data(@type)='map-link']}" target="_blank" rel="noopener noreferrer">Map (opens in new tab)</a>
                                        </details>
                                    </xsl:for-each-group>        </xsl:if>
                               <a class="top-btn" href="#">Inicio de página</a>
                        </xsl:if>
               
                </td>-->
            </tr>
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

    <!--<xsl:template match="div//persName" mode="#all">
      <span class="pers"><xsl:apply-templates/></span>  
   </xsl:template>
    
    <xsl:template match="term" mode="#all">
        <span class="term"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="placeName" mode="#all">
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>-->
    
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
