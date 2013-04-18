<?xml version="1.0" encoding="UTF-8"?>
<!--
SMB to TXT
extracts parts from the SMB response as text
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:smd="http://xsd.kennisnet.nl/smd/1.0/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <!-- regular responses -->
         <xsl:when test="$data='status'">
            <xsl:value-of select="//smd:response/smd:status"/>
         </xsl:when>
         <!-- error -->
         <xsl:when test="$data='error-code'">
            <xsl:value-of select="//smd:errorResponse/smd:error/smd:code"/>
         </xsl:when>
         <xsl:when test="$data='error-description'">
            <xsl:value-of select="//smd:errorResponse/smd:error/smd:description"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
