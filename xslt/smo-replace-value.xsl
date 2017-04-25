<?xml version="1.0" encoding="UTF-8"?>
<!--
LOM to TXT
extracts parts from a LOM record as text lists
use for multivalue fields
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   xmlns:smo="http://xsd.kennisnet.nl/smd/1.0/"
   xmlns:hreview="http://xsd.kennisnet.nl/smd/hreview/1.0/">
   <xsl:output method="xml" omit-xml-declaration="no"/>
   <xsl:param name="key"/>
   <xsl:param name="value"/>
   <xsl:param name="language" select="'nl'"/>

   <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="/smo:smo/hreview:hReview/hreview:info/text()">
      <xsl:choose>
      <xsl:when test="$key='info'">
         <xsl:value-of select="$value"/>
      </xsl:when>
      </xsl:choose>
   </xsl:template>



</xsl:stylesheet>
