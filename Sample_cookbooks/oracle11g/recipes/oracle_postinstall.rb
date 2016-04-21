orainv = node['oracle11g']['orainvdir']

bash "post_install" do
  user "root"
  code <<-EOH
  while true; do
    if tail -n10 #{orainv}/logs/installActions* | grep "INFO: Successfully executed the flow in SILENT mode" && tail -n10 #{orainv}/logs/installActions* | grep "INFO: Exit Status is 0"
       then
         echo "Oracle Installation is successful. Running Post Installation scripts"
         /bin/sh /oracle/database/oraInventory/orainstRoot.sh
         /bin/sh /oracle/database/oracle/product/11.2.0/dbhome_1/root.sh
         exit 0
    elif tail -n10 #{orainv}/logs/installActions* | grep "Exit Status is [1-9]\{1\}"
    then
      echo "Oracle installation is failed... Dead Meat !!!!!!"
      exit 111
     else
       echo "Waiting for completion of oracle execution ...."
       sleep 60
    fi
  done
  EOH
end
