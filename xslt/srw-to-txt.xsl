<?xml version="1.0" encoding="UTF-8"?>
<!--
SRW to TXT
extracts parts from the SRW response as text
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:srw="http://www.loc.gov/zing/srw/"
   xmlns:diag="http://www.loc.gov/zing/srw/diagnostic/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <!-- regular responses -->
         <xsl:when test="$data='recordcount'">
            <xsl:value-of select="/srw:searchRetrieveResponse/srw:numberOfRecords"/>
         </xsl:when>
         <xsl:when test="$data='identifiers'">
            <xsl:for-each select="/srw:searchRetrieveResponse/srw:records/srw:record">
                <xsl:value-of select="srw:recordIdentifier"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
         <!-- diagnostic -->
         <xsl:when test="$data='diagnostic-uri'">
            <xsl:value-of select="//diag:diagnostic/diag:uri"/>
         </xsl:when>
         <xsl:when test="$data='diagnostic-msg'">
            <xsl:value-of select="//diag:diagnostic/diag:message"/>
         </xsl:when>
         <xsl:when test="$data='diagnostic-details'">
            <xsl:value-of select="//diag:diagnostic/diag:details"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
