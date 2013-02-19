<?xml version="1.0" encoding="UTF-8"?>
<!--
SRW to XML
extracts parts from the SRW response as xml
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:srw="http://www.loc.gov/zing/srw/"
   xmlns:diag="http://www.loc.gov/zing/srw/diagnostic/">
   <xsl:output method="xml" omit-xml-declaration="no"/>
   <xsl:param name="data"/>
   <xsl:param name="identifier"/>

   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='recorddata'">
            <xsl:copy-of select="/srw:searchRetrieveResponse/srw:records/srw:record[srw:recordIdentifier=$identifier]/srw:recordData/node()"/>
         </xsl:when>
         <xsl:when test="$data='extraresponsedata'">
            <xsl:copy-of select="/srw:searchRetrieveResponse/srw:extraResponseData/node()"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
