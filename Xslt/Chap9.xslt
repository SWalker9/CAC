<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt" 
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Examine="urn:Examine" 
	exclude-result-prefixes="msxml umbraco.library Examine ">

<xsl:output method="xml" omit-xml-declaration="yes" />

<xsl:param name="currentPage"/>

<!-- Input the documenttype you want here -->
<xsl:variable name="level" select="2"/>
		<xsl:variable name="startNode" select="$currentPage/ancestor-or-self::*[@level = $level]" />
<xsl:variable name="nodesToShow" select="$startNode/*[@isDoc][not(umbracoNaviHide = 1)]" />

<xsl:template match="/">

<!-- The fun starts here -->
<xsl:if test="$nodesToShow">
    <img src="/media/1137/actheader9.png" alt="Activities in this Section" class="acttitle" />
</xsl:if>
    <ul>
<xsl:for-each select="$currentPage/ancestor-or-self::* [@level=$level]/* [@isDoc and string(umbracoNaviHide) != '1']">
<li>
   <xsl:attribute name="class">
        <xsl:if test="contains(activityextras,'Video')">Video</xsl:if>
        <xsl:if test="contains(activityextras,'Scripted')">Scripted</xsl:if>
		</xsl:attribute>

   <a href="{umbraco.library:NiceUrl(@id)}">
      <xsl:value-of select="@nodeName" />
   </a>
</li>
</xsl:for-each>
</ul>

</xsl:template>

</xsl:stylesheet>