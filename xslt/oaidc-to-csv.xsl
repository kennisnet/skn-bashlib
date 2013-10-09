<?xml version="1.0" encoding="UTF-8"?>
<!--
OAI-DC to CSV
extracts values for the provided fields
in csv format
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
   xmlns:dc="http://purl.org/dc/elements/1.1/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="identifier"/>
   <xsl:param name="fields"/>
   <xsl:param name="separator" select="';'"/>

   <xsl:template match="/">
      <xsl:value-of select="$identifier"/>
      <xsl:if test="contains($fields,'title')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/oai_dc:dc/dc:title"/>
      </xsl:if>
      <xsl:if test="contains($fields,'description')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/oai_dc:dc/dc:description"/>
      </xsl:if>
      <xsl:if test="contains($fields,'location')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/oai_dc:dc/dc:identifier"/>
      </xsl:if>
      <xsl:if test="contains($fields,'publisher')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/oai_dc:dc/dc:publisher"/>
      </xsl:if>
      <xsl:text>&#xA;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
