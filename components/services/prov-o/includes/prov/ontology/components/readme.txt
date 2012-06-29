http://dvcs.w3.org/hg/prov/file/tip/ontology/components/readme.txt
about
http://dvcs.w3.org/hg/prov/file/tip/ontology/components/
--------------------------------------------------------------------------------------------------------------------------------------------
editor: Timothy Lebo (http://tw.rpi.edu/instances/TimLebo)






Note, this readme.txt has been replaced by the wiki page at http://www.w3.org/2011/prov/wiki/PROV_OWL_ontology_components.



The following text is not longer being maintained, but remains for historical reference. -tlebo 2011-10-04





== Introduction ==

This directory contains small components of OWL axioms that _can_ contribute to the PROV ontology [1], or any variant of the PROV ontology.

Note that the presence of an axiom as a component _does_not_ imply that it is a part of the authoritative OWL encoding [1] of PROV.

This collection of components exists to provide concrete encodings of proposals while the authoritative OWL encoding [1] is developed.

It also exists to facilitate others in constructing their own variants (i.e., extensions) of the authoritative PROV OWL encoding [1].

Thus, these components will likely be a SUPERSET of the authoritative OWL encoding [1], and may even be logically inconsistent if all are 
incorporated into a single OWL ontology.

== Class components ==

The following files describe some classes that can become part of the PROV ontology [1]:

* Controller.ttl       - describes the property http://www.w3.org/ns/prov-o/Controller
* ProcessExecution.ttl - describes the property http://www.w3.org/ns/prov-o/ProcessExecution

== Property components ==

The following files describe some properties that can become part of the PROV ontology [1]:

* assumedBy.ttl                - describes the property http://www.w3.org/ns/prov-o/assumedBy
* eventuallyUsed.ttl           - describes the property http://www.w3.org/ns/prov-o/eventuallyUsed
* generated.ttl                - describes the property http://www.w3.org/ns/prov-o/generated
* hasLocation.ttl              - describes the property http://www.w3.org/ns/prov-o/hasLocation
* used.ttl                     - describes the property http://www.w3.org/ns/prov-o/used
* wasComplementOf.ttl          - describes the property http://www.w3.org/ns/prov-o/wasComplementOf
* wasControlledBy.ttl          - describes the property http://www.w3.org/ns/prov-o/wasControlledBy
* wasEventuallyGeneratedBy.ttl - describes the property http://www.w3.org/ns/prov-o/wasEventuallyGeneratedBy
* wasGeneratedBy.ttl           - describes the property http://www.w3.org/ns/prov-o/wasGeneratedBy

== Example instance data for each component ==

While files in this directory (e.g. 'assumedBy.ttl') contain OWL axioms, dirctories (e.g. 'assumedBy/') are also created and named to 
correspond with the OWL axiom component file.

For example, assumedBy.ttl encodes 'prov:assumedBy rdfs:domain prov:Role',
while 'assumedBy/appending-a-file-to-itself.ttl' and 'assumedBy/khalid-restaurant.ttl'
provide examples of how the axioms are intended to be used.

== References ==

[1] http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/ProvenanceOntology.owl
