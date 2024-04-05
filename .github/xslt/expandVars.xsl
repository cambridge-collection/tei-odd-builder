<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:param name="GITHUB_REF_NAME"/>
    <xsl:param name="GITHUB_SHA"/>
    <xsl:param name="DATE_STR"/>
    
    <xsl:mode on-no-match="shallow-copy" />
    
    <xsl:template match="processing-instruction('insert')[matches(.,'GITHUB_REF_NAME')]">
        <xsl:value-of select="$GITHUB_REF_NAME"/>
    </xsl:template>
    
    <xsl:template match="processing-instruction('insert')[matches(.,'GITHUB_SHA')]">
        <xsl:value-of select="$GITHUB_SHA"/>
    </xsl:template>
    
    <xsl:template match="processing-instruction('insert')[matches(.,'DATE_STR')]">
        <xsl:value-of select="$DATE_STR"/>
    </xsl:template>
</xsl:stylesheet>