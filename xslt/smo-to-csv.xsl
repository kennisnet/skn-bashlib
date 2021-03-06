<?xml version="1.0" encoding="UTF-8"?>
<!--
Edurep SMO to CSV
extracts values for the provided fields
in csv format
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:smo="http://xsd.kennisnet.nl/smd/1.0/"
   xmlns:hreview="http://xsd.kennisnet.nl/smd/hreview/1.0/">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="identifier"/>
   <xsl:param name="fields"/>
   <xsl:param name="separator" select="';'"/>

   <xsl:template match="/">
      <xsl:value-of select="$identifier"/>
      <xsl:if test="contains($fields,'smoid')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/smo:smoId"/>
      </xsl:if>
      <xsl:if test="contains($fields,'userid')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/smo:userId"/>
      </xsl:if>
     <xsl:if test="contains($fields,'supplierid')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/smo:supplierId"/>
      </xsl:if>
     <xsl:if test="contains($fields,'dtreviewed')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/hreview:hReview/hreview:dtreviewed"/>
      </xsl:if>
      <xsl:if test="contains($fields,'rating')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/hreview:hReview/hreview:rating"/>
      </xsl:if>
      <xsl:if test="contains($fields,'info')">
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/hreview:hReview/hreview:info"/>
      </xsl:if>
      <xsl:if test="contains($fields,'tag')">
         <!-- retrieves first tag -->
         <xsl:value-of select="$separator"/>
         <xsl:value-of select="/smo:smo/hreview:hReview/hreview:tags/hreview:tag/hreview:name"/>
      </xsl:if>
      <xsl:text>&#xA;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
