<?xml version='1.0' encoding="UTF-8"?>
<!--
Creates an Edurep-SMB Update request
based on the provided values.
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:smd="http://xsd.kennisnet.nl/smd/1.0/">

   <xsl:template match="/">
      <xsl:element name="soap:Envelope">
         <xsl:element name="soap:Body">
            <xsl:element name="smd:updateSMO">
              <xsl:apply-templates/>
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
