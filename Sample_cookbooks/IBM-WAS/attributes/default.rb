# IBM_WAS installation parameters

default['ibm-was']['package1'] = '/dimp/repo/application/IBM-WAS/WAS_ND_V8.5.5_1_OF_3.zip'
default['ibm-was']['package2'] = '/dimp/repo/application/IBM-WAS/WAS_ND_V8.5.5_2_OF_3.zip'
default['ibm-was']['package3'] = '/dimp/repo/application/IBM-WAS/WAS_ND_V8.5.5_3_OF_3.zip'
default['ibm-was']['extract-dir'] = '/opt/was-installer'
default['ibm-was']['bin'] = '/opt/IBM/WebSphere/AppServer/bin/wasadmin.sh'
default['ibm-im']['path'] = '/opt/IBM/InstallationManager/eclipse/tools'
#default['ibm-was']['path'] = '/opt/IBM/WebSphere'
default['ibm-was']['app'] = '/opt/IBM/WebSphere/AppServer/bin'
default['ibm-ihs']['extract-dir'] = '/opt/ihs-installer'
default['ibm-was']['start'] = '/opt/profiles/AppSrv01/bin'
default['ibm-was']['plugin'] = '/opt/IBM/WebSphere/Toolbox/WCT'

# IBM_WAS Fixpack installation parameters

default['ibm_was_fp']['package1'] = '/dimp/repo/application/IBM-WAS/fixpacks/8.5.5-WS-WAS-FP0000002-part1.zip'
default['ibm_was_fp']['package2'] = '/dimp/repo/application/IBM-WAS/fixpacks/8.5.5-WS-WAS-FP0000002-part2.zip'
default['ibm_was_fp']['extract'] = '/opt/was-installer/fixpack'

# IBM_WAS Toolbox fixpack installation parameters

default['ibm_was_toolbox_fp']['package1'] = '/dimp/repo/application/IBM-WAS/fixpacks/8.5.5-WS-WCT-FP0000002-part1.zip'
default['ibm_was_toolbox_fp']['package2'] = '/dimp/repo/application/IBM-WAS/fixpacks/8.5.5-WS-WCT-FP0000002-part2.zip'
default['ibm_was_toolbox_fp']['extract'] = '/opt/was-installer/toolbox_fixpack'

#IBM_WAS plugin Fixpack Installation parametrs

default['ibm_ihs_fp']['package1'] = '/dimp/repo/application/IBM-IHS/fixpacks/8.5.5-WS-WASSupplements-FP0000002-part1.zip'
default['ibm_ihs_fp']['package2'] = '/dimp/repo/application/IBM-IHS/fixpacks/8.5.5-WS-WASSupplements-FP0000002-part2.zip'
default['ibm_ihs_fp']['extract'] = '/opt/ihs-installer/fixpack'

# IBM_WAS Cluster configuration

default['dmgr']['profile'] = '/opt/IBM/WebSphere/AppServer/bin'
default['dmgr']['start'] = '/opt/IBM/profiles/Dmgr01/bin'
default['custom']['profile'] = '/opt/IBM/WebSphere/AppServer/bin'
default['federate']['node1'] = '/opt/IBM/profiles/Custom01/bin'

default['federate']['node2'] = '/opt/IBM/profiles/Custom02/bin'
