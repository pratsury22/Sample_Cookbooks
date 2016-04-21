#IHS Installation parameters

default['ibm-ihs']['package1'] = '/dimp/repo/application/IBM-IHS/WAS_V8.5.5_SUPPL_1_OF_3.zip'
default['ibm-ihs']['package2'] = '/dimp/repo/application/IBM-IHS/WAS_V8.5.5_SUPPL_2_OF_3.zip'
default['ibm-ihs']['package3'] = '/dimp/repo/application/IBM-IHS/WAS_V8.5.5_SUPPL_3_OF_3.zip'
default['ibm-ihs']['extract-dir'] = '/opt/ihs-installer'
default['ibm-ihs']['bin'] = '/opt/ibm/HTTPServer/properties/version/IHS.product'
default['ibm-im']['path'] = '/opt/IBM/InstallationManager/eclipse/tools'
#default['ibm-ihs']['path'] = '/opt/IBM/HTTPServer'
default['ibm-ihs']['start'] = '/opt/IBM/HTTPServer/bin'

#IHS Fixpack Installation parametrs

default['ibm_ihs_fp']['package1'] = '/dimp/repo/application/IBM-IHS/fixpacks/8.5.5-WS-WASSupplements-FP0000002-part1.zip'
default['ibm_ihs_fp']['package2'] = '/dimp/repo/application/IBM-IHS/fixpacks/8.5.5-WS-WASSupplements-FP0000002-part2.zip'
default['ibm_ihs_fp']['extract'] = '/opt/ihs-installer/fixpack'
