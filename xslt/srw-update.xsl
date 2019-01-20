<?xml version='1.0' encoding="UTF-8"?>
<!--
Creates an SRU Record Update or Delete request
based on the provided xml.
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:srw="http://www.loc.gov/zing/srw/"
   xmlns:ucp="info:lc/xmlns/update-v1">
   <!-- don't use indent, it has been known not to be accepted -->
   <xsl:output method="xml" indent="no"/>
   <!-- set to update or delete -->
   <xsl:param name="action"/>
   <xsl:param name="identifier"/>
   <xsl:param name="recordpacking" select="'xml'"/>
   <xsl:param name="recordschema" select="''"/>

   <xsl:template match="/">
      <xsl:element name="srw:updateRequest">
         <xsl:element name="srw:version">
            <xsl:value-of select="'1.0'"/>
         </xsl:element>
         <xsl:element name="ucp:action">
            <xsl:if test="$action='update'">
               <xsl:value-of select="'info:srw/action/1/replace'"/>
            </xsl:if>
            <xsl:if test="$action='delete'">
               <xsl:value-of select="'info:srw/action/1/delete'"/>
            </xsl:if>
         </xsl:element>
          <xsl:element name="ucp:recordIdentifier">
            <xsl:value-of select="$identifier"/>
         </xsl:element>
         <xsl:element name="srw:record">
            <xsl:element name="srw:recordPacking">
               <xsl:value-of select="$recordpacking"/>
            </xsl:element>
            <xsl:if test="$recordschema!=''">
                <xsl:element name="srw:recordSchema">
                   <xsl:value-of select="$recordschema"/>
                </xsl:element>
            </xsl:if>
            <xsl:element name="srw:recordData">
               <xsl:if test="$action='update'">
                  <xsl:apply-templates/>
               </xsl:if>
               <xsl:if test="$action='delete'">
                  <xsl:value-of select="'ignored'"/>
               </xsl:if>
            </xsl:element>
         </xsl:element>
      </xsl:element>
   </xsl:template>

    <!-- default copy -->
   <xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
