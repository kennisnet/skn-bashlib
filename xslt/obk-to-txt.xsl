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
   mlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>

   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='label'">
            <xsl:value-of select="/rdf:RDF/rdf:Description/rdfs:label"/>
         </xsl:when>
         <xsl:when test="$data='geldigheid'">
            <xsl:value-of select="/rdf:RDF/rdf:Description/bk:heeftGeldigheidsperiode"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
