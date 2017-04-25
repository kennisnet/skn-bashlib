<?xml version="1.0" encoding="UTF-8"?>
<!--
SMO to TXT
extracts parts from an SMO record as text lists
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   xmlns:smo="http://xsd.kennisnet.nl/smd/1.0/"
   xmlns:hreview="http://xsd.kennisnet.nl/smd/hreview/1.0/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>
   <xsl:param name="language" select="'nl'"/>


   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='info'">
            <xsl:value-of select="/smo:smo/hreview:hReview/hreview:info/text()" />
            <xsl:text>&#xA;</xsl:text>
         </xsl:when>
      </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
