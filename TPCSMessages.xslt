<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:usrFn="http://www.prinova.com" version="2.0">
   <!-- xmlns:usrFn="user defined functions"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs" version="2.0"-->
<xsl:output method="text" encoding="UTF-8"/>

<xsl:template name="printSelectionMessages">
	<xsl:param name="currselection"/> 
	<xsl:param name="currnames"/> 

	<xsl:for-each select="$currselection/Contents/Message">
		<xsl:variable name="msgid" select="@refid"/>
 		<xsl:variable name="referTo" select="@sameasselectionrefid"/>
		<xsl:variable name="zoneid" select="/MpTouchpointDefinition/Messages/Message[@id=$msgid and @type='Selectable(Touchpoint Content)']/Version/Delivery/@zonerefid"/>
	
		<xsl:variable name="contentType">
			<xsl:choose>
				<xsl:when test="@suppress='true'">Suppressed</xsl:when>
			 	<xsl:when test="@custom='true'">Custom</xsl:when>
			 	<xsl:when test="@sameasselectionrefid">ReferToSelection</xsl:when>
				<xsl:otherwise>dunno</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<xsl:variable name="msgType"  select="/MpTouchpointDefinition/Messages/Message[@id=$msgid and @type='Selectable(Touchpoint Content)']/@contenttype"/>
		<xsl:variable name="msgState" select="/MpTouchpointDefinition/Messages/Message[@id=$msgid and @type='Selectable(Touchpoint Content)']/Version/@status"/>
		<xsl:variable name="msgName"  select="/MpTouchpointDefinition/Messages/Message[@id=$msgid and @type='Selectable(Touchpoint Content)']/Version/Name"/>
<!-- 	<xsl:variable name="selectionid"  select="../../@id"/>	-->
		<xsl:variable name="selectionName"  select="../../Name"/>
		<xsl:variable name="zoneName" select="/MpTouchpointDefinition/Touchpoint/Zone[@id=$zoneid]/@friendlyname"/>
	
<!-- 	<xsl:value-of select="$selectionid"/><xsl:text>|</xsl:text> 	-->
		<xsl:value-of select="$currnames"/><xsl:text> -> </xsl:text>
		<xsl:value-of select="$selectionName"/><xsl:text>|</xsl:text>
<!-- 	<xsl:value-of select="$zoneid"/><xsl:text>|</xsl:text> 	-->
		<xsl:value-of select="$zoneName"/><xsl:text>|</xsl:text>
<!-- 	<xsl:value-of select="$msgid"/><xsl:text>|</xsl:text>	-->
		<xsl:value-of select="$msgName"/><xsl:text>|</xsl:text>
		<xsl:value-of select="$msgType"/><xsl:text>|</xsl:text>
		<xsl:value-of select="$msgState"/><xsl:text>|</xsl:text>
		<xsl:value-of select="$contentType"/><xsl:text>|</xsl:text>
		<xsl:choose>
		 	<xsl:when test="$contentType='Custom'">
		 		<xsl:value-of select="Content"/>
		 	</xsl:when>
		 	<xsl:when test="$contentType='ReferToSelection'">
		 		<xsl:value-of select="//Selection[@id=$referTo]/Name"/>
		 	</xsl:when>
		</xsl:choose>
		<xsl:text>&#10;</xsl:text>
	
	</xsl:for-each>
</xsl:template>

<xsl:template name="printSelections">
	<xsl:param name="currselection"/>
	<xsl:param name="currnames"/>
	
	<xsl:for-each select="$currselection">
		<xsl:variable name="currnames" select="concat($currnames,' -> ',Name)"/>
		<xsl:call-template name="printSelections"> 
			<xsl:with-param name="currselection" select="Selection"/> 
			<xsl:with-param name="currnames" select="$currnames"/> 
		</xsl:call-template>
	</xsl:for-each>
	<xsl:call-template name="printSelectionMessages"> 
		<xsl:with-param name="currselection" select="$currselection"/> 
		<xsl:with-param name="currnames" select="$currnames"/> 
	</xsl:call-template>
</xsl:template>

<xsl:template name="headerLine">
	<xsl:text>Selection</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>Zone</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>Message</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>MessageType</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>MessageState</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>ContentType</xsl:text><xsl:text>|</xsl:text>
	<xsl:text>ContentDetails</xsl:text>
</xsl:template>

<xsl:template match="/">
	<xsl:call-template name="headerLine"/>
	<xsl:call-template name="printSelections"> 
		<xsl:with-param name="currselection" select="/MpTouchpointDefinition/Touchpoint/Selections/Selection"/> 
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
