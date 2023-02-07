<?xml version="1.0" encoding="UTF-8"?>
<!-- WHC 02-FEB-2023: This is derived from a Brecon Project file. 
    The purpose for this XSLT is to create a display version of each edition as an html file. 
I am trying to make the syntax as universal as possible so it can be used with very few changes on all subsequent 
Parlamento text files down the line. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:variable name="editionColl" as="node()+" select="//bibl/rs"/>
    <xsl:template match="/">
        <xsl:for-each select="$editionColl">
            <xsl:variable name="filename" as="xs:string">
                <xsl:value-of select="current() ! string()"/>
            </xsl:variable>
            <xsl:result-document method="xhtml" indent="yes" href="../site/1803-display-{$filename}.html"> 
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                        <link rel="stylesheet" type="text/css" href="style.css" />
<!-- whc 07-FEB-2023: I removed the js link that made tick boxes work. Will need to add back in, plus 
                        css, to be able to change color/bold/whatever for names/places/terms etc.-->
                      <title>Negrete <xsl:value-of select="current()"/></title>
                    </head>
                    <body>
                        
                        <div class="content">
                            <h1><xsl:apply-templates select="root()/descendant::titleStmt/title"/></h1>
                            <h2><xsl:apply-templates select="root()/descendant::publicationStmt/p"/></h2>
                            
                            <div class="bibliog">
                                                       
                                <xsl:apply-templates select="root()/descendant::bibl">
                                    <xsl:with-param name="currentEd" as="node()" select="current()"/>
                                </xsl:apply-templates>
                           
                            </div>       
                            
                            <div class="transcript-body">
                                <xsl:apply-templates select="root()/descendant::div">
                                    <xsl:with-param name="currentEd" as="node()" select="current()"/>
                                </xsl:apply-templates>
                            </div>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="root()/descendant::bibl">
        <xsl:param name="currentEd"/>
        
            <p>
                <xsl:apply-templates>
                    <xsl:with-param name="currentEd" select="$currentEd" as="node()"/>
                </xsl:apply-templates>
            </p> 
        
        <p><b>Editor(s):</b> <xsl:apply-templates select="(root()/descendant::editor)">
            <xsl:with-param name="currentEd" select="$currentEd" as="node()"/>
        </xsl:apply-templates></p>
        
            <p><b>Editor(s):</b> <xsl:apply-templates select="(root()/descendant::editor)"/></p>
            <p><b>Publication title:</b><i><xsl:value-of select="(root()/descendant::title)"/></i></p>
            <p><b>Publisher:</b><i><xsl:value-of select="(root()/descendant::publisher)"/></i></p>
            <p><b>Publisher location:</b><i><xsl:value-of select="(root()/descendant::pubPlace)"/></i></p>
            <p><b>Publication date:</b><i><xsl:value-of select="(root()/descendant::date)"/></i></p>
            <p><b>Page range:</b><i><xsl:value-of select="(root()/descendant::biblScope)"/></i></p>
            <p><b>Notes:</b><i><xsl:value-of select="(root()/descendant::note)"/></i></p>
        
    </xsl:template>
    
    <xsl:template match="root()/descendant::ab">
        <xsl:param name="currentEd"/>
        <xsl:for-each select=".">
            <p>
                <xsl:apply-templates>
                    <xsl:with-param name="currentEd" select="$currentEd" as="node()"/>
                </xsl:apply-templates>
            </p>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="root()/descendant::div/head">
        <xsl:param name="currentEd"/>
        <xsl:for-each select=".">
            <p><b>
                <xsl:apply-templates>
                    <xsl:with-param name="currentEd" select="$currentEd" as="node()"/>
                </xsl:apply-templates>
            </b></p>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="root()/descendant::app">
        <xsl:param name="currentEd"/>
        <xsl:if test="rdg[contains(@wit, $currentEd ! string())]">
            <span class="variant">
                <xsl:value-of select="rdg[@wit[contains(., $currentEd ! string())]]"/>
            </span>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>