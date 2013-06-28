<?xml version="1.0" encoding="UTF-8"?>
<!--
OAI-DC to TXT
extracts parts from an OAI-DC record as text lists
use for multivalue fields
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
   xmlns:dc="http://purl.org/dc/elements/1.1/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='keywords'">
            <xsl:for-each select="/oai_dc:dc/dc:subject">
               <xsl:value-of select="." />
               <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
