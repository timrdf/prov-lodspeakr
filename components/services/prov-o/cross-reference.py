#!/usr/bin/env python

# To install dependencies, see https://github.com/timrdf/DataFAQs/wiki/Errors

import sys
from rdflib import *

from surf import *
from surf.query import a, select

import rdflib
rdflib.plugin.register('sparql', rdflib.query.Processor, 'rdfextras.sparql.processor', 'Processor')
rdflib.plugin.register('sparql', rdflib.query.Result,    'rdfextras.sparql.query',     'SPARQLQueryResult')

import datetime
import uuid

from sets import Set

if len(sys.argv) != 4:
   print "usage: cross-reference.py http://some.owl someont.owl prefix"
   print
   print "  http://some.owl      - web URL of the OWL e.g. http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl"
   print "  some.owl             - local copy of the OWL e.g. ProvenanceOntology.owl"
   print "  prefix               - prefix to use e.g. 'prov'"
   sys.exit(1)

ont_url   = sys.argv[1] # http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl
ont_local = sys.argv[2] # ProvenanceOntology.owl
PREFIX    = sys.argv[3] # prov

EXAMPLE_BASE_URL   = 'http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf/'
EXAMPLE_BASE_LOCAL = 'includes/prov/examples/eg-24-prov-o-html-examples/rdf/create/rdf/'

ns.register(prov='http://www.w3.org/ns/prov#')
ns.register(dcat='http://www.w3.org/ns/dcat#')
ns.register(void='http://rdfs.org/ns/void#')

prefixes = dict(prov=str(ns.PROV), dcat=str(ns.DCAT), void=str(ns.VOID))

# as rdflib
graph = Graph()
graph.parse(ont_local) # from file

# as SuRF
store = Store(reader='rdflib', writer='rdflib', rdflib_store = 'IOMemory') 
session = Session(store)
store.load_triples(source=ont_url) # From URL
DatatypeProperties = session.get_class(ns.OWL["DatatypeProperty"])
ObjectProperties   = session.get_class(ns.OWL["ObjectProperty"])
Classes            = session.get_class(ns.OWL["Class"])
Thing              = session.get_class(ns.OWL["Thing"])

all_ordered = {}
all_ordered['classes'] = []
for owlClass in Classes.all():
   if owlClass.subject.startswith('http://www.w3.org/ns/prov#'):
      all_ordered['classes'].append(owlClass.subject)
all_ordered['classes'].sort()

all_ordered['properties'] = []
all_ordered['datatypeproperties'] = []
for prop in DatatypeProperties.all():
   if prop.subject.startswith('http://www.w3.org/ns/prov#'):
      all_ordered['properties'].append(prop.subject)
      all_ordered['datatypeproperties'].append(prop.subject)
all_ordered['datatypeproperties'].sort()

all_ordered['objectproperties'] = []
for prop in ObjectProperties.all():
   if prop.subject.startswith('http://www.w3.org/ns/prov#'):
      all_ordered['properties'].append(prop.subject)
      all_ordered['objectproperties'].append(prop.subject)
all_ordered['objectproperties'].sort()
all_ordered['properties'].sort()

qualifiedFormsQ = '''
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix prov: <http://www.w3.org/ns/prov#>

select distinct ?unqualified ?qualified ?involvement
where {
   graph <http://www.w3.org/ns/prov#> {

      ?unqualified prov:qualifiedForm []; prov:category "CATEGORY" .

      optional {
         ?unqualified prov:qualifiedForm ?qualified .
                                         ?qualified a owl:ObjectProperty
      }

      optional {
         ?unqualified prov:qualifiedForm ?involvement .
                                         ?involvement a owl:Class
      }
   }
} order by ?unqualified
'''

results = graph.query('select distinct ?cat where { [] prov:category ?cat } order by ?cat', initNs=prefixes)
categories = {}
for bindings in results:
   categories[bindings] = True # distinct operator is not being recognized. Need to reimplement here.
for category in categories.keys():
   print category

   glanceName = 'at-a-glance-'+category+'.html'
   crossName  = 'cross-reference-'+category+'.html'
   qualsName  = 'qualifed-forms-'+category+'.html'
   if not(os.path.exists(glanceName)) and not(os.path.exists(crossName)) and not(os.path.exists(qualsName)):
      print '  '+glanceName + ' ' + crossName
      glance = open(glanceName, 'w')
      cross  = open(crossName, 'w')
      quals  = open(qualsName, 'w')

      # Classes # # # # # # # # # # # # # # # # #
      glance.write('\n')
      glance.write('<div\n') # We want to include in multiple places: id="'+PREFIX+'-'+category+'-owl-classes-at-a-glance"\n')
      glance.write('     class="'+PREFIX+'-'+category+' owl-classes at-a-glance">\n')
      glance.write('  <ul class="hlist">\n')

      ordered = {}
      ordered['classes'] = []
      for owlClass in Classes.all():
         if owlClass.prov_category.first == category and owlClass.subject.startswith('http://www.w3.org/ns/prov#'):
            ordered['classes'].append(owlClass.subject)
      ordered['classes'].sort()

      # at-a-glance
      for uri in ordered['classes']:
         owlClass = session.get_resource(uri,Classes)
         qname = owlClass.subject.split('#')
         glance.write('    <li>\n')
         glance.write('      <a href="#'+qname[1]+'">'+PREFIX+':'+qname[1]+'</a>\n')
         glance.write('    </li>\n')
      glance.write('  </ul>\n')
      glance.write('</div>\n')


      # Properties # # # # # # # # # # # # # # # # #
      glance.write('\n')
      glance.write('<div\n') # We want to include in multiple places: id="'+PREFIX+'-'+category+'-owl-properties-at-a-glance"\n')
      glance.write('     class="'+PREFIX+'-'+category+' owl-properties at-a-glance">\n')
      glance.write('  <ul class="hlist">\n')

      propertyTypes = {}
      ordered['properties'] = []
      for property in DatatypeProperties.all():
         propertyTypes[property.subject] = "datatype-property"
         if property.prov_category.first == category:
            ordered['properties'].append(property.subject)
      for property in ObjectProperties.all():
         propertyTypes[property.subject] = "object-property"
         if property.prov_category.first == category:
            ordered['properties'].append(property.subject)
      ordered['properties'].sort()

      sup = {}
      sup['datatype-property'] = ' <sup class="type-dp" title="data property">dp</sup>'
      sup['object-property']   = ' <sup class="type-op" title="object property">op</sup>'

      # at-a-glance
      for uri in ordered['properties']:
         property = []
         if propertyTypes[uri] == 'datatype-property':
            property = session.get_resource(uri,DatatypeProperties)
         else:
            property = session.get_resource(uri,ObjectProperties)
         qname = property.subject.split('#')
         glance.write('    <li class="'+propertyTypes[uri]+'">\n')
         glance.write('      <a href="#'+qname[1]+'">'+PREFIX+':'+qname[1]+'</a>\n')
         glance.write('    </li>\n')
      glance.write('  </ul>\n')
      glance.write('</div>\n')


      # Classes # # # # # # # # # # # # # # # # #
      # cross-reference
      cross.write('<div\n') # We want to include it multiple times: id="'+PREFIX+'-'+category+'-owl-classes-crossreference"\n')
      cross.write('     class="'+PREFIX+'-'+category+' owl-classes crossreference"\n')
      cross.write('     xmlns:dcterms="http://purl.org/dc/terms/"\n')
      cross.write('     xmlns:prov="http://www.w3.org/ns/prov#">\n')
      for uri in ordered['classes']:
         owlClass = session.get_resource(uri,Classes)
         qname = owlClass.subject.split('#')
         cross.write('\n')
         cross.write('  <div id="'+qname[1]+'" class="entity">\n')
         cross.write('    <h3>\n')
         cross.write('      Class: <a href="#'+qname[1]+'"><span class="dotted" title="'+uri+'">'+PREFIX+':'+qname[1]+'</span></a>\n')
         cross.write('      <span class="backlink">\n')
         #cross.write('         back to <a href="#toc">ToC</a> or\n')
         cross.write('         back to <a href="#'+PREFIX+'-'+category+'-owl-terms-at-a-glance">'+category+' classes</a>\n')
         cross.write('      </span>\n')
         cross.write('    </h3>\n')

         # class
         cross.write('    <p><strong class="crossreference">IRI:</strong>'+uri+'</p>\n')

         # class prov:definition
         for definition in owlClass.prov_definition:
            cross.write('    <div class="definition"><p>'+definition+'</p>\n')
            cross.write('    </div>\n')
         if len(owlClass.prov_definition) == 0:
            for definition in owlClass.prov_editorsDefinition:
               cross.write('    <div class="editors definition"><p>'+definition+'</p>\n')
               cross.write('    </div>\n')

         # Example taken from http://dvcs.w3.org/hg/prov/file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf
         # <pre about="#example-for-class-Entity" typeof="prov:Entity" 
         #      rel="prov:wasQuotedFrom"  resource="http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_Entity.ttl" 
         #      property="prov:value">{% escape %}{% include "includes/prov/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_Entity.ttl"%}{% endescape %}</pre>
         cross.write('\n')
         cross.write('    <div about="#example-for-class-'+qname[1]+'" typeof="prov:Entity" class="example">\n')
         cross.write('      <span rel="dcterms:subject" resource="'+owlClass.subject+'"></span>\n')
         cross.write('      <strong class="crossreference">Example</strong>\n')
         cross.write('      <pre rel="prov:wasQuotedFrom" resource="'+EXAMPLE_BASE_URL+'class_'+qname[1]+'.ttl"\n')
         cross.write('           property="prov:value">')
         cross.write('{% escape %}{% include "'+EXAMPLE_BASE_LOCAL+'class_'+qname[1]+'.ttl"%}{% endescape %}</pre>\n')
         cross.write('    </div>\n')
         cross.write('\n')

         cross.write('    <dl class="description">\n')

         # class rdfs:comment
         for comment in owlClass.rdfs_comment:
            cross.write('    <dd class="comment"><p>'+comment+'</p>\n')
            cross.write('    </dd>\n')

         # class prov:component ?component
         if len(owlClass.prov_component) > 0 and False:
            cross.write('\n')
            cross.write('      <dt>in PROV component</dt>\n')
            cross.write('      <dd class="component-'+owlClass.prov_component.first+'">\n')
            for component in owlClass.prov_component:
               cross.write('        <a title="'+component+'" href="#component-'+component+'">'+component+'</a>\n')
            cross.write('      </dd>\n')

         # class rdfs:subClassOf ?super
         if len(owlClass.rdfs_subClassOf) > 0:
            cross.write('\n')
            cross.write('      <dt>is subclass of</dt>\n')
            cross.write('      <dd>\n')
            comma = ''
            for super in owlClass.rdfs_subClassOf:
               if super.subject.startswith('http://www.w3.org/ns/prov#'):
                  qname = super.subject.split('#')
                  cross.write('        '+comma+'<a title="'+super.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                  comma = ', '
            cross.write('      </dd>\n')

         #
         #
         #
         # The following chunks answer the question of "what properties can I use on this class?"
         # They should be grouped such that their distinctions are not as salient.
         #
         #
         #

         # CASE 2: ?property rdfs:domain ( ... class ... )
         propertiesThatUnionMeInDomain = set()
         for triple in graph.triples((None, ns.RDFS['domain'], None)):
            for union in graph.triples((triple[2],ns.OWL['unionOf'],None)):
               for classInDomain in graph.items(union[2]):
                  if classInDomain == owlClass.subject:
                     propertiesThatUnionMeInDomain.add(triple[0])
         # CASE 3: class rdfs:subClassOf ?super . ?property rdfs:domain ?super .
         query = select('?super ?property').where((owlClass.subject, ns.RDFS['subClassOf'],'?super'),
                                                  ('?property',      ns.RDFS['domain'],    '?super'))
         results = store.execute(query)
         ignoreSupers = [ns.PROV['Entity'], ns.PROV['Involvement'], ns.PROV['Dictionary']]
         parentIsInDomainOf = False
         for p in results:
            if p[0] not in ignoreSupers:
               parentIsInDomainOf = True

         if len(owlClass.is_rdfs_domain_of) > 0 or len(propertiesThatUnionMeInDomain) > 0 or parentIsInDomainOf:
            cross.write('      <dt>described with properties:</dt><dd></dd>\n')

            # CASE 1: ?p rdfs:domain class
            if len(owlClass.is_rdfs_domain_of) > 0:
               cross.write('\n')
               #cross.write('      <dt>in domain of</dt>\n')
               cross.write('      <dt></dt>\n')
               cross.write('      <dd>\n')
               comma = ''
               for p in owlClass.is_rdfs_domain_of:
                  pqname = p.subject.split('#')
                  cross.write('        '+comma+'<a title="'+p.subject+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')
                  if ns.OWL['DatatypeProperty'] in p.rdf_type:
                     cross.write(' <sup class="type-dp" title="data property">dp</sup>\n')
                  else:
                     cross.write(' <sup class="type-op" title="object property">op</sup>\n')
                  comma = ', '
               cross.write('      </dd>\n')

            # CASE 2: ?property rdfs:domain ( ... class ... )
            if len(propertiesThatUnionMeInDomain) > 0:
               cross.write('\n')
               #cross.write('      <dt>a domain of</dt>\n')
               cross.write('      <dt></dt>\n')
               cross.write('      <dd>\n')
               comma = ''
               for p in propertiesThatUnionMeInDomain:
                  pqname = p.split('#')
                  #print '     ' + owlClass.subject + ' in domain of ' + pqname[1]
                  cross.write('        '+comma+'<a title="'+p+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>' + sup[propertyTypes[p]])
                  comma = ', '

            # CASE 3: class rdfs:subClassOf ?super . ?property rdfs:domain ?super .
            if parentIsInDomainOf:
               #print owlClass.subject
               cross.write('\n')
               #cross.write('      <dt>parent is in domain of</dt>\n')
               cross.write('      <dt></dt>\n')
               cross.write('      <dd>\n')
               comma = ''
               for p in results:
                  if p[0] not in ignoreSupers:
                     #print '    ' + p[0] + '  ' + p[1]
                     pqname = p[1].split('#')
                     if p[1] in propertyTypes:
                        cross.write('        '+comma+'<a title="'+p[1]+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a> '+sup[propertyTypes[p[1]]])
                        comma = ', '
               cross.write('      </dd>\n')
         #
         #
         #
         # The chunks above answer the question of "Which properties can I use on this class?"
         #
         #
         #


         # ?p rdfs:range class
         if len(owlClass.is_rdfs_range_of) > 0:
            cross.write('\n')
            cross.write('      <dt>in range of</dt>\n')
            cross.write('      <dd>\n')
            for p in owlClass.is_rdfs_range_of:
               pqname = p.subject.split('#')
               cross.write('        <a title="'+p.subject+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')
               if ns.OWL['DatatypeProperty'] in p.rdf_type:
                  cross.write(' <sup class="type-dp" title="data property">dp</sup>\n')
               else:
                  cross.write(' <sup class="type-op" title="object property">op</sup>\n')
            cross.write('      </dd>\n')

         # ?sub rdfs:subClassOf class
         if len(owlClass.is_rdfs_subClassOf_of) > 0:
            es = 'es' if len(owlClass.is_rdfs_subClassOf_of) > 1 else ''
            cross.write('\n')
            cross.write('      <dt>has subclass'+es+'</dt>\n')
            cross.write('      <dd>\n')
            comma = ''
            for sub in owlClass.is_rdfs_subClassOf_of:
               qname = sub.subject.split('#')
               cross.write('        '+comma+'<a title="'+sub.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
               comma = ', '
            cross.write('      </dd>\n')

         # class prov:unqualifiedForm ?p
         if len(owlClass.prov_unqualifiedForm) > 0:
            #print 'Influence:             ' + owlClass.subject
            #print 'unqualified influence: ' + owlClass.prov_unqualifiedForm.first.subject
            qname = owlClass.prov_unqualifiedForm.first.subject.split('#')
            cross.write('\n')
            cross.write('      <dt>qualifies</dt>\n')
            cross.write('      <dd>\n')
            cross.write('        <a title="'+owlClass.prov_unqualifiedForm.first.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a>'
                                 +sup[propertyTypes[owlClass.prov_unqualifiedForm.first.subject]]+'\n')
            cross.write('      </dd>\n')

         validSeeAlsos = Set()
         if len(owlClass.rdfs_seeAlso) > 0:
            for also in owlClass.rdfs_seeAlso:
               if str(also).startswith('http://www.w3.org/ns/prov#') or str(also).startswith('http://www.w3.org/TR/prov-o'):
                  validSeeAlsos.add(str(also))
         for also in validSeeAlsos:
            print owlClass.subject + ' see also ' + also

         include_dm_links = True
         include_other_links = False
         if include_dm_links:
            if len(owlClass.prov_dm) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-dm</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-dm" href="'+owlClass.prov_dm.first+'">prov-dm</a>')
               cross.write('      </dd>\n')
            
         if include_other_links:
            if len(owlClass.prov_constraints) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-constraints</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-constraints" href="'+owlClass.prov_constraints.first+'">prov-constraints</a>')
               cross.write('      </dd>\n')
            if len(owlClass.prov_n) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-n</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-n" href="'+owlClass.prov_n.first+'">prov-n</a>')
               cross.write('      </dd>\n')
            if len(owlClass.prov_aq) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-aq</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-aq" href="'+owlClass.prov_aq.first+'">prov-aq</a>')
               cross.write('      </dd>\n')

         cross.write('    </dl>\n')
         cross.write('  </div>\n')
      cross.write('</div>\n')


      # Properties # # # # # # # # # # # # # # # # #
      # cross-reference
      cross.write('<div\n') # We want to include it multiple times: id="'+PREFIX+'-'+category+'-owl-properties-crossreference"\n')
      cross.write('     class="'+PREFIX+'-'+category+' owl-properties crossreference"\n')
      cross.write('     xmlns:prov="http://www.w3.org/ns/prov#">\n')
      for uri in ordered['properties']:
         property = []
         if propertyTypes[uri] == 'datatype-property':
            property = session.get_resource(uri,DatatypeProperties)
         else:
            property = session.get_resource(uri,ObjectProperties)
         qname = property.subject.split('#')
         cross.write('  <div id="'+qname[1]+'" class="entity">\n')
         cross.write('    <h3>\n')
         cross.write('      Property: <a href="#'+qname[1]+'"><span class="dotted" title="'+uri+'">'+PREFIX+':'+qname[1]+'</span></a>')
         if ns.OWL['DatatypeProperty'] in property.rdf_type:
            cross.write(' <sup class="type-dp" title="data property">dp</sup>\n')
         else:
            cross.write(' <sup class="type-op" title="object property">op</sup>\n')
         cross.write('      <span class="backlink">\n')
         cross.write('         back to <a href="#'+PREFIX+'-'+category+'-owl-terms-at-a-glance">'+category+' properties</a>\n')
         cross.write('      </span>\n')
         cross.write('    </h3>\n')

         # property
         cross.write('    <p><strong class="crossreference">IRI:</strong>'+uri+'</p>\n')

         # property prov:definition, prov:sharesDefinitionWith [ prov:definition ], 
         # prov:qualifiedFrom [ a owl:Class, prov:definition ], prov:editorsDefinition
         if len(property.prov_definition) > 0:
            # If it has its own definition, use it.
            for definition in property.prov_definition:
               cross.write('    <div class="definition def-from-1"><p>'+definition+'</p>\n')
         elif len(property.prov_sharesDefinitionWith) > 0:
            # If it shares a definition, use that.
            sharer = property.prov_sharesDefinitionWith.first
            #print property.subject + ' sharing definition'
            #print property.subject + ' sharing definition of ' + sharer.subject
            if len(sharer.prov_definition) > 0:
               cross.write('    <div class="definition def-from-2"><p>'+sharer.prov_definition.first+'</p>\n')
            elif len(sharer.prov_editorsDefinition) > 0:
               cross.write('    <div class="definition def-from-3"><p>'+sharer.prov_editorsDefinition.first+'</p>\n')
            else:
               cross.write('    <div class="definition def-from-4"><p>TODO property shared def missing.</p>\n')
         elif len(property.prov_qualifiedForm) > 0:
            found = False
            for qualifiedForm in property.prov_qualifiedForm:
               if ns.OWL['Class'] in qualifiedForm.rdf_type:
                  found = True
                  cross.write('    <div class="definition def-from-5"><p>'+qualifiedForm.prov_definition.first+'</p>\n')
            if not found:
               cross.write('    <div class="definition def-from-6"><p>TODO get property from qualified form class.</p>\n')
         elif len(property.prov_editorsDefinition) > 0:
            for definition in property.prov_editorsDefinition:
               cross.write('    <div class="definition def-from-7"><p>'+definition+'</p>\n')
         else:
            cross.write('    <div class="definition def-from-8"><p>TODO Property needs a definition.</p>\n')
         cross.write('    </div>\n')

         # Example taken from http://dvcs.w3.org/hg/prov/file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf
         cross.write('\n')
         cross.write('    <div about="#example-for-property-'+qname[1]+'" typeof="prov:Entity" class="example">\n')
         cross.write('      <span rel="dcterms:subject" resource="'+property.subject+'"></span>\n')
         cross.write('      <strong class="crossreference">Example</strong>\n')
         cross.write('      <pre rel="prov:wasQuotedFrom" resource="'+EXAMPLE_BASE_URL+'property_'+qname[1]+'.ttl"\n')
         cross.write('           property="prov:value">')
         cross.write('{% escape %}{% include "'+EXAMPLE_BASE_LOCAL+'property_'+qname[1]+'.ttl"%}{% endescape %}</pre>\n')
         cross.write('    </div>\n')
         cross.write('\n')

         cross.write('    <div class="description">\n')

         # property rdfs:comment
         for comment in property.rdfs_comment:
            atRisk = ' feature-at-risk' if comment.find('may be removed from this specification') >=0 else ''
            cross.write('      <div class="comment '+atRisk+'"><p>'+comment+'</p>\n')
            cross.write('      </div>\n')

         # Characteristics
         characteristics = {ns.OWL['FunctionalProperty']:        'http://www.w3.org/TR/owl2-syntax/#Functional_Object_Properties',
                            ns.OWL['InverseFunctionalProperty']: 'http://www.w3.org/TR/owl2-syntax/#Inverse-Functional_Object_Properties',
                            ns.OWL['TransitiveProperty']:        'http://www.w3.org/TR/owl2-syntax/#Transitive_Object_Properties',
                            ns.OWL['SymmetricProperty']:         'http://www.w3.org/TR/owl2-syntax/#Symmetric_Object_Properties',
                            ns.OWL['AsymmetricProperty']:        'http://www.w3.org/TR/owl2-syntax/#Asymmetric_Object_Properties',
                            ns.OWL['ReflexiveProperty']:         'http://www.w3.org/TR/owl2-syntax/#Reflexive_Object_Properties',
                            ns.OWL['IrreflexiveProperty']:       'http://www.w3.org/TR/owl2-syntax/#Irreflexive_Object_Properties'}
         has = False
         for characteristic in characteristics.keys():
            if characteristic in property.rdf_type:
               has = True
         if has:
            cross.write('      <p><strong class="crossreference">has characteristics</strong>')
            comma = ''
            for characteristic in characteristics.keys():
               if characteristic in property.rdf_type:
                  qname = characteristic.split('#')
                  cross.write(comma+' <a href="'+characteristics[characteristic]+'">'+qname[1].replace('Property','').replace('F',' F')+'</a>')
                  comma = ', '
            cross.write('      </p>\n')

         cross.write('      <dl>\n')

         # property prov:component ?component
         if len(property.prov_component) > 0 and False:
            cross.write('\n')
            cross.write('      <dt>in PROV component</dt>\n')
            cross.write('      <dd class="component-'+property.prov_component.first+'">\n')
            for component in property.prov_component:
               cross.write('        <a title="'+component+'" href="#component-'+component+'">'+component+'</a>\n')
            cross.write('      </dd>\n')

         # property rdfs:subPropertyOf ?super
         do = False
         for super in property.rdfs_subPropertyOf:
            qname = super.subject.split('#')
            if qname[0] == 'http://www.w3.org/ns/prov':
               do = True
         if do:
            cross.write('\n')
            cross.write('        <dt>has super-properties</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for super in property.rdfs_subPropertyOf:
               qname = super.subject.split('#')
               if qname[0] == 'http://www.w3.org/ns/prov':
                  cross.write('            <li>\n')
                  cross.write('              <a title="'+super.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>'
                                             +sup[propertyTypes[super.subject]]+'\n')
                  cross.write('            </li>\n')
            cross.write('          </ul>\n')
            cross.write('        </dd>\n')

         # property rdfs:domain ?class
         if len(property.rdfs_domain) > 0:
            cross.write('\n')
            cross.write('        <dt>has domain</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for domain in property.rdfs_domain:
               qname = domain.subject.split('#')
               cross.write('            <li>\n')
               if domain.subject.startswith('http://www.w3.org/ns/prov#'):
                  cross.write('              <a title="'+domain.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
               else:
                  # NOTE: This processes ALL [ owl:unionOf () ], so if there are more than one it will duplicate.
                  # Part of the problem is that SuRF might be giving different bnode IDs than rdflib.
                  #print property.subject + ' has a union domain that includes:'
                  for triple in graph.triples((property.subject, ns.RDFS['domain'], None)):
                     for union in graph.triples((triple[2],ns.OWL['unionOf'],None)):
                        orString = ''
                        for classInDomain in graph.items(union[2]):
                           qname = classInDomain.split('#')
                           #print '     ' + qname[1]
                           cross.write('              '+orString+'<a title="'+classInDomain+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                           orString = ' or '
               cross.write('            </li>\n')
            cross.write('          </ul>\n')
            cross.write('        </dd>\n')

         # property rdfs:range ?class
         if len(property.rdfs_range) > 0:
            cross.write('\n')
            cross.write('        <dt>has range</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for range in property.rdfs_range:
               cross.write('            <li>\n')
               try:
                  qname = range.subject.split('#')
                  if qname[0] == 'http://www.w3.org/ns/prov':
                     cross.write('              <a title="'+range.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                  elif qname[0] == 'http://www.w3.org/2002/07/owl':
                     noop = 'noop'
                  else:
                     # cross.write('              TODO '+str(range)+'\n')
                     # NOTE: This processes ALL [ owl:unionOf () ], so if there are more than one it will duplicate.
                     # Part of the problem is that SuRF might be giving different bnode IDs than rdflib.
                     #print property.subject + ' has a union domain that includes:'
                     for triple in graph.triples((property.subject, ns.RDFS['range'], None)):
                        for union in graph.triples((triple[2],ns.OWL['unionOf'],None)):
                           orString = ''
                           for classInDomain in graph.items(union[2]):
                              qname = classInDomain.split('#')
                              #print '     ' + qname[1]
                              cross.write('              '+orString+'<a title="'+classInDomain+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                              orString = ' or '
               except:
                  cross.write('              '+str(range)+'\n')
               cross.write('            </li>\n')
            cross.write('          </ul>\n')
            cross.write('        </dd>\n')

         # property owl:inverseOf ?inverse
         if len(property.owl_inverseOf) > 0:
            cross.write('\n')
            cross.write('        <dt>has inverse</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for inverse in property.owl_inverseOf:
               cross.write('            <li>\n')
               try:
                  qname = inverse.subject.split('#')
                  if qname[0] == 'http://www.w3.org/ns/prov':
                     cross.write('              <a title="'+inverse.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                  elif qname[0] == 'http://www.w3.org/2002/07/owl':
                     noop = 'noop'
                  else:
                     cross.write('              '+str(inverse)+'\n')
               except:
                  cross.write('              '+str(inverse)+'\n')
               cross.write('            </li>\n')
            cross.write('          </ul>\n')
            cross.write('        </dd>\n')

         # ?sub rdfs:subPropertyOf property
         do = False
         for sub in property.is_rdfs_subPropertyOf_of:
            qname = sub.subject.split('#')
            if qname[0] == 'http://www.w3.org/ns/prov':
               do = True
         if do:
            cross.write('\n')
            cross.write('        <dt>has sub-properties</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for sub in property.is_rdfs_subPropertyOf_of:
               qname = sub.subject.split('#')
               if qname[0] == 'http://www.w3.org/ns/prov':
                  cross.write('            <li>\n')
                  cross.write('              <a title="'+sub.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
                  cross.write('            </li>\n')
            cross.write('          </ul>\n')
            cross.write('        </dd>\n')

         # property prov:qualifiedForm ?class, ?property
         if len(property.prov_qualifiedForm) > 0:
            qname = property.prov_qualifiedForm.first.subject.split('#')
            cross.write('\n')
            cross.write('        <dt>can be qualified with</dt>\n')
            cross.write('        <dd>\n')
            cross.write('          <ul>\n')
            for qualified in property.prov_qualifiedForm:
               qname = qualified.subject.split('#')
               owlType=''
               s=''
               if ns.OWL['Class'] in qualified.rdf_type:
                  owlType='class'
               else:
                  owlType='property'
                  s = sup[propertyTypes[qualified.subject]]
               cross.write('            <li>\n')
               cross.write('              <a title="'+qualified.subject+'" href="#'+qname[1]+'" class="owl'+owlType+'">'+PREFIX+':'+qname[1]+'</a>'+s+'\n')
               cross.write('            </li>\n')
            cross.write('          </ul>\n') 
            cross.write('        </dd>\n')   

         # property prov:unqualifiedForm ?p
         if len(property.prov_unqualifiedForm) > 0:
            #print property.subject + ' has unqualifiedForm'
            qname = property.prov_unqualifiedForm.first.subject.split('#')
            #print property.subject + ' has unqualifiedForm '  + property.prov_unqualifiedForm.first.subject
            cross.write('\n')
            cross.write('      <dt>qualifies</dt>\n')
            cross.write('      <dd>\n')
            cross.write('        <a title="'+property.prov_unqualifiedForm.first.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a>'
                                          +sup[propertyTypes[property.prov_unqualifiedForm.first.subject]]+'\n')
            cross.write('      </dd>\n')

         cross.write('\n')
         cross.write('      </dl>\n')

         if include_dm_links:
            if len(property.prov_dm) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-dm</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-dm" href="'+property.prov_dm.first+'">prov-dm</a>')
               cross.write('      </dd>\n')
         if include_other_links:
            if len(property.prov_constraints) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-constraints</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-constraints" href="'+property.prov_constraints.first+'">prov-constraints</a>')
               cross.write('      </dd>\n')
            if len(property.prov_n) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-n</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-n" href="'+property.prov_n.first+'">prov-n</a>')
               cross.write('      </dd>\n')
            if len(property.prov_aq) > 0:
               cross.write('\n')
               cross.write('      <dt>prov-aq</dt>\n')
               cross.write('      <dd>\n')
               cross.write('        <a title="prov-aq" href="'+property.prov_aq.first+'">prov-aq</a>')
               cross.write('      </dd>\n')


         cross.write('    </div>\n') # e.g. <div class="description">
         cross.write('  </div>\n')   # e.g. <div id="wasGeneratedBy" class="entity">
         cross.write('\n')
      cross.write('</div>\n')        # e.g. <div id="prov-starting-point-owl-classes-crossreference"

      tableCount = { 'expanded' : '2', 'starting-point' : '1', 'qualified' : '3', 'access-and-query' : '4' }
      n = ''
      if category.lower()[0] in ['a','e','i,','o','u']:
         n = 'n'
      quals.write('<table class="qualified-forms">\n')
      quals.write('  <caption><a href="#qualified-forms-'+category+'">Table '+tableCount[category]+'</a>: Qualification Property and Influence Class used to qualify a'+n+' '+category.capitalize()+' Property.</caption>\n')
      quals.write('  <tr>\n')
      qname = property.subject.split('#')
      quals.write('    <th><span title="Influenced Class">Influenced Class</span></th>\n')
      quals.write('    <th><span title="Unqualified Influence">Unqualified Influence</span></th>\n')
      quals.write('    <th><span title="Qualification Property">Qualification Property</span></th>\n')
      quals.write('    <th><span title="Qualified Influence">Qualified Influence</span></th>\n')
      quals.write('    <th><span title="Influencer Property">Influencer Property</span></th>\n')
      quals.write('    <th><span title="Influencing Class">Influencing Class</span></th>\n')
      quals.write('  </tr>\n')
      for uri in ordered['properties']:
         #print 'qual table ' + uri
         property = []
         if propertyTypes[uri] == 'datatype-property':
            property = session.get_resource(uri,DatatypeProperties)
         else:
            property = session.get_resource(uri,ObjectProperties) # e.g. http://www.w3.org/ns/prov#actedOnBehalfOf
         if len(property.prov_qualifiedForm) > 0:
            qualProp   = 'no'
            qualClass  = 'no'
            objectProp = 'no'
            for qualified in property.prov_qualifiedForm:
               if len(qualified.rdf_type) == 0:
                  print 'ERROR on qualifiedForm annotation for ' + property.subject
                  print qualified + ' is not defined'
               elif ns.OWL['Class'] in qualified.rdf_type:
                  qualClass = qualified                           # e.g. http://www.w3.org/ns/prov#Responsibility
                  for super in qualClass.rdfs_subClassOf:
                     qname = super.subject.split('#')
                     if   ( qname[1]  == 'EntityInfluence' ):
                        objectProp = 'entity' 
                     elif ( qname[1]  == 'ActivityInfluence' ):
                        objectProp = 'activity' 
                     elif ( qname[1]  == 'AgentInfluence' ):
                        objectProp = 'agent' 
                     elif ( qname[1]  == 'CollectionInfluence' ):
                        objectProp = 'collection' 
                     elif ( qname[1]  == 'DictionaryInfluence' ):
                        objectProp = 'collection' 
               else:
                  if "qualified" in qualified.subject:
                     qualProp  = qualified                           # e.g. http://www.w3.org/ns/prov#qualifiedResponsibility
                  else:
                     qualProp = 'no' # Avoiding prov:startedAtTime, prov:atTime, prov:Start, null
            if qualProp != 'no' and qualClass != 'no' and objectProp != 'no':
               quals.write('  <tr>\n')

               #print property.subject + ' gets qualified'
               qname = property.rdfs_domain.first.subject.split('#')
               quals.write('    <td><a title="'+property.rdfs_domain.first.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a></td>\n')

               qname = property.subject.split('#')
               quals.write('    <td><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')

               qname = qualProp.subject.split('#')
               quals.write('    <td><a title="'+qualProp.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')

               qname = qualClass.subject.split('#')
               quals.write('    <td><a title="'+qualClass.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a></td>\n')

               quals.write('    <td><a title="'+qname[0]+'#'+objectProp+'" href="#'+objectProp+'" class="owlproperty">'+PREFIX+':'+objectProp+'</a></td>\n')

               quals.write('    <td><a title="'+qname[0]+'#'+objectProp.capitalize()+'" href="#'+objectProp.capitalize()+'" class="owlclass">'+PREFIX+':'+objectProp.capitalize()+'</a></td>\n')
               quals.write('  </tr>\n')
      quals.write('</table>\n')

      glance.close()
      cross.close()
      quals.close()
   else:
      print '  '+glanceName + ' or ' + crossName + " already exists. Not modifying."

# TODO: check for isDefinedBy prov:

#<table about="#inverse-names"
#       xmlns:prov="http://www.w3.org/ns/prov#"
#       typeof="prov:Dictionary" class="inverse-names">
#  <span rel="prov:wasDerivedFrom" resource="http://www.w3.org/TR/prov-o/prov.owl"/>
#  <caption>Names of inverses</caption>
#  <tr>
#    <th>PROV-O Property</th>
#    <th>Recommended inverse name</th>
#  </tr>
#  <span rel="prov:member">
#     <tr about="#inverse-of-derivedByInsertionFrom" typeof="prov:KeyValuePair">
#       <td property="prov:pairKey" content="http://www.w3.org/ns/prov#derivedByInsertionFrom"><a title="http://www.w3.org/ns/prov#derivedByInsertionFrom" href="#derivedByInsertionFrom" 
#           class="owlproperty">prov:derivedByInsertionFrom</a></td>
#       <td property="prov:pairValue">prov:hadDerivationByInsertion</td>
#     </tr>
#  </span>

inversesName = 'inverse-names.html'
uuid = str(uuid.uuid1())
inverses = open(inversesName, 'w')
rdfa = False
if rdfa:
   inverses.write('<table about="#inverse-names-'+uuid+'"\n') # TODO: add generatedAtTime
   inverses.write('       xmlns:prov="http://www.w3.org/ns/prov#"\n')
   inverses.write('       xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"\n')
   inverses.write('       xmlns:xsd="http://www.w3.org/2001/XMLSchema#"\n')
   inverses.write('       typeof="prov:Dictionary" class="inverse-names">\n')
   inverses.write('  <span rel="prov:wasDerivedFrom" resource="http://www.w3.org/TR/prov-o/prov.owl"/>\n')
   inverses.write('  <span rel="prov:wasInfluencedBy"    resource="http://www.w3.org/TR/rdfa-syntax/#rdfa-attributes"/>\n')
   inverses.write('  <span rel="prov:wasInfluencedBy"    resource="http://www.w3.org/2007/08/pyRdfa/"/>\n')
   inverses.write('  <span rel="prov:wasInfluencedBy"    resource="http://data.semanticweb.org/person/alvaro-graves"/>\n')
   inverses.write('  <span rel="prov:wasInfluencedBy"    resource="http://tw.rpi.edu/instances/TimLebo"/>\n')
   inverses.write('  <span rel="prov:specializationOf" resource="#inverse-names"><span rel="rdf:type" resource="http://www.w3.org/ns/prov#Dictionary"/></span>\n')
   inverses.write('  <span property="prov:generatedAtTime" content="'+str(datetime.datetime.utcnow()).replace(' ','T')+'" datatype="xsd:dateTime"/>\n')
   inverses.write('  <caption>Names of inverses</caption>\n')
   inverses.write('  <tr>\n')
   inverses.write('    <th>PROV-O Property</th>\n')
   inverses.write('    <th>Recommended inverse name</th>\n')
   inverses.write('  </tr>\n')
   for property in ObjectProperties.all():
      qname = property.subject.split('#')
      if property.prov_inverse:
         inverses.write('  <span rel="prov:member">\n')
         inverses.write('    <tr about="#inverse-of-'+qname[1]+'" typeof="prov:KeyValuePair">\n')
         inverses.write('      <td property="prov:pairKey" content="'+property.subject+'"><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')
                       #       <td rel="prov:pairValue"><span typeof="prov:Entity" property="prov:value" content="wasQuotedBy">prov:wasQuotedBy</span></td>
         inverses.write('      <td rel="prov:pairValue"><span typeof="prov:Entity" property="prov:value" content="'+property.prov_inverse.first+'">prov:'+property.prov_inverse.first+'</span></td>\n')
         inverses.write('    </tr>\n')
         inverses.write('  </span>\n')
   inverses.write('</table>\n')
elif False:
   
   # Thanks to Gregg Kellogg from lod-public@w3.org
   # The rdfa crew hangs out at public-rdfa@w3.org and #rdfa on irc.w3.org.

   #<div resource="#inverse-names-592b37e4-ac61-11e1-b149-b6e4fd0676c2"
   #     prefix="prov: http://www.w3.org/ns/prov#"
   #     typeof="prov:Dictionary">
   # <span property="prov:wasDerivedFrom" resource="http://www.w3.org/TR/prov-o/prov.owl"/>
   # <span property="prov:wasInfluencedBy" resource="http://www.w3.org/TR/rdfa-syntax/#rdfa-attributes"/>
   # <span property="prov:wasInfluencedBy" resource="http://data.semanticweb.org/person/alvaro-graves"/>
   # <span property="prov:wasInfluencedBy" resource="http://tw.rpi.edu/instances/TimLebo"/>
   # <span property="prov:specializationOf" resource="#inverse-names">
   # <span property="rdf:type" resource="http://www.w3.org/ns/prov#Dictionary"/>
   # <span property="prov:wasDerivedFrom" resource="http://www.w3.org/TR/prov-o/prov.owl"/>
   # <span property="prov:generatedAtTime" content="2012-06-02T03:16:30.563734" datatype="xsd:dateTime"/>
   # <table class="inverse-names">
   # <caption>Names of inverses</caption>
   # <tr>
   #  <th>PROV-O Property</th>
   #  <th>Recommended inverse name</th>
   # </tr>
   # <tr property="prov:member" resource="#inverse-of-member" typeof="prov:KeyValuePair">
   #  <td property="prov:pairKey" content="http://www.w3.org/ns/prov#member">
   #   <a title="http://www.w3.org/ns/prov#member" href="#member" class="owlproperty">
   #    prov:member
   #   </a>
   #  </td>
   #  <td property="prov:pairValue" typeof="prov:Entity">
   #   <span property="prov:value" content="inMembership">
   #    prov:inMembership
   #   </span>
   #  </td>
   # </tr>
   # </table>
   #</div>
   print 'todo: better rdfa'

else:
   inverses.write('<table class="inverse-names">\n')
   inverses.write(' <caption>Names of inverses</caption>\n')
   inverses.write(' <tr>\n')
   inverses.write(' <th>Domain</th>\n')
   inverses.write(' <th>PROV-O Property</th>\n')
   inverses.write(' <th>Recommended inverse name</th>\n')
   inverses.write(' <th>Range</th>\n')
   inverses.write(' </tr>\n')
   for property_uri in all_ordered['objectproperties']:
      property = session.get_resource(property_uri,ObjectProperties) 
      qname = property.subject.split('#')
      if property.prov_inverse:
         inverses.write(' <tr>\n')

         # Column 1
         if len(property.rdfs_domain):
            #print property.subject + ' domain ' + property.rdfs_domain.first.subject
            if property.rdfs_domain.first.subject.startswith('http://www.w3.org/ns/prov#'):
               qname_domain = property.rdfs_domain.first.subject.split('#')
               inverses.write(' <td><a title="'+property.rdfs_domain.first.subject+'" href="#'+qname_domain[1]+'" class="owlproperty">'+PREFIX+':'+qname_domain[1]+'</a></td>\n')
            else:
               inverses.write(' <td>union</td>\n')
         else:
            inverses.write(' <td></td>\n')

         # Column 2
         inverses.write(' <td><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')

         # Column 3
         inverses.write(' <td>prov:'+property.prov_inverse.first+'</td>\n')

         # Column 4
         if len(property.rdfs_range):
            #print property.subject + ' range ' + property.rdfs_range.first.subject
            if property.rdfs_range.first.subject.startswith('http://www.w3.org/ns/prov#'):
               qname_range = property.rdfs_range.first.subject.split('#')
               inverses.write(' <td><a title="'+property.rdfs_range.first.subject+'" href="#'+qname_range[1]+'" class="owlproperty">'+PREFIX+':'+qname_range[1]+'</a></td>\n')
            else:
               inverses.write(' <td>union</td>\n')

         inverses.write(' </tr>\n')
   inverses.write('</table>\n')
inverses.close()

inversesName = 'inverses.ttl'
termsName    = 'terms.txt'
inverses  = open(inversesName, 'w')
terms     = open(termsName, 'w')

for class_uri in all_ordered['classes']:
   owlClass = session.get_resource(class_uri,Classes)
   if len(owlClass.rdfs_isDefinedBy) is not 1 or str(owlClass.rdfs_isDefinedBy.first.subject) != 'http://www.w3.org/ns/prov#':
      print 'WARNING: ' + owlClass.subject + ' does not have correct rdfs:isDefinedBy ' + str(len(owlClass.rdfs_isDefinedBy))  #+ ' ' + owlClass.rdfs_isDefinedBy.first.subject
   qname = owlClass.subject.split('#')
   terms.write(qname[1]+'\n')

inverses.write('@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n')
inverses.write('@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n')
inverses.write('@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n')
inverses.write('@prefix owl:  <http://www.w3.org/2002/07/owl#> .\n')
inverses.write('@prefix prov: <http://www.w3.org/ns/prov#> .\n')
inverses.write('\n')
inverses.write('<> prov:wasDerivedFrom <http://www.w3.org/TR/prov-o/prov.owl>;\n')
inverses.write('   rdfs:seeAlso        <http://www.w3.org/TR/prov-o/#names-of-inverse-properties>;\n')
inverses.write('   owl:versionIRI      <http://www.w3.org/TR/2012/WD-prov-o-2012MMDD> .\n')
inverses.write('\n')
for property_uri in all_ordered['objectproperties']:
   property = session.get_resource(property_uri,ObjectProperties)
   qname = property.subject.split('#')
   terms.write(qname[1]+'\n') 
   if property.prov_inverse:
      inverses.write('prov:'+property.prov_inverse.first+'\n')
      inverses.write('   rdfs:label       "'+property.prov_inverse.first+'";\n')
      inverses.write('   owl:inverseOf    prov:'+qname[1]+';\n')
      inverses.write('   rdfs:isDefinedBy <http://www.w3.org/TR/prov-o/inverses.owl> .\n\n')
      inverses.write('prov:'+qname[1] + ' rdfs:isDefinedBy <http://www.w3.org/ns/prov#> .\n\n\n')
#         inverses.write('      <td property="prov:pairKey" content="'+property.subject+'"><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')
#                       #       <td rel="prov:pairValue"><span typeof="prov:Entity" property="prov:value" content="wasQuotedBy">prov:wasQuotedBy</span></td>
#         inverses.write('      <td rel="prov:pairValue"><span typeof="prov:Entity" property="prov:value" content="'+property.prov_inverse.first+'">prov:'+property.prov_inverse.first+'</span></td>\n')
   elif qname[1] is not 'topObjectProperty':
      print 'WARNING: ' + property.subject + ' does not have an inverse'

inverses.close()
terms.close()

for property_uri in all_ordered['objectproperties']:
   property = session.get_resource(property_uri,ObjectProperties)
   if len(property.rdfs_isDefinedBy) is not 1 or str(property.rdfs_isDefinedBy.first.subject) != 'http://www.w3.org/ns/prov#':
      print 'WARNING: ' + property.subject + ' does not have correct rdfs:isDefinedBy ' + str(len(property.rdfs_isDefinedBy))  #+ ' ' + property.rdfs_isDefinedBy.first.subject
for property_uri in all_ordered['datatypeproperties']:
   property = session.get_resource(property_uri,DatatypeProperties)
   if len(property.rdfs_isDefinedBy) is not 1 or str(property.rdfs_isDefinedBy.first.subject) != 'http://www.w3.org/ns/prov#':
      print 'WARNING: ' + property.subject + ' does not have correct rdfs:isDefinedBy ' + str(len(property.rdfs_isDefinedBy))  #+ ' ' + property.rdfs_isDefinedBy.first.subject

