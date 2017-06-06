<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Examine="urn:Examine" 
	exclude-result-prefixes="msxml umbraco.library Examine ">


<xsl:output method="html" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>
<xsl:variable name="videonode" select="/macro/videoNode"/>
<xsl:variable name="videoid" select="generate-id($videonode)"/>
<xsl:variable name="videopath" select="$videonode/File/umbracoFile"/>
<xsl:variable name="videoheight" select="/macro/VideoHeight"/>
<xsl:variable name="videowidth" select="/macro/VideoWidth"/>
      
<xsl:variable name="imagenode" select="/macro/imageNode"/>
<xsl:variable name="imageid" select="generate-id($imagenode)"/>
<xsl:variable name="imagepath" select="$imagenode/*/umbracoFile"/>

<xsl:template match="/">

<!-- JW Player ============================================================= -->
  
<script type='text/javascript' src='/scripts/jwplayer/jwplayer.js'></script>
 
<div id='mediaspace'>This text will be replaced</div>  
<script type='text/javascript'>
  jwplayer('mediaspace').setup({
    'flashplayer': '/scripts/jwplayer/player.swf',
    'file': '<xsl:value-of select="$videopath" />',      
    'image': '<xsl:value-of select="$imagepath" />',  
    'backcolor': 'FFFFFF',
    'frontcolor': '0079c1',
    'lightcolor': 'FFFFFF',
    'screencolor': 'FFFFFF',
    'bufferlength': '25',
    'controlbar': 'bottom',
    'width': '<xsl:value-of select="$videowidth"/>',
    'height': '<xsl:value-of select="$videoheight"/>' <!-- NOTE: must add 24px height to accomodate player control bar -->
  });
</script>  
</xsl:template>
</xsl:stylesheet>