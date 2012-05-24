#!/usr/bin/env python

# To install dependencies, see https://github.com/timrdf/DataFAQs/wiki/Errors

import sys
from rdflib import *

from surf import *
from surf.query import a, select

import rdflib
rdflib.plugin.register('sparql', rdflib.query.Processor, 'rdfextras.sparql.processor', 'Processor')
rdflib.plugin.register('sparql', rdflib.query.Result,    'rdfextras.sparql.query',     'SPARQLQueryResult')

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
         if property.prov_category.first == category:
            ordered['properties'].append(property.subject)
            propertyTypes[property.subject] = "datatype-property"
      for property in ObjectProperties.all():
         if property.prov_category.first == category:
            ordered['properties'].append(property.subject)
            propertyTypes[property.subject] = "object-property"
      ordered['properties'].sort()

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
         #cross.write('    <p><strong>IRI:</strong><a href="'+uri+'">'+uri+'</a></p>\n')
         cross.write('    <p><strong>IRI:</strong>'+uri+'</p>\n')

         # class prov:definition
         for definition in owlClass.prov_definition: # TODO: not done for properties. How to reconcile def vs comments vs editorNote?
            cross.write('    <div class="definition"><p>'+definition+'</p>\n')
            cross.write('    </div>\n')

         # Example taken from http://dvcs.w3.org/hg/prov/file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf
         # <pre about="#example-for-class-Entity" typeof="prov:Entity" 
         #      rel="prov:wasQuotedFrom"  resource="http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_Entity.ttl" 
         #      property="prov:value">{% escape %}{% include "includes/prov/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_Entity.ttl"%}{% endescape %}</pre>
         cross.write('\n')
         cross.write('    <div about="#example-for-class-'+qname[1]+'" typeof="prov:Entity" class="example">\n')
         cross.write('      <span rel="dcterms:subject" resource="'+owlClass.subject+'"></span>\n')
         cross.write('      <strong>Example</strong>\n')
         cross.write('      <pre rel="prov:wasQuotedFrom" resource="http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_'+qname[1]+'.ttl"\n')
         cross.write('           property="prov:value">')
         cross.write('{% escape %}{% include "includes/prov/examples/eg-24-prov-o-html-examples/rdf/create/rdf/class_'+qname[1]+'.ttl"%}{% endescape %}</pre>\n')
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
            for super in owlClass.rdfs_subClassOf:
               if super.subject.startswith('http://www.w3.org/ns/prov#'):
                  qname = super.subject.split('#')
                  cross.write('        <a title="'+super.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
            cross.write('      </dd>\n')

         # ?p rdfs:domain class
         if len(owlClass.is_rdfs_domain_of) > 0:
            cross.write('\n')
            cross.write('      <dt>in domain of</dt>\n')
            cross.write('      <dd>\n')
            for p in owlClass.is_rdfs_domain_of:
               pqname = p.subject.split('#')
               cross.write('        <a title="'+p.subject+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')
               if ns.OWL['DatatypeProperty'] in p.rdf_type:
                  cross.write('<sup class="type-dp" title="data property">dp</sup>\n')
               else:
                  cross.write('<sup class="type-op" title="object property">op</sup>\n')
            cross.write('      </dd>\n')

         # ?property rdfs:domain ( ... class ... )
         propertiesThatUnionMeInDomain = set()
         for triple in graph.triples((None, ns.RDFS['domain'], None)):
            for union in graph.triples((triple[2],ns.OWL['unionOf'],None)):
               for classInDomain in graph.items(union[2]):
                  if classInDomain == owlClass.subject:
                     propertiesThatUnionMeInDomain.add(triple[0])
         if len(propertiesThatUnionMeInDomain) > 0:
            cross.write('\n')
            cross.write('      <dt>a domain of</dt>\n')
            cross.write('      <dd>\n')
            for p in propertiesThatUnionMeInDomain:
               pqname = p.split('#')
               print '     ' + owlClass.subject + ' in domain of ' + pqname[1]
               cross.write('        <a title="'+p+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')

         # class rdfs:subClassOf ?super . ?property rdfs:domain ?super .
         query = select('?super ?property').where((owlClass.subject, ns.RDFS['subClassOf'],'?super'),
                                                  ('?property',      ns.RDFS['domain'],    '?super'))
         results = store.execute(query)
         ignoreSupers = [ns.PROV['Entity'], ns.PROV['Involvement'], ns.PROV['Dictionary']]
         if len(results) > 0:
            #print owlClass.subject
            cross.write('\n')
            cross.write('      <dt>parent is in domain of</dt>\n')
            cross.write('      <dd>\n')
            for p in results:
               if p[0] not in ignoreSupers:
                  #print '    ' + p[0] + '  ' + p[1]
                  pqname = p[1].split('#')
                  cross.write('        <a title="'+p[1]+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')
                  #if ns.OWL['DatatypeProperty'] in p.rdf_type:
                  #   cross.write('<sup class="type-dp" title="data property">dp</sup>\n')
                  #else:
                  #   cross.write('<sup class="type-op" title="object property">op</sup>\n')
            cross.write('      </dd>\n')

         # ?p rdfs:range class
         if len(owlClass.is_rdfs_range_of) > 0:
            cross.write('\n')
            cross.write('      <dt>in range of</dt>\n')
            cross.write('      <dd>\n')
            for p in owlClass.is_rdfs_range_of:
               pqname = p.subject.split('#')
               cross.write('        <a title="'+p.subject+'" href="#'+pqname[1]+'">'+PREFIX+':'+pqname[1]+'</a>')
               if ns.OWL['DatatypeProperty'] in p.rdf_type:
                  cross.write('<sup class="type-dp" title="data property">dp</sup>\n')
               else:
                  cross.write('<sup class="type-op" title="object property">op</sup>\n')
            cross.write('      </dd>\n')

         # ?sub rdfs:subClassOf class
         if len(owlClass.is_rdfs_subClassOf_of) > 0:
            es = '' # plural form grammar
            if len(owlClass.is_rdfs_subClassOf_of) > 1:
               es="es"
            cross.write('\n')
            cross.write('      <dt>has subclass'+es+'</dt>\n')
            cross.write('      <dd>\n')
            for sub in owlClass.is_rdfs_subClassOf_of:
               qname = sub.subject.split('#')
               cross.write('        <a title="'+sub.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
            cross.write('      </dd>\n')

         # class prov:unqualifiedForm ?p
         if len(owlClass.prov_unqualifiedForm) > 0:
            #print owlClass.subject
            #print owlClass.prov_unqualifiedForm.first
            qname = owlClass.prov_unqualifiedForm.first.subject.split('#')
            cross.write('\n')
            cross.write('      <dt>qualifies</dt>\n')
            cross.write('      <dd>\n')
            cross.write('        <a title="'+owlClass.prov_unqualifiedForm.first.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a>\n')
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
            cross.write('<sup class="type-dp" title="data property">dp</sup>\n')
         else:
            cross.write('<sup class="type-op" title="object property">op</sup>\n')
         cross.write('      <span class="backlink">\n')
         cross.write('         back to <a href="#'+PREFIX+'-'+category+'-owl-terms-at-a-glance">'+category+' properties</a>\n')
         cross.write('      </span>\n')
         cross.write('    </h3>\n')

         # property
         #cross.write('    <p><strong>IRI:</strong><a href="'+uri+'">'+uri+'</a></p>\n')
         cross.write('    <p><strong>IRI:</strong>'+uri+'</p>\n')

         # Example taken from http://dvcs.w3.org/hg/prov/file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf
         cross.write('\n')
         cross.write('    <div about="#example-for-property-'+qname[1]+'" typeof="prov:Entity" class="example">\n')
         cross.write('      <span rel="dcterms:subject" resource="'+property.subject+'"></span>\n')
         cross.write('      <strong>Example</strong>\n')
         cross.write('      <pre rel="prov:wasQuotedFrom" resource="http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-24-prov-o-html-examples/rdf/create/rdf/property_'+qname[1]+'.ttl"\n')
         cross.write('           property="prov:value">')
         cross.write('{% escape %}{% include "includes/prov/examples/eg-24-prov-o-html-examples/rdf/create/rdf/property_'+qname[1]+'.ttl"%}{% endescape %}</pre>\n')
         cross.write('    </div>\n')
         cross.write('\n')

         cross.write('    <div class="description">\n')

         # property rdfs:comment
         for comment in property.rdfs_comment:
            cross.write('      <div class="comment"><p>'+comment+'</p>\n')
            cross.write('      </div>\n')

         # Characteristics
         characteristics = [ns.OWL['FunctionalProperty'],
                            ns.OWL['InverseFunctionalProperty'],
                            ns.OWL['TransitiveProperty'],
                            ns.OWL['SymmetricProperty'],
                            ns.OWL['AsymmetricProperty'],
                            ns.OWL['ReflexiveProperty'],
                            ns.OWL['IrreflexiveProperty']]
         has = False
         for characteristic in characteristics:
            if characteristic in property.rdf_type:
               has = True
         if has:
            cross.write('      <p><strong>has characteristics</strong>')
            comma = ''
            for characteristic in characteristics:
               if characteristic in property.rdf_type:
                  qname = characteristic.split('#')
                  cross.write(comma+' '+qname[1].replace('Property','').replace('F',' F')+' ')
                  comma = ','
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
                  cross.write('              <a title="'+super.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a>\n')
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
                     cross.write('              '+str(range)+'\n')
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
               if ns.OWL['Class'] in qualified.rdf_type:
                  owlType='class'
               else:
                  owlType='property'
               cross.write('            <li>\n')
               cross.write('              <a title="'+qualified.subject+'" href="#'+qname[1]+'" class="owl'+owlType+'">'+PREFIX+':'+qname[1]+'</a>\n')
               cross.write('            </li>\n')
            cross.write('          </ul>\n') 
            cross.write('        </dd>\n')   

         # property prov:unqualifiedForm ?p
         if len(property.prov_unqualifiedForm) > 0:
            qname = property.prov_unqualifiedForm.first.subject.split('#')
            cross.write('\n')
            cross.write('      <dt>qualifies</dt>\n')
            cross.write('      <dd>\n')
            cross.write('        <a title="'+property.prov_unqualifiedForm.first.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a>\n')
            cross.write('      </dd>\n')

         cross.write('\n')
         cross.write('      </dl>\n')

         cross.write('    </div>\n') # e.g. <div class="description">
         cross.write('  </div>\n')   # e.g. <div id="wasGeneratedBy" class="entity">
         cross.write('\n')
      cross.write('</div>\n')        # e.g. <div id="prov-starting-point-owl-classes-crossreference"

      n = ''
      if category.lower()[0] in ['a','e','i,','o','u']:
         n = 'n'
      quals.write('<table class="qualified-forms">\n')
      quals.write('  <caption>Qualification Property and Involvement Class used to qualify a'+n+' '+category.capitalize()+' Property.</caption>\n')
      quals.write('  <tr>\n')
      qname = property.subject.split('#')
      quals.write('    <th>'+category.capitalize()+' Property</th>\n')
      quals.write('    <th>Qualification Property</th>\n')
      quals.write('    <th>Involvement Class</th>\n')
      quals.write('    <th>Object Property</th>\n')
      quals.write('  </tr>\n')
      for uri in ordered['properties']:
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
                     if   ( qname[1]  == 'EntityInvolvement' ):
                        objectProp = 'entity' 
                     elif ( qname[1]  == 'ActivityInvolvement' ):
                        objectProp = 'activity' 
                     elif ( qname[1]  == 'AgentInvolvement' ):
                        objectProp = 'agent' 
                     elif ( qname[1]  == 'CollectionInvolvement' ):
                        objectProp = 'collection' 
                     elif ( qname[1]  == 'DictionaryInvolvement' ):
                        objectProp = 'collection' 
               else:
                  if "qualified" in qualified.subject:
                     qualProp  = qualified                           # e.g. http://www.w3.org/ns/prov#qualifiedResponsibility
                  else:
                     qualProp = 'no' # Avoiding prov:startedAtTime, prov:atTime, prov:Start, null
            if qualProp != 'no' and qualClass != 'no' and objectProp != 'no':
               quals.write('  <tr>\n')
               qname = property.subject.split('#')
               quals.write('    <td><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')
               qname = qualProp.subject.split('#')
               quals.write('    <td><a title="'+qualProp.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')
               qname = qualClass.subject.split('#')
               quals.write('    <td><a title="'+qualClass.subject+'" href="#'+qname[1]+'" class="owlclass">'+PREFIX+':'+qname[1]+'</a></td>\n')
               quals.write('    <td><a title="'+qname[0]+'#'+objectProp+'" href="#'+objectProp+'" class="owlproperty">'+PREFIX+':'+objectProp+'</a></td>\n')
               quals.write('  </tr>\n')
      quals.write('</table>\n')

      glance.close()
      cross.close()
      quals.close()
   else:
      print '  '+glanceName + ' or ' + crossName + " already exists. Not modifying."


inversesName = 'inverse-names.html'
if not(os.path.exists(inversesName)):
   inverses = open(inversesName, 'w')
   inverses.write('<table class="inverse-names">\n')
   inverses.write('  <caption>Names of inverses</caption>\n')
   inverses.write('  <tr>\n')
   inverses.write('    <th>PROV-O Property</th>\n')
   inverses.write('    <th>Recommended inverse name</th>\n')
   inverses.write('  </tr>\n')
   for property in ObjectProperties.all():
      qname = property.subject.split('#')
      if property.prov_inverse:
         inverses.write('  <tr>\n')
         inverses.write('    <td><a title="'+property.subject+'" href="#'+qname[1]+'" class="owlproperty">'+PREFIX+':'+qname[1]+'</a></td>\n')
         inverses.write('    <td>prov:'+property.prov_inverse.first+'</td>\n')
         inverses.write('  </tr>\n')
   inverses.write('<table>\n')
   inverses.close()
