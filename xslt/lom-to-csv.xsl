<?xml version="1.0" encoding="UTF-8"?>
<!--
Edurep LOM to CSV
extracts values for the provided fields
in csv format, only for single value fields
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   xmlns:lom="http://www.imsglobal.org/xsd/imsmd_v1p2">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="identifier"/>
   <xsl:param name="fields"/>
   <xsl:param name="separator" select="';'"/>

   <xsl:template match="/">
      <xsl:value-of select="$identifier"/>
      <xsl:if test="contains($fields,'title')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/lom:lom/lom:general/lom:title/lom:langstring" />
      </xsl:if>
      <xsl:if test="contains($fields,'uri-catalogentry')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/lom:lom/lom:general/lom:catalogentry[lom:catalog='URI']/lom:entry/lom:langstring" />
      </xsl:if>
      <!-- removing linebreaks for csv use -->
      <xsl:if test="contains($fields,'description')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="translate(/lom:lom/lom:general/lom:description/lom:langstring, '&#xA;&#xD;', '')" />
      </xsl:if>
      <xsl:if test="contains($fields,'aggregationlevel')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/lom:lom/lom:general/lom:aggregationlevel/lom:value/lom:langstring" />
      </xsl:if>
      <xsl:if test="contains($fields,'location')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/lom:lom/lom:technical/lom:location" />
      </xsl:if>
      <xsl:if test="contains($fields,'format')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/lom:lom/lom:technical/lom:format" />
      </xsl:if>
      <xsl:text>&#xA;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
