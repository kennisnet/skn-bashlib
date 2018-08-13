<?xml version="1.0" encoding="UTF-8"?>
<!--
Edurep Drilldown to CSV
extracts values and counts for a given navigator
in csv format
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   xmlns:dd="http://meresco.org/namespace/drilldown">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="navigator"/>
   <xsl:param name="separator" select="';'"/>

   <xsl:template match="/">
      <xsl:for-each select="//dd:drilldown/dd:term-drilldown/dd:navigator[@name=$navigator]/dd:item">
         <xsl:value-of select="." />
         <xsl:value-of select="$separator" />
         <xsl:value-of select="@count" />
         <xsl:text>&#xA;</xsl:text>
      </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>
