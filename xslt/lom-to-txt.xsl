<?xml version="1.0" encoding="UTF-8"?>
<!--
LOM to TXT
extracts parts from a LOM record as text lists
use for multivalue fields
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   xmlns:lom="http://www.imsglobal.org/xsd/imsmd_v1p2">
   <xsl:output method="text" omit-xml-declaration="yes"/>
   <xsl:param name="data"/>
   <xsl:param name="language" select="'nl'"/>


   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$data='keywords'">
            <xsl:for-each select="/lom:lom/lom:general/lom:keyword/lom:langstring[@xml:lang=$language]">
               <xsl:value-of select="." />
               <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="$data='contexts'">
            <xsl:for-each select="/lom:lom/lom:educational/lom:context/lom:value/lom:langstring">
               <xsl:value-of select="." />
               <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="$data='disciplines'">
            <xsl:for-each select="/lom:lom/lom:classification/lom:purpose/lom:value/lom:langstring[text()='discipline']">
               <xsl:for-each select="../../../lom:taxonpath/lom:taxon/lom:id">
                  <xsl:value-of select="." />
                  <xsl:text>&#xA;</xsl:text>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="$data='educationallevels'">
            <xsl:for-each select="/lom:lom/lom:classification/lom:purpose/lom:value/lom:langstring[text()='educational level']">
               <xsl:for-each select="../../../lom:taxonpath/lom:taxon/lom:id">
                  <xsl:value-of select="." />
                  <xsl:text>&#xA;</xsl:text>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
