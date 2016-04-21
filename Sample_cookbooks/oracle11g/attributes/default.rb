# Oracle11g Attributes

default['oracle11g']['inventory_group'] = 'oinstall'

#oracle_password 
# openssl passwd -1 "oraclePasssw0rd"
default['oracle11g']['oracle_password'] = '$1$m7GbSBc8$mhujxZss72yupP8adkqEy.'
#grid_password
# openssl passwd -1 "gridPasssw0rd"
default['oracle11g']['grid_password'] = '$1$SOynRJ3b$xJsGQxOXgHdeIC.jM5LHk1'

# swap 
default['oracle11g']['swaplocation']	= '/oracle/swap'
default['oracle11g']['swapsize']	= 4096

# ASMlib Drivers 
default['oracle11g']['oracleasmlib']	= '/dimp/repo/application/Oracle/Oracle11/RPMs/oracleasmlib-2.0.4-1.el6.x86_64.rpm'
default['oracle11g']['oracleasm-support']	= '/dimp/repo/application/Oracle/Oracle11/RPMs/oracleasm-support-2.1.8-1.el6.x86_64.rpm'

# Kernel Parameters
default['oracle11g']['nofilemin']	= 1024
default['oracle11g']['nofilemax']	= 65536
default['oracle11g']['nprocmin']	= 2047
default['oracle11g']['nprocmax']	= 16384
default['oracle11g']['stackmin']	= 10240
default['oracle11g']['stackmax']	= 32768

# Oracle Install Parameters
default['oracle11g']['package1']	= '/dimp/repo/application/Oracle/Oracle11/p13390677_112040_Linux-x86-64_1of7.zip'
default['oracle11g']['package2']	= '/dimp/repo/application/Oracle/Oracle11/p13390677_112040_Linux-x86-64_2of7.zip'
default['oracle11g']['package3']	= '/dimp/repo/application/Oracle/Oracle11/p13390677_112040_Linux-x86-64_3of7.zip'
default['oracle11g']['extract-dir']	= '/oracle/database/install'
default['oracle11g']['orainvdir']	= '/oracle/database/oraInventory'

