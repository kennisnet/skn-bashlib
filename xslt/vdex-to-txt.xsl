<?xml version="1.0" encoding="UTF-8"?>
<!--
VDEX to TXT
extracts parts from the VDEX record as text
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:vdex="http://www.imsglobal.org/xsd/imsvdex_v1p0">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='identifier'">
            <xsl:value-of select="/vdex:vdex/vdex:vocabIdentifier"/>
         </xsl:when>
         <xsl:when test="$data='termidentifiers'">
            <xsl:for-each select="/vdex:vdex/vdex:term/vdex:termIdentifier">
                <xsl:value-of select="."/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
