<?xml version="1.0" encoding="UTF-8"?>

<!--DO NOT USE: see notes below-->

<!-- WHC 09-FEB-2023: This is derived from a Brecon Project file authored by UPG student Alyssa Argento. 
    The purpose for this XSLT is to create an html page with the two Spanish versions in parallel columns. 
I am trying to make the syntax as universal as possible so it can be used with very few changes on all subsequent 
Parlamento text files down the line. -->
<!--WHC 09-FEB-2023: I wound up setting this aside to do a more literal, manual two-column
    form using a table. So this is not currently in use. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:variable name="currentEdition" as="node()+" select="//bibl/rs"/>
    <xsl:template match="/">
        <xsl:result-document method="xhtml" indent="yes" href="../site/1803-comparison.html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <link rel="stylesheet" type="text/css" href="css/style.css" />

                <script src="js/comp-checkbox2.js" type="text/javascript"></script> 
                    <title>Spanish Versions: Comparison</title>
                </head>
                <body>
                    <div id="navbar">
                        <div class="navbar">
                            <a href="../index.html">Home</a>
                            <div class="comp-checkbox">
                                <span class="comp-single"><input type="checkbox" id="CompANav" onclick="CompA()"
                                />Ayun<br /></span>
                                <span class="comp-single"><input type="checkbox" id="CompZNav" onclick="CompZ()"
                                />Zavala<br /></span>
                                <button>CLEAR</button>
                            </div>
                        </div>
                    </div>
                    

                    <div class="content">
                        <xsl:apply-templates select="//div"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div/head">
        <p><b>
            <xsl:apply-templates/>
        </b></p>
    </xsl:template>
    
    <xsl:template match="div/ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="rdg">
        <xsl:if test="attribute::wit[contains(., 'A')]">
            <div class="a-variance comp" style="display:none">
                <span class="left">A</span>
                <span class="right">
                    <xsl:apply-templates select="./text()"/>
                </span>
            </div>
        </xsl:if>
        <xsl:if test="attribute::wit[contains(., 'Z')]">
            <div class="z-variance comp" style="display:none">
                <span class="left">Z</span>
                <span class="right">
                    <xsl:apply-templates select="./text()"/>
                </span>
            </div>
        </xsl:if>
        
    </xsl:template>
</xsl:stylesheet>