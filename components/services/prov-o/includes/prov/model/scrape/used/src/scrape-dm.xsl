<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:x="http://www.w3.org/1999/xhtml">
<xsl:output method="text"/>

<xsl:param name="view"/> <!-- An identifier of the view of http://www.w3.org/TR/prov-dm/ (use a message digest like md5) -->
<xsl:param name="dirbase" select="'generated/'"/>

<xsl:template match="/">
   <xsl:apply-templates select="//*[@class='codeexample']"/>
</xsl:template>

<xsl:template match="*[@class='codeexample']">
   <xsl:variable name="section">
      <xsl:for-each select="ancestor::x:div[contains(@class,'section')]">
         <!-- e.g. 5.2.1 -> '..' -->
         <xsl:sort select="string-length(replace(descendant::x:span[@class='secno'][1]/text(),'[^\.]',''))" order="descending"/>
         <!-- e.g. 6.2 over 6. -->
         <xsl:sort select="string-length(descendant::x:span[@class='secno'][1])" order="descending"/> 
         <xsl:if test="position() = 1">
            <number><xsl:value-of select="replace(descendant::x:span[@class='secno'][1],'\. *$','')"/></number>
            <title><xsl:value-of select="normalize-space(descendant::x:span[@class='secno'][1]/following-sibling::text()[1])"/></title>
         </xsl:if>
      </xsl:for-each>
   </xsl:variable>

   <xsl:variable name="directory" select="concat($dirbase,'codeexamples/')"/>
   <xsl:variable name="filename" select="concat('eg-',
                                                if (position() le 9) then '0' else '',position(),'-',
                                                $section/number,'-',
                                                replace(lower-case($section/title),' ','-'))"/>
   <xsl:value-of select="concat(position(),' ',local-name(.),' ',@class,' ',$section/number,' ',$section/title,$NL)"/>

   <xsl:result-document href="{concat($directory,$filename,'.txt')}">
      <xsl:apply-templates select="." mode="text"/>
   </xsl:result-document>

   <xsl:variable name="section-uriref" select="concat('&lt;',$view,'/',$section/number,'>')"/>
   <xsl:variable name="view-uriref"    select="concat('&lt;',$view,'>')"/>
   <xsl:result-document href="{$directory}{$filename}.ttl">
      <xsl:value-of select="concat($prefixes,
                                   ':example_',position(),$NL,
                                   '   a :PROV-DM-Example, prov:Quote;',$NL,
                                   '   dcterms:identifier ',position(),';',$NL,
                                   '   prov:wasQuotedFrom ',$section-uriref,';',$NL,
                                   '   rdf:value ',$TQ)"/>
      <xsl:apply-templates select="." mode="text"/>
      <xsl:value-of select="concat($TQ,';',$NL,
                                   '   dcterms:date ',$DQ,current-dateTime(),$DQ,'^^xsd:dateTime;',$NL,
                                   '   a frbr:Manifestation;',$NL,
                                   '   frbr:exemplar [',$NL,
                                   '      a frbr:Item;',$NL,
                                   '      nfo:fileName     ',$DQ,$filename,'.txt',$DQ,'^^xsd:string;',$NL,
                                   '      nfo:fileUrl      &lt;',$filename,'.txt>;',$NL,
                                   '      nfo:fileCreated ',$DQ,current-dateTime(),$DQ,'^^xsd:dateTime;',$NL,
                                   '   ];',$NL,
                                   '.',$NL,$NL,
                                   $section-uriref,$NL,
                                   '   a doco:Section;',$NL,
                                   '   dcterms:identifier ',$DQ,$section/number,$DQ,';',$NL,
                                   '   dcterms:title      ',$DQ,$section/title,$DQ,';',$NL,
                                   '   dcterms:isPartOf   ',$view-uriref,';',$NL,
                                   '.',$NL,$NL,
                                   $view-uriref,$NL,
                                   '   prov:viewOf         &lt;http://www.w3.org/TR/prov-dm/>;',$NL,
                                   '   dcterms:identifier ',$DQ,$view,$DQ,';',$NL,
                                   '.',$NL
                                   )"/>
   </xsl:result-document>
</xsl:template>

<xsl:template match="@*|node()" mode="text">
  <xsl:copy>
		<xsl:copy-of select="@*"/>	
	  <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:variable name="NL"> <!-- newline -->
<xsl:text>
</xsl:text>
</xsl:variable>

<xsl:variable name="DQ"> <!-- double quote -->
<xsl:text>"</xsl:text>
</xsl:variable>

<xsl:variable name="TQ"> <!-- triple quote -->
<xsl:text>"""</xsl:text>
</xsl:variable>

<xsl:variable name="prefixes"><![CDATA[@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:     <http://www.w3.org/2001/XMLSchema#> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix frbr:    <http://purl.org/vocab/frbr/core#> .
@prefix nfo:     <http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#> .
@prefix doco:    <http://purl.org/spar/doco/> .
@prefix prov:    <http://www.w3.org/ns/prov-o/> .
@prefix :        <#> .

]]></xsl:variable>
</xsl:transform>
