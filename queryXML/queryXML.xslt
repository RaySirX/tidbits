<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
  method="text"/>

<xsl:param name="varPath"/>

<xsl:template match="/">
  <xsl:value-of select="$varPath"/>
</xsl:template>

</xsl:stylesheet>
