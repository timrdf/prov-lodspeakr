grammar_string= 
'<!DOCTYPE table [<!ENTITY nbsp   "&#160;">]>  ' + 
'<table border="0"> ' + 
'<tbody><tr><td colspan="4" class="grammarSection"><h3><a id="productions" name="productions">Productions</a>:</h3></td></tr></tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-bundle" name="prod-bundle"></a>[<span class="prodNo">1</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">bundle</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"bundle" (<span class="prod"><a class="grammarRef" href="#prod-namespaceDeclarations">namespaceDeclarations</a></span>)? (<span class="prod"><a class="grammarRef" href="#prod-expression">expression</a></span>)* (<span class="prod"><a class="grammarRef" href="#prod-namedBundle">namedBundle</a></span>)* "endBundle"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-expression" name="prod-expression"></a>[<span class="prodNo">2</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">expression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-entityExpression">entityExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-activityExpression">activityExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-generationExpression">generationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-usageExpression">usageExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-startExpression">startExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-endExpression">endExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-invalidationExpression">invalidationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-communicationExpression">communicationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-agentExpression">agentExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-associationExpression">associationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-attributionExpression">attributionExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-delegationExpression">delegationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-derivationExpression">derivationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-tracedToExpression">tracedToExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-alternateExpression">alternateExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-specializationExpression">specializationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-contextualizationExpression">contextualizationExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-insertionExpression">insertionExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-removalExpression">removalExpression</a></span> | <span class="prod"><a class="grammarRef" href="#prod-membershipExpression">membershipExpression</a></span> )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-entityExpression" name="prod-entityExpression"></a>[<span class="prodNo">3</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">entityExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"entity" "(" <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-optionalAttributeValuePairs" name="prod-optionalAttributeValuePairs"></a>[<span class="prodNo">4</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">optionalAttributeValuePairs</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( "," "[" <span class="prod"><a class="grammarRef" href="#prod-attributeValuePairs">attributeValuePairs</a></span> "]" )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-attributeValuePairs" name="prod-attributeValuePairs"></a>[<span class="prodNo">5</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">attributeValuePairs</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">(  | <span class="prod"><a class="grammarRef" href="#prod-attributeValuePair">attributeValuePair</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-attributeValuePair">attributeValuePair</a></span> )* )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-attributeValuePair" name="prod-attributeValuePair"></a>[<span class="prodNo">6</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">attributeValuePair</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-attribute">attribute</a></span> "=" <span class="prod"><a class="grammarRef" href="#prod-literal">literal</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-activityExpression" name="prod-activityExpression"></a>[<span class="prodNo">7</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">activityExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"activity" "(" <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-timeOrMarker" name="prod-timeOrMarker"></a>[<span class="prodNo">8</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">timeOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-time">time</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-generationExpression" name="prod-generationExpression"></a>[<span class="prodNo">9</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">generationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasGeneratedBy" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-optionalIdentifier" name="prod-optionalIdentifier"></a>[<span class="prodNo">10</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">optionalIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-identifierOrMarker">identifierOrMarker</a></span> ";" )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-identifierOrMarker" name="prod-identifierOrMarker"></a>[<span class="prodNo">11</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">identifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-usageExpression" name="prod-usageExpression"></a>[<span class="prodNo">12</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">usageExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"used" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> "," ( "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifierOrMarker">eIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-startExpression" name="prod-startExpression"></a>[<span class="prodNo">13</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">startExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasStartedBy" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifierOrMarker">eIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-endExpression" name="prod-endExpression"></a>[<span class="prodNo">14</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">endExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasEndedBy" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifierOrMarker">eIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-invalidationExpression" name="prod-invalidationExpression"></a>[<span class="prodNo">15</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">invalidationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasInvalidatedBy" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-timeOrMarker">timeOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-communicationExpression" name="prod-communicationExpression"></a>[<span class="prodNo">16</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">communicationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasInformedBy" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-agentExpression" name="prod-agentExpression"></a>[<span class="prodNo">17</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">agentExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"agent" "(" <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-attributionExpression" name="prod-attributionExpression"></a>[<span class="prodNo">18</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">attributionExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasAttributedTo" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-agIdentifier">agIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-associationExpression" name="prod-associationExpression"></a>[<span class="prodNo">19</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">associationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasAssociatedWith" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-agIdentifierOrMarker">agIdentifierOrMarker</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifierOrMarker">eIdentifierOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-delegationExpression" name="prod-delegationExpression"></a>[<span class="prodNo">20</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">delegationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"actedOnBehalfOf" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-agIdentifier">agIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-agIdentifier">agIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-derivationExpression" name="prod-derivationExpression"></a>[<span class="prodNo">21</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">derivationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"wasDerivedFrom" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-aIdentifierOrMarker">aIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-gIdentifierOrMarker">gIdentifierOrMarker</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-uIdentifierOrMarker">uIdentifierOrMarker</a></span> )? <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-tracedToExpression" name="prod-tracedToExpression"></a>[<span class="prodNo">22</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">tracedToExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"tracedTo" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-alternateExpression" name="prod-alternateExpression"></a>[<span class="prodNo">23</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">alternateExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"alternateOf" "(" <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-specializationExpression" name="prod-specializationExpression"></a>[<span class="prodNo">24</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">specializationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"specializationOf" "(" <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-contextualizationExpression" name="prod-contextualizationExpression"></a>[<span class="prodNo">25</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">contextualizationExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"contextualizationOf" "(" <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-bIdentifier">bIdentifier</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-insertionExpression" name="prod-insertionExpression"></a>[<span class="prodNo">26</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">insertionExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"derivedByInsertionFrom" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-dIdentifier">dIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-dIdentifier">dIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-keyEntitySet">keyEntitySet</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-keyEntitySet" name="prod-keyEntitySet"></a>[<span class="prodNo">27</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">keyEntitySet</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"{" "(" <span class="prod"><a class="grammarRef" href="#prod-literal">literal</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> ")" ( "," "(" <span class="prod"><a class="grammarRef" href="#prod-literal">literal</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> ")" )* "}"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-entitySet" name="prod-entitySet"></a>[<span class="prodNo">28</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">entitySet</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"{" (<span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span>)* "}"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-removalExpression" name="prod-removalExpression"></a>[<span class="prodNo">29</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">removalExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"derivedByRemovalFrom" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-dIdentifier">dIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-dIdentifier">dIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-keySet">keySet</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-keySet" name="prod-keySet"></a>[<span class="prodNo">30</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">keySet</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"{" <span class="prod"><a class="grammarRef" href="#prod-literal">literal</a></span> ( "," <span class="prod"><a class="grammarRef" href="#prod-literal">literal</a></span> )* "}"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-membershipExpression" name="prod-membershipExpression"></a>[<span class="prodNo">31</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">membershipExpression</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"memberOf" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-dIdentifier">dIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-keyEntitySet">keyEntitySet</a></span> <span class="prod"><a class="grammarRef" href="#prod-complete">complete</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"<br/> ' + 
'| "memberOf" "(" <span class="prod"><a class="grammarRef" href="#prod-optionalIdentifier">optionalIdentifier</a></span> <span class="prod"><a class="grammarRef" href="#prod-cIdentifier">cIdentifier</a></span> "," <span class="prod"><a class="grammarRef" href="#prod-entitySet">entitySet</a></span> <span class="prod"><a class="grammarRef" href="#prod-complete">complete</a></span> <span class="prod"><a class="grammarRef" href="#prod-optionalAttributeValuePairs">optionalAttributeValuePairs</a></span> ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-complete" name="prod-complete"></a>[<span class="prodNo">32</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">complete</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( "," ( "true" | "false" | "-" ) )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-namedBundle" name="prod-namedBundle"></a>[<span class="prodNo">33</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">namedBundle</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"bundle" <span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span> (<span class="prod"><a class="grammarRef" href="#prod-namespaceDeclarations">namespaceDeclarations</a></span>)? (<span class="prod"><a class="grammarRef" href="#prod-expression">expression</a></span>)* "endBundle"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-eIdentifier" name="prod-eIdentifier"></a>[<span class="prodNo">34</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">eIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-aIdentifier" name="prod-aIdentifier"></a>[<span class="prodNo">35</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">aIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-agIdentifier" name="prod-agIdentifier"></a>[<span class="prodNo">36</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">agIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-gIdentifier" name="prod-gIdentifier"></a>[<span class="prodNo">37</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">gIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-uIdentifier" name="prod-uIdentifier"></a>[<span class="prodNo">38</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">uIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-dIdentifier" name="prod-dIdentifier"></a>[<span class="prodNo">39</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">dIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-cIdentifier" name="prod-cIdentifier"></a>[<span class="prodNo">40</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">cIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-bIdentifier" name="prod-bIdentifier"></a>[<span class="prodNo">41</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">bIdentifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-identifier">identifier</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-eIdentifierOrMarker" name="prod-eIdentifierOrMarker"></a>[<span class="prodNo">42</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">eIdentifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-eIdentifier">eIdentifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-aIdentifierOrMarker" name="prod-aIdentifierOrMarker"></a>[<span class="prodNo">43</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">aIdentifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-aIdentifier">aIdentifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-agIdentifierOrMarker" name="prod-agIdentifierOrMarker"></a>[<span class="prodNo">44</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">agIdentifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-agIdentifier">agIdentifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-gIdentifierOrMarker" name="prod-gIdentifierOrMarker"></a>[<span class="prodNo">45</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">gIdentifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-gIdentifier">gIdentifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-uIdentifierOrMarker" name="prod-uIdentifierOrMarker"></a>[<span class="prodNo">46</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">uIdentifierOrMarker</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-uIdentifier">uIdentifier</a></span> | "-" )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-identifier" name="prod-identifier"></a>[<span class="prodNo">47</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">identifier</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME">QUALIFIED_NAME</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-attribute" name="prod-attribute"></a>[<span class="prodNo">48</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">attribute</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME">QUALIFIED_NAME</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-time" name="prod-time"></a>[<span class="prodNo">49</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">time</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-ISODATETIME">ISODATETIME</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-literal" name="prod-literal"></a>[<span class="prodNo">50</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">literal</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-typedLiteral">typedLiteral</a></span><br/> ' + 
'| <span class="prod"><a class="grammarRef" href="#prod-convenienceNotation">convenienceNotation</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-typedLiteral" name="prod-typedLiteral"></a>[<span class="prodNo">51</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">typedLiteral</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-STRING_LITERAL">STRING_LITERAL</a></span> "%%" <span class="prod"><a class="grammarRef" href="#prod-datatype">datatype</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-datatype" name="prod-datatype"></a>[<span class="prodNo">52</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">datatype</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME">QUALIFIED_NAME</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-convenienceNotation" name="prod-convenienceNotation"></a>[<span class="prodNo">53</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">convenienceNotation</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-STRING_LITERAL">STRING_LITERAL</a></span><br/> ' + 
'| <span class="prod"><a class="grammarRef" href="#prod-INT_LITERAL">INT_LITERAL</a></span><br/> ' + 
'| <span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME_LITERAL">QUALIFIED_NAME_LITERAL</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-namespaceDeclarations" name="prod-namespaceDeclarations"></a>[<span class="prodNo">54</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">namespaceDeclarations</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="#prod-defaultNamespaceDeclaration">defaultNamespaceDeclaration</a></span> | <span class="prod"><a class="grammarRef" href="#prod-namespaceDeclaration">namespaceDeclaration</a></span> ) (<span class="prod"><a class="grammarRef" href="#prod-namespaceDeclaration">namespaceDeclaration</a></span>)*</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-namespaceDeclaration" name="prod-namespaceDeclaration"></a>[<span class="prodNo">55</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">namespaceDeclaration</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"prefix" <span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME">QUALIFIED_NAME</a></span> <span class="prod"><a class="grammarRef" href="#prod-namespace">namespace</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-defaultNamespaceDeclaration" name="prod-defaultNamespaceDeclaration"></a>[<span class="prodNo">56</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">defaultNamespaceDeclaration</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"default" <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rIRI_REF">IRI_REF</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="prod"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-namespace" name="prod-namespace"></a>[<span class="prodNo">57</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production prod">namespace</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rIRI_REF">IRI_REF</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-QUALIFIED_NAME" name="prod-QUALIFIED_NAME"></a>[<span class="prodNo">58</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">QUALIFIED_NAME</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_LOCAL">PN_PREFIX</a></span> ":" )? <span class="prod"><a class="grammarRef" href="#prod-PN_LOCAL">PN_LOCAL</a></span><br/> ' + 
'| <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_LOCAL">PN_PREFIX</a></span> ":"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PREFX" name="prod-PREFX"></a>[<span class="prodNo">59</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PREFX</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_LOCAL">PN_PREFIX</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-DIGIT" name="prod-DIGIT"></a>[<span class="prodNo">60</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">DIGIT</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">[0-9]</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-ISODATETIME" name="prod-ISODATETIME"></a>[<span class="prodNo">61</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">ISODATETIME</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> "-" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> "-" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> "T" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> ":" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> ":" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> ( "." <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> ( <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> (<span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span>)? )? )? ( "Z" | <span class="prod"><a class="grammarRef" href="#prod-TIMEZONEOFFSET">TIMEZONEOFFSET</a></span> )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-TIMEZONEOFFSET" name="prod-TIMEZONEOFFSET"></a>[<span class="prodNo">62</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">TIMEZONEOFFSET</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( "+" | "-" ) <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> ":" <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span> <span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-IRI_REF" name="prod-IRI_REF"></a>[<span class="prodNo">63</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">IRI_REF</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"&lt;" ( [^&lt;&gt;\"{}|^`\\] - [#0000- ] | <span class="prod"><a class="grammarRef" href="#prod-UCHAR">UCHAR</a></span> )* "&gt;"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-STRING_LITERAL" name="prod-STRING_LITERAL"></a>[<span class="prodNo">64</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">STRING_LITERAL</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rSTRING_LITERAL2">STRING_LITERAL2</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-STRING_LITERAL2" name="prod-STRING_LITERAL2"></a>[<span class="prodNo">65</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">STRING_LITERAL2</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">\'"\' ( ( [^\"\\\n\r] ) | <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rECHAR">ECHAR</a></span> | <span class="prod"><a class="grammarRef" href="#prod-UCHAR">UCHAR</a></span> )* \'"\'</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-INT_LITERAL" name="prod-INT_LITERAL"></a>[<span class="prodNo">66</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">INT_LITERAL</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">("-")? (<span class="prod"><a class="grammarRef" href="#prod-DIGIT">DIGIT</a></span>)+</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-QUALIFIED_NAME_LITERAL" name="prod-QUALIFIED_NAME_LITERAL"></a>[<span class="prodNo">67</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">QUALIFIED_NAME_LITERAL</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"\'" <span class="prod"><a class="grammarRef" href="#prod-QUALIFIED_NAME">QUALIFIED_NAME</a></span> "\'"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-UCHAR" name="prod-UCHAR"></a>[<span class="prodNo">68</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">UCHAR</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( "\\u" <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> )<br/> ' + 
'| ( "\\U" <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> )</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-ECHAR" name="prod-ECHAR"></a>[<span class="prodNo">69</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">ECHAR</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"\\" [tbnrf\\\"\']</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-NIL" name="prod-NIL"></a>[<span class="prodNo">70</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">NIL</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"(" ( <span class="prod"><a class="grammarRef" href="#prod-WS">WS</a></span> )* ")"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-WS" name="prod-WS"></a>[<span class="prodNo">71</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">WS</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">" "<br/> ' + 
'| "\t"<br/> ' + 
'| "\r"<br/> ' + 
'| "\n"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-ANON" name="prod-ANON"></a>[<span class="prodNo">72</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">ANON</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"[" ( <span class="prod"><a class="grammarRef" href="#prod-WS">WS</a></span> )* "]"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_CHARS_BASE" name="prod-PN_CHARS_BASE"></a>[<span class="prodNo">73</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_CHARS_BASE</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">[A-Z]<br/> ' + 
'| [a-z]<br/> ' + 
'| [#00C0-#00D6]<br/> ' + 
'| [#00D8-#00F6]<br/> ' + 
'| [#00F8-#02FF]<br/> ' + 
'| [#0370-#037D]<br/> ' + 
'| [#037F-#1FFF]<br/> ' + 
'| [#200C-#200D]<br/> ' + 
'| [#2070-#218F]<br/> ' + 
'| [#2C00-#2FEF]<br/> ' + 
'| [#3001-#D7FF]<br/> ' + 
'| [#F900-#FDCF]<br/> ' + 
'| [#FDF0-#FFFD]<br/> ' + 
'| [#10000-#EFFFF]</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_CHARS_U" name="prod-PN_CHARS_U"></a>[<span class="prodNo">74</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_CHARS_U</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-PN_CHARS_BASE">PN_CHARS_BASE</a></span><br/> ' + 
'| "_"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_CHARS" name="prod-PN_CHARS"></a>[<span class="prodNo">75</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_CHARS</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS_U">PN_CHARS_U</a></span><br/> ' + 
'| "-"<br/> ' + 
'| [0-9]<br/> ' + 
'| <br/> ' + 
'| [#0300-#036F]<br/> ' + 
'| [#203F-#2040]</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_PREFIX" name="prod-PN_PREFIX"></a>[<span class="prodNo">76</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_PREFIX</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-PN_CHARS_BASE">PN_CHARS_BASE</a></span> ( ( <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS">PN_CHARS</a></span> | "." )* <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS">PN_CHARS</a></span> )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_LOCAL" name="prod-PN_LOCAL"></a>[<span class="prodNo">77</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_LOCAL</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">( <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS_U">PN_CHARS_U</a></span> | [0-9] | <span class="prod"><a class="grammarRef" href="#prod-PN_CHARS_OTHERS">PN_CHARS_OTHERS</a></span> ) ( ( <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS">PN_CHARS</a></span> | "." | <span class="prod"><a class="grammarRef" href="#prod-PN_CHARS_OTHERS">PN_CHARS_OTHERS</a></span> )* ( <span class="prod"><a class="grammarRef" href="http://www.w3.org/TR/rdf-sparql-query/#rPN_CHARS">PN_CHARS</a></span> | <span class="prod"><a class="grammarRef" href="#prod-PN_CHARS_OTHERS">PN_CHARS_OTHERS</a></span> ) )?</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PN_CHARS_OTHERS" name="prod-PN_CHARS_OTHERS"></a>[<span class="prodNo">78</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PN_CHARS_OTHERS</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content"><span class="prod"><a class="grammarRef" href="#prod-PERCENT">PERCENT</a></span><br/> ' + 
'| "/"<br/> ' + 
'| "@"<br/> ' + 
'| "~"<br/> ' + 
'| "&amp;"<br/> ' + 
'| "+"<br/> ' + 
'| "?"<br/> ' + 
'| "#"<br/> ' + 
'| "$"</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PERCENT" name="prod-PERCENT"></a>[<span class="prodNo">79</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">PERCENT</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">"%" <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span> <span class="prod"><a class="grammarRef" href="#prod-HEX">HEX</a></span></code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-HEX" name="prod-HEX"></a>[<span class="prodNo">80</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td>&lt;<code class="production term">HEX</code>&gt;</td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">[0-9]<br/> ' + 
'| [A-F]<br/> ' + 
'| [a-f]</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'<tbody class="term"> ' + 
'<tr valign="baseline"> ' + 
'<td><a id="prod-PASSED_TOKENS" name="prod-PASSED_TOKENS"></a>[<span class="prodNo">81</span>]&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="production directive">PASSED TOKENS</code></td> ' + 
'<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td> ' + 
'<td><code class="content">([ \t\r\n])+<br/> ' + 
'| "#" ([^\r\n])*</code></td> ' + 
'</tr> ' + 
'</tbody> ' + 
' ' + 
'</table> ' + 
' ' + 
' ' ;
