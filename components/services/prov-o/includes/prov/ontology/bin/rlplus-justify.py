#!/usr/bin/env python

# usage: java -jar bin/profilechecker.jar ProvenanceOntology.owl OWL2RLProfile 2>&1 | python bin/rlplus-justify.py

import sys

explain = {}

explain['Use of non-simple property in AsymmetricObjectProperty axiom: [AsymmetricObjectProperty(<http://www.w3.org/ns/prov#wasDerivedFrom>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in AsymmetricObjectProperty axiom: [AsymmetricObjectProperty(<http://www.w3.org/ns/prov#used>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in AsymmetricObjectProperty axiom: [AsymmetricObjectProperty(<http://www.w3.org/ns/prov#wasGeneratedBy>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in FunctionalObjectProperty axiom: [FunctionalObjectProperty(<http://www.w3.org/ns/prov#wasGeneratedBy>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in IrrefexiveObjectProperty axiom: [IrreflexiveObjectProperty(<http://www.w3.org/ns/prov#wasGeneratedBy>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in IrrefexiveObjectProperty axiom: [IrreflexiveObjectProperty(<http://www.w3.org/ns/prov#wasDerivedFrom>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-simple property in IrrefexiveObjectProperty axiom: [IrreflexiveObjectProperty(<http://www.w3.org/ns/prov#used>) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'OWL API Bug?'

explain['Use of non-superclass expression in position that requires a superclass expression: ObjectUnionOf(<http://www.w3.org/ns/prov#Association> <http://www.w3.org/ns/prov#End> <http://www.w3.org/ns/prov#Generation> <http://www.w3.org/ns/prov#Start> <http://www.w3.org/ns/prov#Usage>) [ObjectPropertyDomain(<http://www.w3.org/ns/prov#hadRole> ObjectUnionOf(<http://www.w3.org/ns/prov#Association> <http://www.w3.org/ns/prov#End> <http://www.w3.org/ns/prov#Generation> <http://www.w3.org/ns/prov#Start> <http://www.w3.org/ns/prov#Usage>)) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'hadRole'

explain['Use of non-superclass expression in position that requires a superclass expression: ObjectUnionOf(<http://www.w3.org/ns/prov#Derivation> <http://www.w3.org/ns/prov#Responsibility> <http://www.w3.org/ns/prov#Start>) [ObjectPropertyDomain(<http://www.w3.org/ns/prov#hadActivity> ObjectUnionOf(<http://www.w3.org/ns/prov#Derivation> <http://www.w3.org/ns/prov#Responsibility> <http://www.w3.org/ns/prov#Start>)) in <http://www.w3.org/ns/prov#><http://www.w3.org/TR/2012/WD-prov-o-2012MMDD>]'] = 'hadActivity'

print '<table>'
for line in sys.stdin:
   line = line.strip()
   if line in explain:
      if explain[line] is not 'OWL API Bug?':
         print '  <tr>'
         print '    <td>' + line.replace('http://www.w3.org/ns/prov#','prov:').replace('>','').replace('<','').replace('in .*$','') + '</td>'
         print '    <td>' + explain[line] + '</td>'
         print '  </tr>'
   else:
      print line
print '</table>'
