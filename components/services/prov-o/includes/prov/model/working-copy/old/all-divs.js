//Automatically generated file, don't edit!
//Include this all-divs.js file in your specification
//  with <script src="all-divs.js" class="remove"></script>
//Insert glossary definitions with the following 
// <div class="glossary-ref" ref="glossary-generation"></div>
divs_hg='http://dvcs.w3.org/hg/prov/file/8365f0c49114/model/working-copy/towards-wd4.html';
divs_string= 
'<html> ' + 
'<div class="buttonpanel"> ' + 
'      <form action="#"> ' + 
'        <p> ' + 
'          <input id="hide-asn" onclick="set_display_by_class(\'div\',\'withAsn\',\'none\');set_display_by_class(\'span\',\'withAsn\',\'none\'); set_display_by_id(\'hide-asn\',\'none\'); set_display_by_id(\'show-asn\',\'\');" type="button" value="Hide ASN" /> <input id="show-asn" onclick="set_display_by_class(\'div\',\'withAsn\',\'\'); set_display_by_class(\'span\',\'withAsn\',\'\');  set_display_by_id(\'hide-asn\',\'\'); set_display_by_id(\'show-asn\',\'none\');" style="display: none" type="button" value="Show ASN" /> ' + 
'        </p> ' + 
'      </form> ' + 
'    </div><div class="note" id="changes"> ' + 
'      <p> ' + 
'        Following F2F2 guidance, in this document we try to: ' + 
'      </p> ' + 
'      <ul> ' + 
'        <li> ' + 
'          pitch from the start the idea of an upgrade path, from \'scruffy ' + 
'          provenance\' (term TBD), to \'precise provenance\' (term TBD) ' + 
'        </li> ' + 
'        <li> ' + 
'          formulate concepts without referring to things, just in term of ' + 
'          entities, the intent is that the semantics only refers to things ' + 
'        </li> ' + 
'        <li> ' + 
'          introduce concepts minimally, just to be able to express \'scruffy ' + 
'          provenance\' ' + 
'        </li> ' + 
'        <li> ' + 
'          present the data model ' + 
'        </li> ' + 
'        <li> ' + 
'          present the upgrade path ' + 
'        </li> ' + 
'        <li> ' + 
'          contemplating the organization of the deliverable in two/three ' + 
'          separate documents. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="note" id="editorial-notes"> ' + 
'      <ul> ' + 
'        <li> ' + 
'          Term \'record\' dropped: we no longer refer to \'entity record\', ' + 
'          \'activity record\', etc but simply to \'entity\', \'activity\', etc ' + 
'        </li> ' + 
'        <li> ' + 
'          Aiming to drop the word \'assertion\'. This is work in progress. ' + 
'        </li> ' + 
'        <li> ' + 
'          Aiming to drop the word \'characterization\'. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="issue"> ' + 
'      There is a desire to use a single namespace that all specifications of the ' + 
'      PROV family can share to refer to common provenance terms. This is <a href="http://www.w3.org/2011/prov/track/issues/224">ISSUE-224</a>. ' + 
'    </div><div class="glossary-ref"> ' + 
'    </div><div class="anexample" id="entity-example"> ' + 
'      <p> ' + 
'        An entity may be the document at URI <a href="http://www.w3.org/TR/prov-dm/">http://www.w3.org/TR/prov-dm/</a>, ' + 
'        a file in a file system, a car or an idea. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="activity-example"> ' + 
'      <p> ' + 
'        An activity may be the publishing of a document on the web, sending a ' + 
'        twitter message, extracting metadata embedded in a file, or driving a ' + 
'        car from Boston to Cambridge, assembling a data set based on a set of ' + 
'        measurements, performing a statistical analysis over a data set, sorting ' + 
'        news items according to some criteria, running a SPARQL query over a ' + 
'        triple store, and editing a file. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="agent-example"> ' + 
'      <p> ' + 
'        Software for checking the use of grammar in a document may be defined as ' + 
'        an agent of a document preparation activity, and at the same time one ' + 
'        can describe its provenance, including for instance the vendor and the ' + 
'        version history. ' + 
'      </p> ' + 
'    </div><div class="glossary-ref"> ' + 
'    </div><div class="glossary-ref"> ' + 
'    </div><div class="anexample" id="generation-example"> ' + 
'      Examples of generation are the completed creation of a file by a program, ' + 
'      the completed creation of a linked data set, and the completed publication ' + 
'      of a new version of a document. ' + 
'    </div><div class="anexample" id="usage-example"> ' + 
'      Usage examples include a procedure beginning to consume an argument, a ' + 
'      service starting to read a value on a port, a program beginning to read a ' + 
'      configuration file, or the point at which an ingredient, such as eggs, is ' + 
'      being added in a baking activity. Usage may entirely consume an entity ' + 
'      (e.g. eggs are no longer available after being added to the mix); ' + 
'      alternatively, a same entity may be used multiple times, possibly by ' + 
'      different activities (e.g. a file on a file system can be read ' + 
'      indefinitely). ' + 
'    </div><div class="anexample" id="derivation-example"> ' + 
'      <p> ' + 
'        Examples of derivation include the transformation of a relational table ' + 
'        into a linked data set, the transformation of a canvas into a painting, ' + 
'        the transportation of a work of art from London to New York, and a ' + 
'        physical transformation such as the melting of ice into water. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="plan-example"> ' + 
'      <p> ' + 
'        A plan can be a blog post tutorial for how to set up a web server, a ' + 
'        list of instructions for a micro-processor execution, a cook\'s written ' + 
'        recipe for a chocolate cake, or a workflow for a scientific experiment. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="collection-example"> ' + 
'      <p> ' + 
'        An example of collection is an archive of documents. Each document has ' + 
'        its own provenance, but the archive itself also has some provenance: who ' + 
'        maintained it, which documents it contained at which point in time, how ' + 
'        it was assembled, etc. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="account-example"> ' + 
'      <p> ' + 
'        Having found a resource, a user may want to retrieve its provenance. For ' + 
'        users to decide whether they can place their trust in that resource, ' + 
'        they may want to analyze its provenance, but also determine who the ' + 
'        provenance is attributed to, and when it was generated. Hence, from the ' + 
'        PROV-DM data model, the provenance is regarded as an entity, an ' + 
'        AccountEntity, for which provenance can be sought. ' + 
'      </p> ' + 
'    </div><div class="anexample" id="software-agents-example"> ' + 
'      <p> ' + 
'        Even software agents can be assigned some responsibility for the effects ' + 
'        they have in the world, so for example if one is using a Text Editor and ' + 
'        one\'s laptop crashes, then one would say that the Text Editor was ' + 
'        responsible for crashing the laptop. If one invokes a service to buy a ' + 
'        book, that service can be considered responsible for drawing funds from ' + 
'        one\'s bank to make the purchase (the company that runs the service and ' + 
'        the web site would also be responsible, but the point here is that we ' + 
'        assign some measure of responsibility to software as well). ' + 
'      </p> ' + 
'    </div><div class="anexample" id="association-example"> ' + 
'      <p> ' + 
'        Examples of association between an activity and agent are: ' + 
'      </p> ' + 
'      <ul> ' + 
'        <li> ' + 
'          creation of a web page under the guidance of a designer; ' + 
'        </li> ' + 
'        <li> ' + 
'          various forms of participation in a panel discussion, including ' + 
'          audience member, panelist, or panel chair; ' + 
'        </li> ' + 
'        <li> ' + 
'          a public event, sponsored by a company, and hosted by a museum; ' + 
'        </li> ' + 
'        <li> ' + 
'          an XSLT transform initiated by a user; ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample" id="responsibilityChain-example"> ' + 
'      <p> ' + 
'        A student publishing a web page describing an academic department could ' + 
'        result in both the student and the department being agents associated ' + 
'        with the activity, and it may not matter which student published a web ' + 
'        page but it matters a lot that the department told the student to put up ' + 
'        the web page. ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      TODO: short text required to explain the overview diagram ' + 
'    </div><div class="note"> ' + 
'      Illustration to be hand crafted instead of being generated automatically. ' + 
'      It\'s important to adopt a common style for all illustrations across all ' + 
'      PROV documents. ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-entity"> ' + 
'      An entity<span class="withAsn">, written <span class="name">entity(id, [ ' + 
'      attr1=val1, ...])</span> in PROV-ASN, </span> contains: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an identifier identifying an entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs ' + 
'          representing this entity\'s situation in the world. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expression ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="document", ex:version="2" ]) ' + 
'</pre> ' + 
'      states the existence of an entity, denoted by identifier <span class="name">tr:WD-prov-dm-20111215</span>, ' + 
'      with type <span class="name">document</span> and version number <span class="name">2</span>. The attributes <span class="name">ex:version</span> ' + 
'      is application specific, whereas the attribute <span class="name">type</span> ' + 
'      is reserved in the PROV-DM namespace. ' + 
'       <!-- The following expression</p> <pre class="codeexample"> ' + 
'        entity(tr:WD-prov-dm-20111215, [ prov:type="document", ex:version="2" ]) ' + 
'        entity(e0, [ prov:type="File", ex:path="/shared/crime.txt", ' + 
'        ex:creator="Alice" ]) </pre> states the existence of an entity, denoted ' + 
'        by identifier <span class="name">e0</span>, with type <span ' + 
'        class="name">File</span> and path <span ' + 
'        class="name">/shared/crime.txt</span> in the file system, and creator ' + 
'        alice. The attributes <span class="name">path</span> and <span ' + 
'        class="name">creator</span> are application specific, whereas the ' + 
'        attribute <span class="name">type</span> is reserved in the PROV-DM ' + 
'        namespace. --> ' + 
'    </div><div class="issue"> ' + 
'      The characterization interval of an entity is currently implicit. Making ' + 
'      it explicit would allow us to define wasComplementOf more precisely. ' + 
'      Beginning and end of characterization interval could be expressed by ' + 
'      attributes (similarly to activities). How do we define the end of an ' + 
'      entity? This is <a href="http://www.w3.org/2011/prov/track/issues/204">ISSUE-204</a>. ' + 
'    </div><div class="issue"> ' + 
'      There is still some confusion about what the identifiers really denote. ' + 
'      For instance, are they entity identifiers or entity record identifiers. ' + 
'      This is <a href="http://www.w3.org/2011/prov/track/issues/183">ISSUE-183</a>. ' + 
'      An example and questions appear in <a href="http://www.w3.org/2011/prov/track/issues/215">ISSUE-215</a>. A ' + 
'      related issued is also raised in <a href="http://www.w3.org/2011/prov/track/issues/145">ISSUE-145</a>. ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-activity"> ' + 
'      An activity<span class="withAsn">, written <span class="name">activity(id, ' + 
'      st, et, [ attr1=val1, ...])</span> in PROV-ASN,</span> contains: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an identifier identifying an activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>startTime</em>: an OPTIONAL time for the start of the activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>endTime</em>: an OPTIONAL time for the end of the activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs for this ' + 
'          activity. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expression ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(a1,2011-11-16T16:05:00,2011-11-16T16:06:00, ' + 
'        [ex:host="server.example.org",prov:type="ex:edit" %% xsd:QName]) ' + 
'</pre> ' + 
'      <p> ' + 
'        states the existence of an activity with identifier <span class="name">a1</span>, ' + 
'        start time <span class="name">2011-11-16T16:05:00</span>, and end time ' + 
'        <span class="name">2011-11-16T16:06:00</span>, running on host <span class="name">server.example.org</span>, and of type <span class="name">edit</span>. ' + 
'        The attribute <span class="name">host</span> is application specific ' + 
'        (declared in some namespace with prefix <span class="name">ex</span>). ' + 
'        The attribute <span class="name">type</span> is a reserved attribute of ' + 
'        PROV-DM, allowing for sub-typing to be expressed. ' + 
'      </p> ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-agent"> ' + 
'      An agent<span class="withAsn">, noted <span class="name">agent(id, [ ' + 
'      attr1=val1, ...])</span> in PROV-ASN,</span> contains: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an identifier identifying an agent; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: a set of attribute-value pairs representing this ' + 
'          agent\'s situation in the world. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expression is about an agent identified by <span class="name">e1</span>, which is a person, named Alice, with employee ' + 
'        number 1234. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'agent(e1, [ex:employee="1234", ex:name="Alice", prov:type="prov:Human" %% xsd:QName]) ' + 
'</pre> ' + 
'      <p> ' + 
'        It is optional to specify the type of an agent. When present, it is ' + 
'        expressed using the <span class="name">prov:type</span> attribute. ' + 
'      </p> ' + 
'    </div><div class="issue"> ' + 
'      Shouldn\'t we allow for entities (not agent) to be associated with an ' + 
'      activity? Should we drop the inference association-agent? <a href="http://www.w3.org/2011/prov/track/issues/203">ISSUE-203</a>. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following note consists of a set of application-specific ' + 
'        attribute-value pairs, intended to help the rendering of what it is ' + 
'        associated with, by specifying its color and its position on the screen. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'note(ex2:n1,[ex2:color="blue", ex2:screenX=20, ex2:screenY=30]) ' + 
'hasAnnotation(tr:WD-prov-dm-20111215,ex2:n1) ' + 
'</pre> ' + 
'      <p> ' + 
'        The note is associated with the entity <span class="name">tr:WD-prov-dm-20111215</span> ' + 
'        previously introduced (<a title="annotation">hasAnnotation</a> is ' + 
'        discussed in Section <a href="#term-annotation">Annotation</a>). The ' + 
'        note\'s identifier and attributes are declares in a separate namespace ' + 
'        denoted by prefix <span class="name">ex2</span>. ' + 
'      </p> ' + 
'      <p> ' + 
'        Alternatively, a reputation service may enrich a provenance record with ' + 
'        notes providing reputation ratings about agents. In the following ' + 
'        fragment, both agents <span class="name">ex:Simon</span> and <span class="name">ex:Paolo</span> are rated "excellent". ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'note(ex3:n2,[ex3:reputation="excellent"]) ' + 
'hasAnnotation(ex:Simon,ex3:n2) ' + 
'hasAnnotation(ex:Paolo,ex3:n2) ' + 
'</pre> ' + 
'      <p> ' + 
'        The note\'s identifier and attributes are declares in a separate ' + 
'        namespace denoted by prefix <span class="name">ex3</span>. ' + 
'      </p> ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-generation"> ' + 
'      <dfn title="dfn-Generation">Generation</dfn><span class="withAsn">, ' + 
'      written <span class="name">wasGeneratedBy(id,e,a,t,attrs)</span> in ' + 
'      PROV-ASN,</span> has the following components: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an OPTIONAL identifier identifying a generation; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>entity</em>: an identifier identifying a created entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>activity</em>: an OPTIONAL identifier identifying the activity ' + 
'          that creates the entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>time</em>: an OPTIONAL "generation time", the time at which the ' + 
'          entity was completely created; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs that ' + 
'          describes the modalities of generation of this entity by this ' + 
'          activity. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expressions ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  wasGeneratedBy(e1,a1, 2001-10-26T21:32:52, [ex:port="p1", ex:order=1]) ' + 
'  wasGeneratedBy(e2,a1, 2001-10-26T10:00:00, [ex:port="p1", ex:order=2]) ' + 
'</pre> ' + 
'      <p> ' + 
'        state the existence of two generations (with respective times <span class="name">2001-10-26T21:32:52</span> and <span class="name">2001-10-26T10:00:00</span>), ' + 
'        at which new entities, identified by <span class="name">e1</span> and ' + 
'        <span class="name">e2</span>, are created by an activity, identified by ' + 
'        <span class="name">a1</span>. The first one is available as the first ' + 
'        value on port p1, whereas the other is the second value on port p1. The ' + 
'        semantics of <span class="name">port</span> and <span class="name">order</span> ' + 
'        are application specific. ' + 
'      </p> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        In some cases, we may want to record the time at which an entity was ' + 
'        generated without having to specify the activity that generated it. To ' + 
'        support this requirement, the activity component in generation is ' + 
'        optional. Hence, the following expression indicates the time at which an ' + 
'        entity is generated, without naming the activity that did it. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  wasGeneratedBy(e,,2001-10-26T21:32:52) ' + 
'</pre> ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-usage"> ' + 
'      <dfn title="dfn-Usage">Usage</dfn><span class="withAsn">, written <span class="name">used(id,a,e,t,attrs)</span> in PROV-ASN,</span> has the ' + 
'      following constituents: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an OPTIONAL identifier identifying a usage; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>activity</em>: an identifier for the consuming activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>entity</em>: an identifier for the consumed entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>time</em>: an OPTIONAL "usage time", the time at which the entity ' + 
'          started to be used; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs that ' + 
'          describe the modalities of usage of this entity by this activity. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following usages ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  used(a1,e1,2011-11-16T16:00:00,[ex:parameter="p1"]) ' + 
'  used(a1,e2,2011-11-16T16:00:01,[ex:parameter="p2"]) ' + 
'</pre> ' + 
'      <p> ' + 
'        state that the activity identified by <span class="name">a1</span> ' + 
'        consumed two entities identified by <span class="name">e1</span> and ' + 
'        <span class="name">e2</span>, at times <span class="name">2011-11-16T16:00:00</span> ' + 
'        and <span class="name">2011-11-16T16:00:01</span>, respectively; the ' + 
'        first one was found as the value of parameter <span class="name">p1</span>, ' + 
'        whereas the second was found as value of parameter <span class="name">p2</span>. ' + 
'        The semantics of <span class="name">parameter</span> is application ' + 
'        specific. ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      <p> ' + 
'        A usage record\'s id is OPTIONAL. It MUST be present when annotating ' + 
'        usage records (see Section <a href="#term-annotation">Annotation Record</a>) ' + 
'        or when defining precise-1 derivations (see <a href="#Derivation-Relation">Derivation</a>). ' + 
'      </p> ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-activity-association"> ' + 
'      An <dfn title="dfn-activity-association">activity association</dfn><span class="withAsn">, written <span class="name">wasAssociatedWith(id,a,ag,pl,attrs)</span> ' + 
'      in PROV-ASN,</span> has the following constituents: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an OPTIONAL identifier for the association between an ' + 
'          activity and an agent; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>activity</em>: an identifier for the activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>agent</em>: an identifier for the agent associated with the ' + 
'          activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>plan</em>: an OPTIONAL identifier for the plan adopted by the ' + 
'          agent in the context of this activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs that ' + 
'          describe the modalities of association of this activity with this ' + 
'          agent. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      In the following example, a designer and an operator agents are associated ' + 
'      with an activity. The designer\'s goals are achieved by a workflow <span class="name">ex:wf</span>. ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(ex:a,[prov:type="workflow execution"]) ' + 
'agent(ex:ag1,[prov:type="operator"]) ' + 
'agent(ex:ag2,[prov:type="designer"]) ' + 
'wasAssociatedWith(ex:a,ex:ag1,[prov:role="loggedInUser", ex:how="webapp"]) ' + 
'wasAssociatedWith(ex:a,ex:ag2,ex:wf,[prov:role="designer", ex:context="project1"]) ' + 
'entity(ex:wf,[prov:type="prov:Plan"%% xsd:QName, ex:label="Workflow 1",  ' + 
'              ex:url="http://example.org/workflow1.bpel" %% xsd:anyURI]) ' + 
'</pre> ' + 
'      Since the workflow <span class="name">ex:wf</span> is itself an entity, ' + 
'      its provenance can also be expressed in PROV-DM: it can be generated by ' + 
'      some activity and derived from other entities, for instance. ' + 
'    </div><div class="issue"> ' + 
'      The activity association record does not allow for a plan to be asserted ' + 
'      without an agent. This seems over-restrictive. Discussed in the context of ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/203">ISSUE-203</a>. ' + 
'    </div><div class="issue"> ' + 
'      Agents should not be inferred. WasAssociatedWith should also work with ' + 
'      entities. This is <a href="http://www.w3.org/2011/prov/track/issues/206">ISSUE-206</a>. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        In the following example, ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'wasStartedBy(a,ag,[ex:mode="manual"]) ' + 
'wasEndedby(a,ag,[ex:mode="manual"]) ' + 
'</pre> ' + 
'      <p> ' + 
'        there is an activity denoted by <span class="name">a</span> that was ' + 
'        started and ended by an agent denoted by <span class="name">ag</span>, ' + 
'        in "manual" mode, an application specific characterization of these ' + 
'        relations. ' + 
'      </p> ' + 
'    </div><div class="issue"> ' + 
'      Should we define start/end records as representation of activity start/end ' + 
'      events. Should time be associated with these events rather than with ' + 
'      activities. This will be similar to what we do for entities. This is issue ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/207">ISSUE-207</a>. ' + 
'    </div><div class="glossary-ref" /><div class="attributes" id="attributes-responsibility-chain"> ' + 
'      A <dfn title="dfn-responsibility-chain">responsibility chain</dfn><span class="withAsn">, written <span class="name">actedOnBehalfOf(id,ag2,ag1,a,attrs)</span> ' + 
'      in PROV-ASN,</span> has the following constituents: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an OPTIONAL identifier identifying the responsibility ' + 
'          chain; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>subordinate</em>: an identifier for the agent associated with an ' + 
'          activity, acting on behalf of the responsible agent; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>responsible</em>: an identifier for the agent, on behalf of which ' + 
'          the subordinate agent acted; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>activity</em>: an OPTIONAL identifier of an activity for which the ' + 
'          responsibility chain holds; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs that ' + 
'          describe the modalities of this relation. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      In the following example, a programmer, a researcher and a funder agents ' + 
'      are described. The programmer and researcher are associated with a ' + 
'      workflow activity. The programmer acts on behalf of the researcher ' + 
'      (delegation) encoding the commands specified by the researcher; the ' + 
'      researcher acts on behalf of the funder, who has an contractual agreement ' + 
'      with the researcher. The terms \'delegation\' and \'contact\' used in this ' + 
'      example are domain specific. ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(a,[prov:type="workflow"]) ' + 
'agent(ag1,[prov:type="programmer"]) ' + 
'agent(ag2,[prov:type="researcher"]) ' + 
'agent(ag3,[prov:type="funder"]) ' + 
'wasAssociatedWith(a,ag1,[prov:role="loggedInUser"]) ' + 
'wasAssociatedWith(a,ag2) ' + 
'actedOnBehalfOf(ag1,ag2,a,[prov:type="delegation"]) ' + 
'actedOnBehalfOf(ag2,ag3,a,[prov:type="contract"]) ' + 
'</pre> ' + 
'    </div><div class="glossary-ref" /><div class="note"> ' + 
'      This text was not edited much. It keeps on referring to ' + 
'      asserter/assertion. Before editing this section, we would like to have <a href="http://www.w3.org/2011/prov/track/issues/249">ISSUE-249</a> ' + 
'      resolved. ' + 
'    </div><div class="attributes" id="attributes-derivation"> ' + 
'      A <dfn>precise-1 derivation</dfn><span class="withAsn">, written <span class="name">wasDerivedFrom(id, e2, e1, a, g2, u1, attrs)</span> in ' + 
'      PROV-ASN,</span> contains: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <em>id</em>: an OPTIONAL identifier identifying the derivation; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>generatedEntity</em>: the identifier of the generation entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>usedEntity</em>: the identifier of the used entity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>activity</em>: the identifier of the activity using and generating ' + 
'          the above entities; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>generation</em>: the identifier the generation for the generated ' + 
'          entity and activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>usage</em>: the identifier of the usage for the used entity and ' + 
'          activity; ' + 
'        </li> ' + 
'        <li> ' + 
'          <em>attributes</em>: an OPTIONAL set of attribute-value pairs that ' + 
'          describe the modalities of this derivation, optionally including the ' + 
'          attribute-value pair <span class="name">prov:steps="single"</span>. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following descriptions state the existence of derivations. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'wasDerivedFrom(e5,e3,a4,g2,u2) ' + 
'wasDerivedFrom(e5,e3,a4,g2,u2,[prov:steps="single"]) ' + 
' ' + 
'wasDerivedFrom(e3,e2,[prov:steps="single"]) ' + 
' ' + 
'wasDerivedFrom(e2,e1,[]) ' + 
'wasDerivedFrom(e2,e1,[prov:steps="any"]) ' + 
' ' + 
'wasDerivedFrom(e2,e1,2012-01-18T16:00:00, [prov:steps="any"]) ' + 
'</pre> ' + 
'      <p> ' + 
'        The first two are precise-1 derivations expressing that the activity ' + 
'        identified by <span class="name">a4</span>, by using the entity denoted ' + 
'        by <span class="name">e3</span> according to usage <span class="name">u2</span> ' + 
'        derived the entity denoted by <span class="name">e5</span> and generated ' + 
'        it according to generation <span class="name">g2</span>. ' + 
'      </p> ' + 
'      <p> ' + 
'        The third line describes an imprecise-1 derivation, which is similar for ' + 
'        <span class="name">e3</span> and <span class="name">e2</span>, but it ' + 
'        leaves the activity and associated attributes implicit. The fourth and ' + 
'        fifth lines are about imprecise-n derivations between <span class="name">e2</span> ' + 
'        and <span class="name">e1</span>, but no information is provided as to ' + 
'        the number and identity of activities underpinning the derivation. The ' + 
'        sixth derivation extends the fifth with the derivation time of <span class="name">e2</span>. ' + 
'      </p> ' + 
'    </div><div class="issue"> ' + 
'      Several points were raised about the attribute steps. Its name, its ' + 
'      default value <a href="http://www.w3.org/2011/prov/track/issues/180">ISSUE-180</a>. ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/179">ISSUE-179</a>. ' + 
'    </div><div class="issue"> ' + 
'      Emphasize the notion of \'affected by\' <a href="http://www.w3.org/2011/prov/track/issues/133">ISSUE-133</a>. ' + 
'    </div><div class="issue"> ' + 
'      Is imprecise-1 derivation necessary? Can we just use precise-1 and ' + 
'      imprecise-n? <a href="http://www.w3.org/2011/prov/track/issues/249">ISSUE-249</a>. ' + 
'    </div><div class="anexample" id="anexample-alternate"> ' + 
'      <p> ' + 
'        The following expressions describe two persons, respectively holder of a ' + 
'        Facebook account and a Twitter account, and their relation as alternate. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(facebook:ABC, [ prov:type="person with Facebook account " ]) ' + 
'entity(twitter:XYZ, [ prov:type="person with Twitter account" ]) ' + 
'alternateOf(facebook:ABC, twitter:XYZ) ' + 
'</pre> ' + 
'    </div><div class="anexample" id="anexample-specialization"> ' + 
'      <p> ' + 
'        The following expressions describe two persons, the second of which is ' + 
'        holder of a Twitter account. The second entity is a specialization of ' + 
'        the first. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(ex:Bob, [ prov:type="person", ex:name="Bob" ]) ' + 
'entity(twitter:XYZ, [ prov:type="person with Twitter account" ]) ' + 
'specializationOf(twitter:XYZ, ex:Bob) ' + 
'</pre> ' + 
'    </div><div class="issue"> ' + 
'      A discussion on alternative definition of these relations has not yet ' + 
'      reached a satisfactory conclusion. This is <a href="http://www.w3.org/2011/prov/track/issues/29">ISSUE-29</a>. Also <a href="http://www.w3.org/2011/prov/track/issues/96">ISSUE-96</a>. ' + 
'    </div><div class="glossary" id="glossary-annotation"> ' + 
'      An <dfn title="concept-annotation">annotation</dfn> is a link between ' + 
'      something that is identifiable and a note referred to by its identifier. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expressions ' + 
'      </p> ' + 
'<pre class="codexample" xml:space="preserve"> ' + 
'entity(e1,[prov:type="document"]) ' + 
'entity(e2,[prov:type="document"]) ' + 
'activity(a,t1,t2) ' + 
'used(u1,a,e1,[ex:file="stdin"]) ' + 
'wasGeneratedBy(e2, a, [ex:file="stdout"]) ' + 
' ' + 
'note(n1,[ex:icon="doc.png"]) ' + 
'hasAnnotation(e1,n1) ' + 
'hasAnnotation(e2,n1) ' + 
' ' + 
'note(n2,[ex:style="dotted"]) ' + 
'hasAnnotation(u1,n2) ' + 
'</pre> ' + 
'      <p> ' + 
'        describe two documents (attribute-value pair: <span class="name">prov:type="document"</span>) ' + 
'        identified by <span class="name">e1</span> and <span class="name">e2</span>, ' + 
'        and their annotation with a note indicating that the icon (an ' + 
'        application specific way of rendering provenance) is <span class="name">doc.png</span>. ' + 
'        The example also includes an activity, its usage of the first entity, ' + 
'        and its generation of the second entity. The <a title="dfn-usage">usage</a> ' + 
'        is annotated with a style (an application specific way of rendering this ' + 
'        edge graphically). To be able to express this annotation, the usage was ' + 
'        provided with an identifier <span class="name">u1</span>, which was then ' + 
'        referred to in <span class="name">hasAnnotation(u1,n2)</span>. ' + 
'      </p> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following activity start describes the role of the agent identified ' + 
'        by <span class="name">ag</span> in this start relation with activity ' + 
'        <span class="name">a</span>. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'   wasStartedBy(a,ag, [prov:role="program-operator"]) ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following describes an agent of type software agent. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'   agent(ag, [prov:type="prov:ComputingSystem" %% xsd:QName]) ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expression declares an imprecise-1 derivation, which is ' + 
'        known to involve one activity, though its identity, usage details of ' + 
'        <span class="name">ex:e1</span>, and generation details of <span class="name">ex:e2</span> are not explicit. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'   wasDerivedFrom(ex:e2, ex:e1, [prov:steps="single"]) ' + 
'</pre> ' + 
'    </div><div class="issue"> ' + 
'      This is <a href="http://www.w3.org/2011/prov/track/issues/219">ISSUE-219</a>. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following expression describes entity Mona Lisa, a painting, with a ' + 
'        location attribute. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
' entity(ex:MonaLisa, [prov:location="Le Louvres, Paris", prov:type="StillImage"]) ' + 
'</pre> ' + 
'    </div><div class="note"> ' + 
'      Usually, in programming languages, Literal are a notation for values. So, ' + 
'      Literals should probably be moved to the serialization. Here, instead, we ' + 
'      should define the types of values. Thoughts? ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The following examples respectively are the string "abc", the string ' + 
'        "abc", the integer number 1, and the IRI "http://example.org/foo". ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  "abc" ' + 
'  1 ' + 
'  "http://example.org/foo" %% xsd:anyURI ' + 
'</pre> ' + 
'      <p> ' + 
'        The following example shows a literal of type <span class="name">xsd:QName</span> ' + 
'        (see <a href="http://www.w3.org/TR/2004/REC-xmlschema-2-20041028/#QName">QName</a> ' + 
'        [[!XMLSCHEMA-2]]). The prefix <span class="name">ex</span> MUST be bound ' + 
'        to a <a>namespace</a> declared in a <a>namespace declaration</a>. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  "ex:value" %% xsd:QName ' + 
'</pre> ' + 
'    </div><div class="note"> ' + 
'      It\'s a legacy of the charter that time is a top level section. Time is a ' + 
'      specific kind of value, and should be folded into the "value" section. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        Revisiting the example of <a href="#section-example-a">Section 3.1</a>, ' + 
'        we can now state that the report <span class="name">tr:WD-prov-dm-20111215</span> ' + 
'        is a revision of the report <span class="name">tr:WD-prov-dm-20111018</span>, ' + 
'        approved by agent <span class="name">w3:Consortium</span>. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="pr:RecsWD" %% xsd:QName ]) ' + 
'entity(tr:WD-prov-dm-20111018, [ prov:type="pr:RecsWD" %% xsd:QName ]) ' + 
'wasRevisionOf(tr:WD-prov-dm-20111215, tr:WD-prov-dm-20111018, w3:Consortium) ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        Revisiting the example of <a href="#section-example-b">Section 3.2</a>, ' + 
'        we can ascribe <span class="name">tr:WD-prov-dm-20111215</span> to some ' + 
'        agents without having to make an activity explicit. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'agent(ex:Paolo, [ prov:type="Human" ]) ' + 
'agent(ex:Simon, [ prov:type="Human" ]) ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="pr:RecsWD" %% xsd:QName ]) ' + 
'wasAttributedTo(tr:WD-prov-dm-20111215, ex:Paolo, [prov:role="editor"]) ' + 
'wasAttributedTo(tr:WD-prov-dm-20111215, ex:Simon, [prov:role="contributor"]) ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        Consider two long running services, which we represent by activities ' + 
'        <span class="name">s1</span> and <span class="name">s2</span>. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(s1,,,[prov:type="service"]) ' + 
'activity(s2,,,[prov:type="service"]) ' + 
'wasInformedBy(s2,s1) ' + 
'</pre> ' + 
'      The last line indicates that some entity was generated by <span class="name">s1</span> and used by <span class="name">s2</span>. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        Suppose activities <span class="name">a1</span> and <span class="name">a2</span> ' + 
'        are computer processes that are executed on different hosts, and that ' + 
'        <span class="name">a1</span> started <span class="name">a2</span>. This ' + 
'        can be expressed as in the following fragment: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(a1,t1,t2,[ex:host="server1.example.org",prov:type="workflow"]) ' + 
'activity(a2,t3,t4,[ex:host="server2.example.org",prov:type="subworkflow"]) ' + 
'wasStartedBy(a2,a1) ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        We refer to the example of <a href="#section-example-a">Section 3.1</a>, ' + 
'        and specifically to <a href="#prov-tech-report">Figure prov-tech-report</a>. ' + 
'        We can see that there is a path from <span class="name">tr:WD-prov-dm-20111215</span> ' + 
'        to <span class="name">w3:Consortium</span> or to <span class="name">pr:rec-advance</span>. ' + 
'        This is expressed as follows. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
' tracedTo(tr:WD-prov-dm-20111215,w3:Consortium) ' + 
' tracedTo(tr:WD-prov-dm-20111215,pr:rec-advance) ' + 
'</pre> ' + 
'    </div><div class="note"> ' + 
'      I propose to delete the following, given that this document does not ' + 
'      mention inferences. [LM] ' + 
'      <p> ' + 
'        Further considerations: ' + 
'      </p> ' + 
'      <ul> ' + 
'        <li> ' + 
'          Traceability is more general than <a href="#Derivation-Relation">Derivation</a>. ' + 
'          This means that an assertion of the form: <span class="name">tracedTo(...,e2,e1,...)</span> ' + 
'          can be inferred from an assertion of the form: <span class="name">wasDerivedFrom(e2,e1,..)</span>. ' + 
'          The precise inference rules are specified in [REF]. ' + 
'        </li> ' + 
'        <li> ' + 
'          Traceability is related to responsibility by way of inference rules ' + 
'          that involve <a href="#term-responsibility">responsibility chain</a> ' + 
'          and <a href="#term-Generation">generation</a> relations. These rules ' + 
'          are specified in [REF] ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="note"> ' + 
'      looking at the definition, there is something wrong. It\'s not true that e2 ' + 
'      was neceaary for e1 (in the transitive case) and that e1 bears ' + 
'      responsibility. [LM] ' + 
'    </div><div class="note"> ' + 
'      I find that quotation is really a misnomer. This expands into derivation ' + 
'      with attribution, in what sense is the derived entity a "quote" of the ' + 
'      original? . The agent that is quoted is particularly obscure. It does not ' + 
'      seem to be involved in the quoting at all. Why isn\'t quoting an activity ' + 
'      with the quoting agent associated with it? [PM] ' + 
'    </div><div class="note"> ' + 
'      Omitted as this is likely to be removed [PM] ' + 
'    </div><div class="issue"> ' + 
'      Drop this relation <a href="http://www.w3.org/2011/prov/track/issues/220">ISSUE-220</a>. ' + 
'    </div><div class="note"> ' + 
'      I find this relation confusing. Please add an example. I wouldn\'t really ' + 
'      know when to use this. [PM] ' + 
'    </div><div class="anexample"> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'   entity(c, [prov:type="EmptyCollection"])    // e is an empty collection ' + 
'   entity(v1) ' + 
'   entity(v2) ' + 
'   entity(c1, [prov:type="Collection"]) ' + 
'   entity(c2, [prov:type="Collection"]) ' + 
'   ' + 
'  CollectionAfterInsertion(c1, c, "k1", v1)       // c1 = { ("k1",v1) } ' + 
'  CollectionAfterInsertion(c2, c1, "k2", v2)      // c2 = { ("k1",v1), ("k2", v2) } ' + 
'  CollectionAfterRemoval(c3, c2, k1)              // c3 = { ("k2",v2) } ' + 
'</pre> ' + 
'    </div><div class="note"> ' + 
'      I propose to call them afterInsertion instead of CollectionAfterInsertion ' + 
'      (likewise, for deletion). What about attributes and optional Id? ' + 
'    </div><div class="note"> ' + 
'      Deleted further items. Some of them are constraints which belong to part ' + 
'      2. ' + 
'    </div><div id="glossary_div" class="remove"> ' + 
'      <!--  glossary loaded from glossary.js will be hooked up here, class ' + 
'        remove, will remove this element from the final output. --> ' + 
'    </div><div class="buttonpanel"> ' + 
'      <form action="#"> ' + 
'        <p> ' + 
'          <input id="hide-bnf" onclick="set_display_by_class(\'div\',\'grammar\',\'none\'); set_display_by_id(\'hide-bnf\',\'none\');  set_display_by_id(\'show-bnf\',\'\');" type="button" value="Hide Grammar" /> <input id="show-bnf" onclick="set_display_by_class(\'div\',\'grammar\',\'\'); set_display_by_id(\'hide-bnf\',\'\');  set_display_by_id(\'show-bnf\',\'none\');" style="display: none" type="button" value="Show Grammar" /> <input id="hide-examples" onclick="set_display_by_class(\'div\',\'anexample\',\'none\'); set_display_by_id(\'hide-examples\',\'none\'); set_display_by_id(\'show-examples\',\'\');" type="button" value="Hide Examples" /> <input id="show-examples" onclick="set_display_by_class(\'div\',\'anexample\',\'\'); set_display_by_id(\'hide-examples\',\'\'); set_display_by_id(\'show-examples\',\'none\');" style="display: none" type="button" value="Show Examples" /> ' + 
'        </p> ' + 
'      </form> ' + 
'    </div><div class="note"> ' + 
'      TODO ' + 
'    </div><div class="note"> ' + 
'      Tentative definition of destruction! ' + 
'    </div><div class="anexample" id="a-report-example"> ' + 
'      Different users may take different perspectives on a resource with a URL. ' + 
'      For each perspective, an entity may be expressed: ' + 
'      <ul> ' + 
'        <li> ' + 
'          a report available at a URL: fixes the nature of the thing, i.e. a ' + 
'          document, and its location; ' + 
'        </li> ' + 
'        <li> ' + 
'          the version of the report available there today: fixes its version ' + 
'          number, contents, and its date; ' + 
'        </li> ' + 
'        <li> ' + 
'          the report independent of where it is hosted and of its content over ' + 
'          time: fixes the nature of the thing as a conceptual artifact. ' + 
'        </li> ' + 
'      </ul> ' + 
'      The provenance of these three entities may differ, and may be along the ' + 
'      following lines: ' + 
'      <ul> ' + 
'        <li> ' + 
'          the provenance of a report available at a URL may include: the act of ' + 
'          publishing it and making it available at a given location, possibly ' + 
'          under some license and access control; ' + 
'        </li> ' + 
'        <li> ' + 
'          the provenance of the version of the report available there today may ' + 
'          include: the authorship of the specific content, and reference to ' + 
'          imported content; ' + 
'        </li> ' + 
'        <li> ' + 
'          the provenance of the report independent of where it is hosted over ' + 
'          time may include: the motivation for writing the report, the overall ' + 
'          methodology for producing it, and the broad team involved in it. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="anexample"> ' + 
'      A file at some point during its lifecycle, which includes multiple edits ' + 
'      by multiple people, can be described by its type, its location in the file ' + 
'      system, a creator, and content. ' + 
'    </div><div class="issue"> ' + 
'      We need to refine the definition of entity and activity, and all the ' + 
'      concepts in general. This is <a href="http://www.w3.org/2011/prov/track/issues/223">ISSUE-223</a>. ' + 
'    </div><div class="note"> ' + 
'      The last point is important and needs to be discussed by the Working ' + 
'      Group. It indicates that within an account: ' + 
'      <ul> ' + 
'        <li> ' + 
'          It is always possible to add new provenance descriptions, e.g. stating ' + 
'          that a given entity was used by an activity. This is very much an open ' + 
'          world assumption. ' + 
'        </li> ' + 
'        <li> ' + 
'          It is not permitted to add new attributes to a given entity (a form of ' + 
'          closed world assumption from the attributes point of view), though it ' + 
'          is always permitted to create a new description for an entity, which ' + 
'          is a "copy" of the original description extended with novel attributes ' + 
'          (cf Example <a href="#merge-with-rename">merge-with-rename</a>). ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="note"> ' + 
'      <p> ' + 
'        Overview the kind of constraints ' + 
'      </p> ' + 
'      <ul> ' + 
'        <li> ' + 
'          Definitional constraints (<a href="#definitional-constraints">Section ' + 
'          4</a>) ' + 
'        </li> ' + 
'        <li> ' + 
'          Account constraints (<a href="#account-constraints">Section 5</a>) ' + 
'        </li> ' + 
'        <li> ' + 
'          Event ordering constraints (<a href="#interpretation">Section 6</a>) ' + 
'        </li> ' + 
'        <li> ' + 
'          Structural constraints (<a href="#structural-constraints">Section 7</a>) ' + 
'        </li> ' + 
'        <li> ' + 
'          Collection constraints (<a href="#collection-constraints">Section 8</a>) ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="note"> ' + 
'      Proposing to remove the subsections in this section, since some have no ' + 
'      constraints. ' + 
'    </div><div class="issue"> ' + 
'      There is still some confusion about what the identifiers really denote. ' + 
'      For instance, are they entity identifiers or entity record identifiers. ' + 
'      This is <a href="http://www.w3.org/2011/prov/track/issues/183">ISSUE-183</a>. ' + 
'      An example and questions appear in <a href="http://www.w3.org/2011/prov/track/issues/215">ISSUE-215</a>. A ' + 
'      related issued is also raised in <a href="http://www.w3.org/2011/prov/track/issues/145">ISSUE-145</a>. ' + 
'    </div><div class="issue"> ' + 
'      The characterization interval of an entity record is currently implicit. ' + 
'      Making it explicit would allow us to define alternateOf and ' + 
'      specializationOf more precisely. Beginning and end of characterization ' + 
'      interval could be expressed by attributes (similarly to activities). How ' + 
'      do we define the end of an entity? This is <a href="http://www.w3.org/2011/prov/track/issues/204">ISSUE-204</a>. ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of an activity, see <a href="#start-precedes-end">start-precedes-end</a>. ' + 
'    </div><div class="issue"> ' + 
'      Shouldn\'t we allow for entities (not agent) to be associated with an ' + 
'      activity? Should we drop the inference association-agent? <a href="http://www.w3.org/2011/prov/track/issues/203">ISSUE-203</a>. ' + 
'      <p> ' + 
'        One can assert an agent record or alternatively, one can infer an agent ' + 
'        record by its association with an activity. ' + 
'      </p> ' + 
'      <div class="inference" id="association-agent"> ' + 
'        <span class="conditional">If</span> the records <span class="name">entity(e,attrs)</span> ' + 
'        and <span class="name">wasAssociatedWith(a,e)</span> hold for some ' + 
'        identifiers <span class="name">a</span>, <span class="name">e</span>, ' + 
'        and attribute-values <span class="name">attrs</span>, then the record ' + 
'        <span class="name">agent(e,attrs)</span> also holds. ' + 
'      </div> ' + 
'    </div><div class="inference" id="association-agent"> ' + 
'        <span class="conditional">If</span> the records <span class="name">entity(e,attrs)</span> ' + 
'        and <span class="name">wasAssociatedWith(a,e)</span> hold for some ' + 
'        identifiers <span class="name">a</span>, <span class="name">e</span>, ' + 
'        and attribute-values <span class="name">attrs</span>, then the record ' + 
'        <span class="name">agent(e,attrs)</span> also holds. ' + 
'      </div><div class="interpretation-forward"> ' + 
'      For the interpretation of a generation, see <a href="#generation-within-activity">generation-within-activity</a>. ' + 
'    </div><div class="structural-forward"> ' + 
'      See <a href="#generation-uniqueness">generation-uniqueness</a> for a ' + 
'      structural constraint on generations. ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of a usage, see <a href="#generation-precedes-usage">generation-precedes-usage</a> ' + 
'      and <a href="#usage-within-activity">usage-within-activity</a>. ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of an activity association, see <a href="#wasAssociatedWith-ordering">wasAssociatedWith-ordering</a>. ' + 
'    </div><div class="issue"> ' + 
'      The activity association record does not allow for a plan to be asserted ' + 
'      without an agent. This seems over-restrictive. Discussed in the context of ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/203">ISSUE-203</a>. ' + 
'    </div><div class="issue"> ' + 
'      Agents should not be inferred. WasAssociatedWith should also work with ' + 
'      entities. This is <a href="http://www.w3.org/2011/prov/track/issues/206">ISSUE-206</a>. ' + 
'    </div><div class="issue"> ' + 
'      Should we define start/end records as representation of activity start/end ' + 
'      events. Should time be associated with these events rather than with ' + 
'      activities. This will be similar to what we do for entities. This is issue ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/207">ISSUE-207</a>. ' + 
'    </div><div class="inference" id="derivation-implications"> ' + 
'      Given two entities denoted by <span class="name">e1</span> and <span class="name">e2</span>, <span class="conditional">if</span> the assertion ' + 
'      <span class="name">wasDerivedFrom(e2, e1, a, g2, u1, attrs)</span> holds ' + 
'      for some generation identified by <span class="name">g2</span>, and usage ' + 
'      identified by <span class="name">u1</span>, then <span class="name">wasDerivedFrom(e2,e1,[prov:steps="single"] ' + 
'      cup; attrs)</span> also holds.<br /> Given two entities denoted by <span class="name">e1</span> and <span class="name">e2</span>, <span class="conditional">if</span> the assertion <span class="name">wasDerivedFrom(e2, ' + 
'      e1, [prov:steps="single"] cup; attrs)</span> holds, then <span class="name">wasDerivedFrom(e2,e1,attrs)</span> also holds.<br /> ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of a derivation, see <a href="#derivation-usage-generation-ordering">derivation-usage-generation-ordering</a> ' + 
'      and <a href="#derivation-generation-generation-ordering">derivation-generation-generation-ordering</a> ' + 
'    </div><div class="inference" id="activity-introduction"> ' + 
'      <span class="conditional">If</span> <span class="name">wasDerivedFrom(e2,e1)</span> ' + 
'      holds, <span class="conditional">then</span> there exist an activity, with ' + 
'      identifier <span class="name">a</span>, a usage identified by <span class="name">u</span>, and a generation identified by <span class="name">g</span> ' + 
'      such that: ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(a,aAttrs) ' + 
'wasGeneratedBy(g,e2,a,gAttrs) ' + 
'used(u,a,e1,uAttrs) ' + 
'</pre> ' + 
'      for sets of attribute-value pairs <span class="name">gAttrs</span>, <span class="name">uAttrs</span>, and <span class="name">aAttrs</span>. ' + 
'    </div><div class="inference" id="derivation-time-elimination"> ' + 
'      <span class="conditional">If</span> <span class="name">wasDerivedFrom(e2,e1,t,attrs)</span> ' + 
'      holds, <span class="conditional">then</span> the following expressions ' + 
'      also hold: <span class="name">wasDerivedFrom(e2,e1,attrs)</span> and <span class="name">wasGeneratedBy(e2,t)</span>. ' + 
'    </div><div class="structural-forward"> ' + 
'      See <a href="#derivation-use">derivation-use</a> for a structural ' + 
'      constraint on derivations. ' + 
'    </div><div class="issue"> ' + 
'      Several points were raised about the attribute steps. Its name, its ' + 
'      default value <a href="http://www.w3.org/2011/prov/track/issues/180">ISSUE-180</a>. ' + 
'      <a href="http://www.w3.org/2011/prov/track/issues/179">ISSUE-179</a>. ' + 
'    </div><div class="issue"> ' + 
'      Emphasize the notion of \'affected by\' <a href="http://www.w3.org/2011/prov/track/issues/133">ISSUE-133</a>. ' + 
'    </div><div class="issue"> ' + 
'      Simplify derivation <a href="http://www.w3.org/2011/prov/track/issues/249">ISSUE-249</a>. ' + 
'    </div><div class="note"> ' + 
'      In order to further convey the intended meaning, the following properties ' + 
'      are associated to these two relations. ' + 
'      <ul> ' + 
'        <li> ' + 
'          <span class="name">specializationOf(e2,e1)</span> is <strong>transitive</strong>: ' + 
'          <span class="name">specializationOf(e3,e2)</span> and <span class="name">specializationOf(e2,e1)</span> implies <span class="name">specializationOf(e3,e1)</span>. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">specializationOf(e2,e1)</span> is <strong>anti-symmetric</strong>: ' + 
'          <span class="name">specializationOf(e2,e1)</span> implies that <span class="name">specializationOf(e1,e2)</span> does not hold. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">alternateOf(e2,e1)</span> is <strong>symmetric</strong>: ' + 
'          <span class="name">alternateOf(e2,e1)</span> implies <span class="name">alternateOf(e1,e2)</span>. ' + 
'        </li> ' + 
'      </ul> ' + 
'      There are proposals to make alternateOf a transitive property. This is ' + 
'      still under discussion and the default is for alternateOf <strong>not</strong> ' + 
'      to be transitive, and this is what the current text reflects. ' + 
'    </div><div class="issue"> ' + 
'      A discussion on alternative definition of these relations has not reached ' + 
'      a satisfactory conclusion yet. This is <a href="http://www.w3.org/2011/prov/track/issues/29">ISSUE-29</a>. Also <a href="http://www.w3.org/2011/prov/track/issues/96">ISSUE-96</a>. ' + 
'    </div><div class="inference" id="traceability-inference"> ' + 
'      Given two identifiers <span class="name">e2</span> and <span class="name">e1</span> ' + 
'      for entities, the following statements hold: ' + 
'      <ol> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">wasDerivedFrom(e2,e1,a,g2,u1)</span> ' + 
'          holds, for some <span class="name">a</span>, <span class="name">g2</span>, ' + 
'          <span class="name">u1</span>, <span class="conditional">then</span> ' + 
'          <span class="name">tracedTo(e2,e1)</span> also holds. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">wasDerivedFrom(e2,e1)</span> ' + 
'          holds, <span class="conditional">then</span> <span class="name">tracedTo(e2,e1)</span> ' + 
'          also holds. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">wasGeneratedBy(e2,a,gAttr) ' + 
'          and wasAssociatedWith(a,e1)</span> hold, for some <span class="name">a</span> ' + 
'          and <span class="name">gAttr</span>, <span class="conditional">then</span> ' + 
'          <span class="name">tracedTo(e2,e1)</span> also holds. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">wasGeneratedBy(e2,a,gAttr)</span>, ' + 
'          <span class="name">wasAssociatedWith(a,e)</span> and <span class="name">actedOnBehalfOf(e,e1)</span> ' + 
'          hold, for some <span class="name">a</span>, <span class="name">e</span>, ' + 
'          and <span class="name">gAttr</span>, <span class="conditional">then</span> ' + 
'          <span class="name">tracedTo(e2,e1)</span> also holds. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">wasGeneratedBy(e2,a,gAttr) ' + 
'          and wasStartedBy(a,e1,sAttr)</span> hold, for some <span class="name">a</span>, ' + 
'          <span class="name">e</span>, and <span class="name">gAttr</span>, and ' + 
'          <span class="name">sAttr</span>, <span class="conditional">then</span> ' + 
'          <span class="name">tracedTo(e2,e1)</span> also holds. ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="conditional">If</span> <span class="name">tracedTo(e2,e)</span> ' + 
'          and <span class="name">tracedTo(e,e1)</span> hold for some <span class="name">e</span>, <span class="conditional">then</span> <span class="name">tracedTo(e2,e1)</span> also holds. ' + 
'        </li> ' + 
'      </ol> ' + 
'    </div><div class="constraint" id="traceability-assertion"> ' + 
'      <span class="conditional">If</span> <span class="name">tracedTo(r2,r1,attrs)</span> ' + 
'      holds for two identifiers <span class="name">r2</span> and <span class="name">r1</span> identifying entities, and attribute-value pairs ' + 
'      <span class="name">attrs</span>, <span class="conditional">then</span> ' + 
'      there exist <span class="name">e<sup>0</sup></span>, <span class="name">e<sup>1</sup></span>, ' + 
'      ..., <span class="name">e<sup>n</sup></span> for <span class="name">nge;1</span>, ' + 
'      with <span class="name">e<sup>0</sup></span>=<span class="name">r2</span> ' + 
'      and <span class="name">e<sup>n</sup></span>=<span class="name">r1</span>, ' + 
'      and for any i such that <span class="name">0le;ile;n-1</span>, at least ' + 
'      of the following statements holds: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <span class="name">wasDerivedFrom(e<sup>i</sup>,e<sup>i+1</sup>,a,g2,u1)</span> ' + 
'          holds, for some <span class="name">a</span>, <span class="name">g2</span>, ' + 
'          <span class="name">u1</span>, or ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">wasDerivedFrom(e<sup>i</sup>,e<sup>i+1</sup>)</span> ' + 
'          holds, or ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">wasBasedOn(e<sup>i</sup>,e<sup>i+1</sup>)</span> ' + 
'          holds, or ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr) and ' + 
'          wasAssociatedWith(a,e<sup>i+1</sup>)</span> hold, for some <span class="name">a</span> and <span class="name">gAttr</span>, or ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr)</span>, <span class="name">wasAssociatedWith(a,e)</span> and <span class="name">actedOnBehalfOf(e,e<sup>i+1</sup>)</span> ' + 
'          hold, for some <span class="name">a</span>, <span class="name">e</span> ' + 
'          and <span class="name">gAttr</span>, or ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr) and ' + 
'          wasStartedBy(a,e<sup>i+1</sup>,sAttr)</span> hold, for some <span class="name">a</span>, <span class="name">e</span>, and <span class="name">gAttr</span>, and <span class="name">sAttr</span>. ' + 
'        </li> ' + 
'      </ul> ' + 
'    </div><div class="constraint" id="wasInformedBy-Definition"> ' + 
'      Given two activities identified by <span class="name">a1</span> and <span class="name">a2</span>, <span class="name">wasInformedBy(a2,a1)</span> ' + 
'      holds, <span class="conditional">if and only if</span> there is an entity ' + 
'      with some identifier <span class="name">e</span> and some sets of ' + 
'      attribute-value pairs <span class="name">attrs1</span> and <span class="name">attrs2</span>, such that <span class="name">wasGeneratedBy(e,a1,attrs1)</span> ' + 
'      and <span class="name">used(a2,e,attrs2)</span> hold. ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of an information flow ordering, see <a href="#wasInformedBy-ordering">wasInformedBy-ordering</a>. ' + 
'    </div><div class="constraint" id="wasStartedBy"> ' + 
'      Given two activities with identifiers <span class="name">a1</span> and ' + 
'      <span class="name">a2</span>, <span class="name">wasStartedBy(a2,a1)</span> ' + 
'      holds <span class="conditional">if and only if</span> there exist an ' + 
'      entity with some identifier <span class="name">e</span> and some ' + 
'      attributes <span class="name">gAttr</span> and <span class="name">sAttr</span>, ' + 
'      such that <span class="name">wasGeneratedBy(e,a1,gAttr)</span> and <span class="name">wasStartedBy(a2,e,sAttr)</span> hold. ' + 
'    </div><div class="interpretation-forward"> ' + 
'      For the interpretation of a control flow ordering, see <a href="#wasStartedBy-ordering">wasStartedBy-ordering</a>. ' + 
'    </div><div class="inference" id="wasRevision"> ' + 
'      Given two identifiers <span class="name">old</span> and <span class="name">new</span> ' + 
'      identifying two entities, and an identifier <span class="name">ag</span> ' + 
'      identifying an agent, <span class="conditional">if</span> <span class="name">wasRevisionOf(new,old,ag)</span> holds, <span class="conditional">then</span> there exists an entity with some ' + 
'      identifier <span class="name">e</span> and some attribute-values <span class="name">eAttrs</span>, <span class="name">dAttrs</span>, such that ' + 
'      the following hold: ' + 
'      <ul> ' + 
'        <li> ' + 
'          <span class="name">wasDerivedFrom(new,old,dAttrs)</span>; ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">entity(e,eAttrs)</span>; ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">specializationOf(new,e)</span>; ' + 
'        </li> ' + 
'        <li> ' + 
'          <span class="name">specializationOf(old,e)</span>. ' + 
'        </li> ' + 
'      </ul> ' + 
'      The derivation may be imprecise-1 or imprecise-n. ' + 
'    </div><div class="inference" id="attribution-implication"> ' + 
'      <span class="conditional">If</span> <span class="name">wasAttributedTo(e,ag)</span> ' + 
'      holds for some identifiers <span class="name">e</span> and <span class="name">ag</span>, <span class="conditional">then</span>, there ' + 
'      exists an activity with some identifier <span class="name">a</span> such ' + 
'      that the following statements hold: ' + 
'<pre xml:space="preserve"> ' + 
'activity(a,t1,t2,attr1) ' + 
'wasGenerateBy(e,a) ' + 
'wasAssociatedWith(a,ag,attr2) ' + 
'</pre> ' + 
'      for some sets of attribute-value pairs <span class="name">attr1</span> and ' + 
'      <span class="name">attr2</span>, time <span class="name">t1</span>, and ' + 
'      <span class="name">t2</span>. ' + 
'    </div><div class="inference" id="quotation-implication"> ' + 
'      <span class="conditional">If</span> <span class="name">wasQuotedFrom(e2,e1,ag2,ag1,attrs)</span> ' + 
'      holds for some identifiers <span class="name">e2</span>, <span class="name">e1</span>, ' + 
'      <span class="name">ag2</span>, <span class="name">ag1</span>, <span class="conditional">then</span> the following hold: ' + 
'<pre xml:space="preserve"> ' + 
'wasDerivedFrom(e2,e1) ' + 
'wasAttributedTo(e2,ag2) ' + 
'wasAttributedTo(e1,ag1) ' + 
'</pre> ' + 
'    </div><div class="issue"> ' + 
'      Drop this relation <a href="http://www.w3.org/2011/prov/track/issues/220">ISSUE-220</a>. ' + 
'    </div><div class="anexample" id="example-two-entities-one-id"> ' + 
'      <p> ' + 
'        Let us consider two descriptions of a same entity, which we have taken ' + 
'        from two different contexts (see example). A working draft published by ' + 
'        the <span class="name">w3:Consortium</span>: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="pr:RecsWD" %% xsd:QName ]) ' + 
'</pre> ' + 
'      The second version of a document edited by some authors: ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="document", ex:version="2" ]) ' + 
'</pre> ' + 
'      <p> ' + 
'        Both descriptions are about the same entity identified by <span class="name">tr:WD-prov-dm-20111215</span>, but they contain different ' + 
'        attributes, reflecting the context in which they occur. ' + 
'      </p> ' + 
'    </div><div class="constraint" id="unique-description-in-account"> ' + 
'      <p> ' + 
'        Given an entity identifier <span class="name">e</span>, there is at most ' + 
'        one description <span class="name">entity(e,av)</span> occurring in a ' + 
'        given account, where <span class="name">av</span> is some set of ' + 
'        attribute-values. Other descriptions of the same entity can exist in ' + 
'        different accounts. ' + 
'      </p> ' + 
'      <p> ' + 
'        This constraint similarly applies to all other types of identifiable ' + 
'        entities and relations. ' + 
'      </p> ' + 
'    </div><div class="structural-forward"> ' + 
'      See Section <a href="#structural-constraints">structural-constraints</a> ' + 
'      for a structural constraint on accounts ' + 
'    </div><div class="anexample" id="merge-with-rename"> ' + 
'      <p> ' + 
'        We now reconsider the same two descriptions of a same entity, but we ' + 
'        change the identifier for one of them: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'entity(tr:WD-prov-dm-20111215, [ prov:type="pr:RecsWD" %% xsd:QName ]) ' + 
'entity(ex:alternate-20111215, [ prov:type="document", ex:version="2" ]) ' + 
'alternateOf(tr:WD-prov-dm-20111215,ex:alternate-20111215) ' + 
'alternateOf(ex:alternate-20111215,tr:WD-prov-dm-20111215) ' + 
'</pre> ' + 
'    </div><div class="interpretation" id="start-precedes-end"> ' + 
'      The following ordering constraint holds for any activity: the <a title="activity start event">start event</a> <a>precedes</a> the <a title="activity end event">end event</a>. ' + 
'    </div><div class="interpretation" id="generation-precedes-usage"> ' + 
'      For any entity, the following ordering constraint holds: the <a title="entity generation event">generation</a> of an entity always <a>precedes</a> ' + 
'      any of its <a title="entity usage event">usages</a>. ' + 
'    </div><div class="interpretation" id="usage-within-activity"> ' + 
'      Given an activity with identifier <span class="name">a</span>, an entity ' + 
'      with identifier <span class="name">e</span>, a set of attribute-value ' + 
'      pairs <span class="name">attrs</span>, and optional time <span class="name">t</span>, ' + 
'      <span class="conditional">if</span> assertion <span class="name">used(a,e,attrs)</span> ' + 
'      or <span class="name">used(a,e,attrs,t)</span> holds, <span class="conditional">then</span> the following ordering constraint holds: ' + 
'      the <a title="entity usage event">usage</a> of the entity denoted by <span class="name">e</span> <a>precedes</a> the <a title="activity end event">end</a> ' + 
'      of activity denoted by <span class="name">a</span> and <a>follows</a> its ' + 
'      <a title="activity start event">start</a>. ' + 
'    </div><div class="interpretation" id="generation-within-activity"> ' + 
'      Given an activity with identifier <span class="name">a</span>, an entity ' + 
'      with identifier <span class="name">e</span>, a set of attribute-value ' + 
'      pairs <span class="name">attrs</span>, and optional time <span class="name">t</span>, ' + 
'      <span class="conditional">if</span> <span class="name">wasGeneratedBy(e,a,attrs)</span> ' + 
'      or <span class="name">wasGeneratedBy(e,a,attrs,t)</span> holds, <span class="conditional">then</span> the following ordering constraint also ' + 
'      holds: the <a title="entity generation event">generation</a> of the entity ' + 
'      denoted by <span class="name">e</span> <a>precedes</a> the <a title="activity end event">end</a> of activity <span class="name">a</span> ' + 
'      and <a>follows</a> the <a title="activity start event">start</a> of <span class="name">a</span>. ' + 
'    </div><div class="interpretation" id="derivation-usage-generation-ordering"> ' + 
'      Given an activity with identifier <span class="name">a</span>, entities ' + 
'      with identifier <span class="name">e1</span> and <span class="name">e2</span>, ' + 
'      a generation identified by <span class="name">g2</span>, and a usage ' + 
'      identified by <span class="name">u1</span>, <span class="conditional">if</span> ' + 
'      <span class="name">wasDerivedFrom(e2,e1,a,g2,u1,attrs)</span> or <span class="name">wasDerivedFrom(e2,e1,[prov:steps="single"] cup; attrs)</span> ' + 
'      holds, <span class="conditional">then</span> the following ordering ' + 
'      constraint holds: the <a title="entity usage event">usage</a> of entity ' + 
'      denoted by <span class="name">e1</span> <a>precedes</a> the <a title="entity generation event">generation</a> of the entity denoted by ' + 
'      <span class="name">e2</span>. ' + 
'    </div><div class="interpretation" id="derivation-generation-generation-ordering"> ' + 
'      Given two entities denoted by <span class="name">e1</span> and <span class="name">e2</span>, <span class="conditional">if</span> <span class="name">wasDerivedFrom(e2,e1,[prov:steps="any"] cup; attrs)</span> ' + 
'      holds, <span class="conditional">then</span> the following ordering ' + 
'      constraint holds: the <a title="entity generation event">generation event</a> ' + 
'      of the entity denoted by <span class="name">e1</span> <a>precedes</a> the ' + 
'      <a title="entity generation event">generation event</a> of the entity ' + 
'      denoted by <span class="name">e2</span>. ' + 
'    </div><div class="interpretation" id="wasInformedBy-ordering"> ' + 
'      Given two activities denoted by <span class="name">a1</span> and <span class="name">a2</span>, <span class="conditional">if</span> <span class="name">wasInformedBy(a2,a1)</span> holds, <span class="conditional">then</span> ' + 
'      the following ordering constraint holds: the <a title="activity start event">start event</a> of the activity denoted by ' + 
'      <span class="name">a1</span> <a>precedes</a> the <a title="activity end event">end event</a> of the activity denoted by <span class="name">a2</span>. ' + 
'    </div><div class="interpretation" id="wasStartedBy-ordering"> ' + 
'      Given two activities denoted by <span class="name">a1</span> and <span class="name">a2</span>, <span class="conditional">if</span> <span class="name">wasStartedBy(a2,a1)</span> holds, <span class="conditional">then</span> ' + 
'      the following ordering constraint holds: the <a title="activity start event">start</a> event of the activity denoted by ' + 
'      <span class="name">a1</span> <a>precedes</a> the <a title="activity start event">start event</a> of the activity denoted by ' + 
'      <span class="name">a2</span>. ' + 
'    </div><div class="issue"> ' + 
'      In the following, we assume that we can talk about the end of an entity ' + 
'      (or agent) For this, we use the term \'destruction\' This is <a href="http://www.w3.org/2011/prov/track/issues/204">ISSUE-204</a>. ' + 
'    </div><div class="interpretation" id="wasStartedByAgent-ordering"> ' + 
'      Given an activity denoted by <span class="name">a</span> and an agent ' + 
'      denoted by <span class="name">ag</span>, <span class="conditional">if</span> ' + 
'      <span class="name">wasStartedBy(a,ag)</span> holds, <span class="conditional">then</span> the following ordering constraints hold: ' + 
'      the <a title="activity start event">start</a> event of the activity ' + 
'      denoted by <span class="name">a</span> <a>follows</a> the <a title="entity generation event">generation event</a> for agent denoted by ' + 
'      <span class="name">ag</span>, and <a>precedes</a> the destruction event of ' + 
'      the same agent. ' + 
'    </div><div class="interpretation" id="wasAssociatedWith-ordering"> ' + 
'      Given an activity denoted by <span class="name">a</span> and an agent ' + 
'      denoted by <span class="name">ag</span>, <span class="conditional">if</span> ' + 
'      <span class="name">wasAssociatedWith(a,ag)</span> holds, <span class="conditional">then</span> the following ordering constraints hold: ' + 
'      the <a title="activity start event">start</a> event of the activity ' + 
'      denoted by <span class="name">a</span> precedes the destruction event of ' + 
'      the agent denoted by <span class="name">ag</span>, and the <a title="entity generation event">generation event</a> for agent denoted by ' + 
'      <span class="name">ag</span> <a>precedes</a> the activity <a title="activity end event">end</a> event. ' + 
'    </div><div class="issue"> ' + 
'      For completeness, we should define ordering constraint for ' + 
'      wasAssociatedWith and actedOnBehalfOf. For wasAssociatedWith(a,ag), it ' + 
'      feels that ag must have some overlap with a. For ' + 
'      actedOnBehalfOf(ag1,ag2,a), it seem that ag2 should have existed before ' + 
'      the overlap between ag1 and a. This is <a href="http://www.w3.org/2011/prov/track/issues/221">ISSUE-221</a>. ' + 
'    </div><div class="issue"> ' + 
'      It is suggested that a stronger name for wasAssociatedWith should be ' + 
'      adopted. This is <a href="http://www.w3.org/2011/prov/track/issues/182">ISSUE-182</a>. ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        In the following assertions, a workflow execution <span class="name">a0</span> ' + 
'        consists of two sub-workflow executions <span class="name">a1</span> and ' + 
'        <span class="name">a2</span>. Sub-workflow execution <span class="name">a2</span> ' + 
'        generates entity <span class="name">e</span>, so does <span class="name">a0</span>. ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'activity(a0,,,[prov:type="workflow execution"]) ' + 
'activity(a1,,,[prov:type="workflow execution"]) ' + 
'activity(a2,,,[prov:type="workflow execution"]) ' + 
'wasInformedBy(a2,a1) ' + 
' ' + 
'wasGeneratedBy(e,a0) ' + 
'wasGeneratedBy(e,a2) ' + 
'</pre> ' + 
'      <p> ' + 
'        So, we have two different <a title="generation">generations</a> for ' + 
'        entity <span class="name">e</span>. Such an example is permitted in ' + 
'        PROV-DM if the two activities denoted by <span class="name">a0</span> ' + 
'        and <span class="name">a2</span> are a single thing happening in the ' + 
'        world but described from different perspectives. ' + 
'      </p> ' + 
'    </div><div class="anexample"> ' + 
'      <p> ' + 
'        The same example is now revisited, with the following assertions that ' + 
'        are structurally well-formed. Two accounts are introduced, and there is ' + 
'        a single generation for entity <span class="name">e</span> per account. ' + 
'      </p> ' + 
'      <p> ' + 
'        In a first account, entitled "summary", we find: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'        activity(a0,t1,t2,[prov:type="workflow execution"]) ' + 
'        wasGeneratedBy(e,a0) ' + 
'</pre> ' + 
'      <p> ' + 
'        In a second account, entitled "detail", we find: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'        activity(a1,t1,t3,[prov:type="workflow execution"]) ' + 
'        activity(a2,t3,t2,[prov:type="workflow execution"]) ' + 
'        wasInformedBy(a2,a1) ' + 
'        wasGeneratedBy(e,a2) ' + 
'</pre> ' + 
'    </div><div class="constraint" id="generation-uniqueness"> ' + 
'      Given an entity denoted by <span class="name">e</span>, two activities ' + 
'      denoted by <span class="name">a1</span> and <span class="name">a2</span>, ' + 
'      and two sets of attribute-value pairs <span class="name">attrs1</span> and ' + 
'      <span class="name">attrs2</span>, <span class="conditional">if</span> ' + 
'      <span class="name">wasGeneratedBy(id1,e,a1,attrs1)</span> and <span class="name">wasGeneratedBy(id2,e,a2,attrs2)</span> exist in the scope of ' + 
'      a given account, <span class="conditional">then</span> <span class="name">id1</span>=<span class="name">id2</span>, <span class="name">a1</span>=<span class="name">a2</span> ' + 
'      and <span class="name">attrs1</span>=<span class="name">attrs2</span>. ' + 
'    </div><div class="inference" id="derivation-use"> ' + 
'      <p> ' + 
'        Given an activity with identifier <span class="name">a</span>, entities ' + 
'        denoted by <span class="name">e1</span> and <span class="name">e2</span>, ' + 
'        and a set of attribute-value pairs <span class="name">attrs2</span>, ' + 
'        <span class="conditional">if</span> <span class="name">wasDerivedFrom(e2,e1, ' + 
'        [prov:steps="single"])</span> and <span class="name">wasGeneratedBy(e2,a,attrs2)</span> ' + 
'        hold, <span class="conditional">then</span> <span class="name">used(a,e1,attrs1)</span> ' + 
'        also holds for some set of attribute-value pairs <span class="name">attrs1</span>. ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      Can the semantics characterize better what can be achieved with ' + 
'      structurally well-formed accounts? ' + 
'    </div><div class="note" id="note-related-to-issue-105"> ' + 
'      Satya discussed the example of a sculpture, whose hand and leg are ' + 
'      sculpted independently by two different sculptors. He suggested that the ' + 
'      sculpture is generated by two distinct activities. This section explains ' + 
'      that it is not the case. The example can be formulated as follows. ' + 
'      <p> ' + 
'        <a href="examples/sculpture.prov-asn">Sculpture example in ASN</a> ' + 
'      </p> ' + 
'      <p> ' + 
'        <a href="examples/sculpture.png">Sculpture example image</a> ' + 
'      </p> ' + 
'      <p> ' + 
'        We see that ex:s_3 (the sculpture in its final state) was derived from ' + 
'        ex:l_2 (containment) which was generated by ex:a2. However, ex:s_3 is ' + 
'        not directly generated by ex:a2. We may want to consider an abbreviation ' + 
'        for this: wasGeneratedBy*(ex:s_3,ex:a2). ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      Raw material taken from prov-dm3. Some further text required. ' + 
'    </div><div class="constraint" id="collection-parallel-insertions"> ' + 
'      <p> ' + 
'        One can have multiple assertions regarding the state of a collection ' + 
'        following a <em>set</em> of insertions, for example: ' + 
'      </p> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'CollectionAfterInsertion(c2, c1, k1, v1) ' + 
'CollectionAfterInsertion(c2, c1, k2, v2) ' + 
'... ' + 
'</pre> ' + 
'      <p> ' + 
'        This is interpreted as <em>" <span class="name">c2</span> is the state ' + 
'        that results from inserting <span class="name">(k1, v1)</span>, <span class="name">(k2, v2)</span> etc. into <span class="name">c1</span>"</em> ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      Shouldn\'t we have the same for deletion, and combination of insertion and ' + 
'      deletion? ' + 
'    </div><div class="constraint" id="collection-branching-derivations"> ' + 
'      It is possible to have multiple derivations from a single root collection, ' + 
'      as shown in the following example. ' + 
'      <div class="anexample"> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  entity(c, [prov:type="EmptyCollection"])    // e is an empty collection ' + 
'  entity(v1) ' + 
'  entity(v2) ' + 
'  entity(v3) ' + 
'  entity(c1, [prov:type="Collection"]) ' + 
'  entity(c2, [prov:type="Collection"]) ' + 
'  entity(c3, [prov:type="Collection"]) ' + 
'   ' + 
'  CollectionAfterInsertion(c1, c, k1, v1)       // c1 = { (k1,v1) } ' + 
'  CollectionAfterInsertion(c2, c, k2, v2)       // c2 = { (k2 v2) } ' + 
'  CollectionAfterInsertion(c3, c1, k3,v3)       // c3 = { (k1,v1),  (k3,v3) } ' + 
'</pre> ' + 
'      </div> ' + 
'    </div><div class="anexample"> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  entity(c, [prov:type="EmptyCollection"])    // e is an empty collection ' + 
'  entity(v1) ' + 
'  entity(v2) ' + 
'  entity(v3) ' + 
'  entity(c1, [prov:type="Collection"]) ' + 
'  entity(c2, [prov:type="Collection"]) ' + 
'  entity(c3, [prov:type="Collection"]) ' + 
'   ' + 
'  CollectionAfterInsertion(c1, c, k1, v1)       // c1 = { (k1,v1) } ' + 
'  CollectionAfterInsertion(c2, c, k2, v2)       // c2 = { (k2 v2) } ' + 
'  CollectionAfterInsertion(c3, c1, k3,v3)       // c3 = { (k1,v1),  (k3,v3) } ' + 
'</pre> ' + 
'      </div><div class="constraint" id="collection-unique-ancestor"> ' + 
'      Given the pair of assertions: ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'CollectionAfterInsertion(c, c1, k1, v1) ' + 
'CollectionAfterInsertion(c, c2, k2, v2) ' + 
'</pre> ' + 
'      it follows that <span class="name">c1==c2</span>. ' + 
'    </div><div class="note"> ' + 
'      Original text stated it follows that <span class="name">c1==c2, k1==k2, ' + 
'      v1==v2</span>, because one cannot have two different derivations for the ' + 
'      same final collection state. This is incompatible with parallel insertion ' + 
'      constraint. ' + 
'    </div><div class="note"> ' + 
'      Shouldn\'t we have the same for deletion, and combination of insertion and ' + 
'      deletion? ' + 
'    </div><div class="constraint" id="collection-unique-value-for-key"> ' + 
'      Given the following set of insertions: ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'CollectionAfterInsertion(c1, c, k, v1) ' + 
'CollectionAfterInsertion(c1, c, k, v2) ' + 
'</pre> ' + 
'      it follows that <span class="name">v1==v2</span>. ' + 
'    </div><div class="anexample"> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  entity(c, [prov:type="collection"])    // e is a collection, possibly not empty ' + 
'  entity(v1) ' + 
'  entity(v2, [prov:type="collection"])    // v2 is a collection ' + 
' ' + 
'  CollectionAfterInsertion(c1, c, k1, v1)       // c1 <em>includes</em> { (k1,v1) } but may contain additional unknown pairs ' + 
'  CollectionAfterInsertion(c2, c1, k2, v2)      // c2 includes { (k1,v1), (k2 v2) } where v2 is a collection with unknown state ' + 
'</pre> ' + 
'    </div><div class="anexample"> ' + 
'<pre class="codeexample" xml:space="preserve"> ' + 
'  entity(c, [prov:type="emptyCollection"])    // e is an empty collection ' + 
'  entity(v1) ' + 
'  entity(v2) ' + 
' ' + 
'  CollectionAfterInsertion(c1, c, k1, v1)       // c1 = { (k1,v1) } ' + 
'  wasDerivedFrom(c2, c1)                        // the asserted knows that c2 is somehow derived from c1, but cannot assert the precise sequence of updates ' + 
'    CollectionAfterInsertion(c3, c2, k2, v2)        ' + 
'</pre> ' + 
'      <p> ' + 
'        Here <span class="name">c3</span> includes <span class="name">{ (k2 v2) ' + 
'        }</span> but the earlier "gap" leaves uncertainty regarding <span class="name">(k1,v1)</span> (it may have been removed) or any other pair ' + 
'        that may have been added as part of the derivation activities. ' + 
'      </p> ' + 
'    </div><div class="note"> ' + 
'      Purely tentative ' + 
'    </div><div class="note"> ' + 
'          What is the meaning here? Is it any different? Are stating anything ' + 
'          about newer version of tr:prov-dm that occur after ' + 
'          2011-12-15T12:00:00? ' + 
'        </div><div class="note"> ' + 
'          What is the meaning here? that only the version that was created by ' + 
'          this event is attributed to ex:Simon, but not previous ones. This ' + 
'          means that it is not specfied whether he was an author in anterior ' + 
'          versions. ' + 
'        </div><div class="note"> ' + 
'          Speculative, since we have not defined the destruction event (yet?. ' + 
'          What is the meaning here? that only the versions that existed during ' + 
'          this characterization interval were attributed to ex:Simon. ' + 
'        </div><span class="glossary" id="glossary-account"> An <dfn>account</dfn> is a ' + 
'      named bundle of provenance descriptions. </span><span class="glossary" id="glossary-entity"> <dfn id="concept-accountEntity">AccountEntity</dfn> is the category of entities ' + 
'      that are accounts, i.e. named bundles of provenance descriptions. </span><span class="conditional">If</span><span class="name">entity(e,attrs)</span><span class="name">wasAssociatedWith(a,e)</span><span class="name">a</span><span class="name">e</span><span class="name">attrs</span><span class="name">agent(e,attrs)</span><span class="name">e1</span><span class="name">e2</span><span class="conditional">if</span><span class="name">wasDerivedFrom(e2, e1, a, g2, u1, attrs)</span><span class="name">g2</span><span class="name">u1</span><span class="name">wasDerivedFrom(e2,e1,[prov:steps="single"] ' + 
'      cup; attrs)</span><span class="name">e1</span><span class="name">e2</span><span class="conditional">if</span><span class="name">wasDerivedFrom(e2, ' + 
'      e1, [prov:steps="single"] cup; attrs)</span><span class="name">wasDerivedFrom(e2,e1,attrs)</span><span class="conditional">If</span><span class="name">wasDerivedFrom(e2,e1)</span><span class="conditional">then</span><span class="name">a</span><span class="name">u</span><span class="name">g</span><span class="name">gAttrs</span><span class="name">uAttrs</span><span class="name">aAttrs</span><span class="name">wasGeneratedBy(g, ' + 
'      e2, a, attrs2)</span><span class="name">used(u, a, e1, ' + 
'      attrs1)</span><span class="name">e1</span><span class="name">e2</span><span class="name">attrs1</span><span class="name">attrs2</span><span class="name">a</span><span class="name">wasDerivedFrom(e2, ' + 
'      e1, a, g, u)</span><span class="name">wasDerivedFrom(e2,e1)</span><span class="name">e2</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="conditional">If</span><span class="name">wasDerivedFrom(e2,e1,t,attrs)</span><span class="conditional">then</span><span class="name">wasDerivedFrom(e2,e1,attrs)</span><span class="name">wasGeneratedBy(e2,t)</span><span class="name">specializationOf(e2,e1)</span><span class="name">specializationOf(e3,e2)</span><span class="name">specializationOf(e2,e1)</span><span class="name">specializationOf(e3,e1)</span><span class="name">specializationOf(e2,e1)</span><span class="name">specializationOf(e2,e1)</span><span class="name">specializationOf(e1,e2)</span><span class="name">alternateOf(e2,e1)</span><span class="name">alternateOf(e2,e1)</span><span class="name">alternateOf(e1,e2)</span><span class="name">e2</span><span class="name">e1</span><span class="conditional">If</span><span class="name">wasDerivedFrom(e2,e1,a,g2,u1)</span><span class="name">a</span><span class="name">g2</span><span class="name">u1</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">wasDerivedFrom(e2,e1)</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">wasGeneratedBy(e2,a,gAttr) ' + 
'          and wasAssociatedWith(a,e1)</span><span class="name">a</span><span class="name">gAttr</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">wasGeneratedBy(e2,a,gAttr)</span><span class="name">wasAssociatedWith(a,e)</span><span class="name">actedOnBehalfOf(e,e1)</span><span class="name">a</span><span class="name">e</span><span class="name">gAttr</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">wasGeneratedBy(e2,a,gAttr) ' + 
'          and wasStartedBy(a,e1,sAttr)</span><span class="name">a</span><span class="name">e</span><span class="name">gAttr</span><span class="name">sAttr</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">tracedTo(e2,e)</span><span class="name">tracedTo(e,e1)</span><span class="name">e</span><span class="conditional">then</span><span class="name">tracedTo(e2,e1)</span><span class="conditional">If</span><span class="name">tracedTo(r2,r1,attrs)</span><span class="name">r2</span><span class="name">r1</span><span class="name">attrs</span><span class="conditional">then</span><span class="name">e<sup>0</sup></span><span class="name">e<sup>1</sup></span><span class="name">e<sup>n</sup></span><span class="name">nge;1</span><span class="name">e<sup>0</sup></span><span class="name">r2</span><span class="name">e<sup>n</sup></span><span class="name">r1</span><span class="name">0le;ile;n-1</span><span class="name">wasDerivedFrom(e<sup>i</sup>,e<sup>i+1</sup>,a,g2,u1)</span><span class="name">a</span><span class="name">g2</span><span class="name">u1</span><span class="name">wasDerivedFrom(e<sup>i</sup>,e<sup>i+1</sup>)</span><span class="name">wasBasedOn(e<sup>i</sup>,e<sup>i+1</sup>)</span><span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr) and ' + 
'          wasAssociatedWith(a,e<sup>i+1</sup>)</span><span class="name">a</span><span class="name">gAttr</span><span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr)</span><span class="name">wasAssociatedWith(a,e)</span><span class="name">actedOnBehalfOf(e,e<sup>i+1</sup>)</span><span class="name">a</span><span class="name">e</span><span class="name">gAttr</span><span class="name">wasGeneratedBy(e<sup>i</sup>,a,gAttr) and ' + 
'          wasStartedBy(a,e<sup>i+1</sup>,sAttr)</span><span class="name">a</span><span class="name">e</span><span class="name">gAttr</span><span class="name">sAttr</span><span class="name">a1</span><span class="name">a2</span><span class="name">wasInformedBy(a2,a1)</span><span class="conditional">if and only if</span><span class="name">e</span><span class="name">attrs1</span><span class="name">attrs2</span><span class="name">wasGeneratedBy(e,a1,attrs1)</span><span class="name">used(a2,e,attrs2)</span><span class="name">wasInformedBy</span><span class="name">wasInformedBy(a3,a1)</span><span class="name">wasInformedBy(a2,a1)</span><span class="name">e1</span><span class="name">e1</span><span class="name">a1</span><span class="name">a2</span><span class="name">wasInformedBy(a3,a2)</span><span class="name">e2</span><span class="name">e2</span><span class="name">a2</span><span class="name">a3</span><span class="name">e1</span><span class="name">e2</span><span class="name">a3</span><span class="name">a1</span><span class="name">a3</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a1</span><span class="name">a2</span><span class="name">wasStartedBy(a2,a1)</span><span class="conditional">if and only if</span><span class="name">e</span><span class="name">gAttr</span><span class="name">sAttr</span><span class="name">wasGeneratedBy(e,a1,gAttr)</span><span class="name">wasStartedBy(a2,e,sAttr)</span><span class="name">wasStartedBy</span><span class="name">wasStartedBy</span><span class="name">wasStartedBy</span><span class="name">old</span><span class="name">new</span><span class="name">ag</span><span class="conditional">if</span><span class="name">wasRevisionOf(new,old,ag)</span><span class="conditional">then</span><span class="name">e</span><span class="name">eAttrs</span><span class="name">dAttrs</span><span class="name">wasDerivedFrom(new,old,dAttrs)</span><span class="name">entity(e,eAttrs)</span><span class="name">specializationOf(new,e)</span><span class="name">specializationOf(old,e)</span><span class="name">wasRevisionOf</span><span class="name">wasDerivedFrom</span><span class="name">e2</span><span class="name">e1</span><span class="name">wasDerivedFrom(e2,e1)</span><span class="conditional">If</span><span class="name">wasAttributedTo(e,ag)</span><span class="name">e</span><span class="name">ag</span><span class="conditional">then</span><span class="name">a</span><span class="name">attr1</span><span class="name">attr2</span><span class="name">t1</span><span class="name">t2</span><span class="conditional">If</span><span class="name">wasQuotedFrom(e2,e1,ag2,ag1,attrs)</span><span class="name">e2</span><span class="name">e1</span><span class="name">ag2</span><span class="name">ag1</span><span class="conditional">then</span><span class="name">w3:Consortium</span><span class="name">tr:WD-prov-dm-20111215</span><span class="name">e</span><span class="name">entity(e,av)</span><span class="name">av</span><span class="name">alternateOf</span><span class="name">a</span><span class="name">e</span><span class="name">attrs</span><span class="name">t</span><span class="conditional">if</span><span class="name">used(a,e,attrs)</span><span class="name">used(a,e,attrs,t)</span><span class="conditional">then</span><span class="name">e</span><span class="name">a</span><span class="name">a</span><span class="name">e</span><span class="name">attrs</span><span class="name">t</span><span class="conditional">if</span><span class="name">wasGeneratedBy(e,a,attrs)</span><span class="name">wasGeneratedBy(e,a,attrs,t)</span><span class="conditional">then</span><span class="name">e</span><span class="name">a</span><span class="name">a</span><span class="name">e2</span><span class="name">e1</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="name">e2</span><span class="name">a</span><span class="name">e1</span><span class="name">e2</span><span class="name">g2</span><span class="name">u1</span><span class="conditional">if</span><span class="name">wasDerivedFrom(e2,e1,a,g2,u1,attrs)</span><span class="name">wasDerivedFrom(e2,e1,[prov:steps="single"] cup; attrs)</span><span class="conditional">then</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="name">e1</span><span class="name">e2</span><span class="conditional">if</span><span class="name">wasDerivedFrom(e2,e1,[prov:steps="any"] cup; attrs)</span><span class="conditional">then</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="name">e2</span><span class="name">e1</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a2</span><span class="conditional">if</span><span class="name">wasInformedBy(a2,a1)</span><span class="conditional">then</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a2</span><span class="name">a1</span><span class="name">a2</span><span class="conditional">if</span><span class="name">wasStartedBy(a2,a1)</span><span class="conditional">then</span><span class="name">a1</span><span class="name">a2</span><span class="name">a</span><span class="name">ag</span><span class="conditional">if</span><span class="name">wasStartedBy(a,ag)</span><span class="conditional">then</span><span class="name">a</span><span class="name">ag</span><span class="name">a</span><span class="name">ag</span><span class="conditional">if</span><span class="name">wasAssociatedWith(a,ag)</span><span class="conditional">then</span><span class="name">a</span><span class="name">ag</span><span class="name">ag</span><span class="name">g1</span><span class="name">g2</span><span class="name">a0</span><span class="name">a1</span><span class="name">a2</span><span class="name">a2</span><span class="name">e</span><span class="name">a0</span><span class="name">e</span><span class="name">a0</span><span class="name">a2</span><span class="name">e</span><span class="name">e</span><span class="name">a1</span><span class="name">a2</span><span class="name">attrs1</span><span class="name">attrs2</span><span class="conditional">if</span><span class="name">wasGeneratedBy(id1,e,a1,attrs1)</span><span class="name">wasGeneratedBy(id2,e,a2,attrs2)</span><span class="conditional">then</span><span class="name">id1</span><span class="name">id2</span><span class="name">a1</span><span class="name">a2</span><span class="name">attrs1</span><span class="name">attrs2</span><span class="name">a</span><span class="name">e1</span><span class="name">e2</span><span class="name">attrs2</span><span class="conditional">if</span><span class="name">wasDerivedFrom(e2,e1, ' + 
'        [prov:steps="single"])</span><span class="name">wasGeneratedBy(e2,a,attrs2)</span><span class="conditional">then</span><span class="name">used(a,e1,attrs1)</span><span class="name">attrs1</span><span class="name">e2</span><span class="name">e1</span><span class="name">wasDerivedFrom(e2,e1)</span><span class="name">used(a,e1)</span><span class="name">wasGeneratedBy(e2,a,attrs2)</span><span class="name">e1</span><span class="name">e2</span><span class="name">c2</span><span class="name">(k1, v1)</span><span class="name">(k2, v2)</span><span class="name">c1</span><span class="name">c1==c2</span><span class="name">c1==c2, k1==k2, ' + 
'      v1==v2</span><span class="name">v1==v2</span><span class="name">c2</span><span class="name">c3</span><span class="name">{ (k2 v2) ' + 
'        }</span><span class="name">(k1,v1)</span><span class="name">tr:prov-dm</span><span class="name">tr:prov-dm</span><span class="name">tr:WD-prov-dm-20111215</span><span class="name">tr:WD-prov-dm-20111018</span><span class="name">w3:Consortium</span><span class="name">tr:prov-dm</span><span class="name">w3:Consortium</span><span class="name">ex:acc1</span><span class="name">ex:acc1</span><span class="name">tr:prov-dm</span><span class="name">tr:prov-dm</span></html> ' + 
' ' ;
