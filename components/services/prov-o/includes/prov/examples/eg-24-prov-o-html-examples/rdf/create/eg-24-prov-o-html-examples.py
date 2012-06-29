#!/usr/bin/env python
# Timothy Lebo

# To install dependencies, see https://github.com/timrdf/DataFAQs/wiki/Errors

import sys
from surf import *

if len(sys.argv) != 2:
   print "usage: eg-24-prov-o-html-examples http://some.owl"
   print
   print "  http://some.owl      - web URL of the OWL e.g. http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl"
   sys.exit(1)

ont_url   = sys.argv[1] # http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl

# as SuRF
store = Store(reader='rdflib', writer='rdflib', rdflib_store = 'IOMemory')
session = Session(store)
store.load_triples(source=ont_url) # From URL
DatatypeProperties = session.get_class(ns.OWL["DatatypeProperty"])
ObjectProperties   = session.get_class(ns.OWL["ObjectProperty"])
Classes            = session.get_class(ns.OWL["Class"])

defaultExample = '''@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
@prefix owl:  <http://www.w3.org/2002/07/owl#> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix :     <http://example.com/> .

# TODO
'''

def handle(term,pre):
   qname = term.split('#')
   if qname[0] == 'http://www.w3.org/ns/prov':
      fileName = 'rdf/'+pre+qname[1]+'.ttl'
      if os.path.exists(fileName):
         print fileName + ': exists. Not modifying.'
      else:
         print fileName
         example = open(fileName, 'w')
         example.write(defaultExample)
         example.close()
   
for owlClass in Classes.all():
   handle(owlClass.subject,'class_')
for owlProperty in DatatypeProperties.all():
   handle(owlProperty.subject,'property_')
for owlProperty in ObjectProperties.all():
   handle(owlProperty.subject,'property_')
