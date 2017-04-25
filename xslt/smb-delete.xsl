<?xml version='1.0' encoding="UTF-8"?>
<!--
Creates an Edurep-SMB Delete request
based on the provided values.
-->
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:smd="http://xsd.kennisnet.nl/smd/1.0/">
   <xsl:param name="supplierid"/>
   <xsl:param name="smoid"/>

   <xsl:template match="/">
      <xsl:element name="soap:Envelope">
         <xsl:element name="soap:Body">
            <xsl:element name="smd:deleteSMO">
               <xsl:element name="smd:smo">
                  <xsl:element name="smd:smoId">
                     <xsl:value-of select="$smoid"/>
                  </xsl:element>
                  <xsl:element name="smd:supplierId">
                     <xsl:value-of select="$supplierid"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
