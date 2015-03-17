<?xml version="1.0" encoding="UTF-8"?>
<!--
OBK to TXT
extracts parts from an OnderwijsBegrippenkader record as text
http://www.onderwijsbegrippenkader.nl
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:bk="http://purl.edustandaard.nl/begrippenkader/"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:skos="http://www.w3.org/2004/02/skos/core#">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='label'">
            <xsl:value-of select="/rdf:RDF/rdf:Description/rdfs:label"/>
         </xsl:when>
         <xsl:when test="$data='preflabel'">
            <xsl:value-of select="/rdf:RDF/rdf:Description/skos:prefLabel"/>
         </xsl:when>         
         <xsl:when test="$data='geldigheid'">
            <xsl:value-of select="/rdf:RDF/rdf:Description/bk:heeftGeldigheidsperiode"/>
         </xsl:when>
         <xsl:when test="$data='narrower'">
            <xsl:for-each select="/rdf:RDF/rdf:Description/skos:narrower/@rdf:resource">
               <xsl:value-of select="."/>
               <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
