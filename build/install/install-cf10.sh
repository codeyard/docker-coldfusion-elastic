#!/bin/sh
#
# Script based on https://forums.adobe.com/message/4727551

/tmp/ColdFusion_10_WWEJ_linux64.bin -f installer.profile

# Disable admin security
/tmp/neo-security-config.sh /opt/coldfusion10/cfusion false

# Start up the CF server instance and wait for a moment
/opt/coldfusion10/cfusion/bin/coldfusion start; sleep 15

# Simulate a browser request on the admin UI to complete installation
curl -L --silent http://localhost:8500/CFIDE/administrator/index.cfm?configServer=true

# Stop the CF server instance
/opt/coldfusion10/cfusion/bin/coldfusion stop

# Re-enable admin security
/tmp/neo-security-config.sh /opt/coldfusion10/cfusion true

#apply mandatory hotfix
java -jar /tmp/cf10_mdt_updt.jar -i silent

#apply hotfix 23
java -jar /tmp/hotfix_023.jar -i silent

# Configure Apache2 to run in front of Tomcat
/opt/coldfusion10/cfusion/runtime/bin/wsconfig -ws Apache -dir /etc/apache2/ -bin /usr/sbin/apache2ctl -script /etc/init.d/apache2

# Backup ColdFusion Config Files
mv /opt/coldfusion10/cfusion/bin/jvm.config /opt/coldfusion10/cfusion/bin/jvm.bak
mv /opt/coldfusion10/cfusion/lib/neo-datasource.xml /opt/coldfusion10/cfusion/lib/neo-datasource.bak
mv /opt/coldfusion10/cfusion/lib/neo-debug.xml /opt/coldfusion10/cfusion/lib/neo-debug.bak
mv /opt/coldfusion10/cfusion/lib/neo-mail.xml /opt/coldfusion10/cfusion/lib/neo-mail.bak
mv /opt/coldfusion10/cfusion/lib/neo-monitoring.xml /opt/coldfusion10/cfusion/lib/neo-monitoring.bak
mv /opt/coldfusion10/cfusion/lib/neo-runtime.xml /opt/coldfusion10/cfusion/lib/neo-runtime.bak
mv /opt/coldfusion10/cfusion/lib/neo-websocket.xml /opt/coldfusion10/cfusion/lib/neo-websocket.bak

# Apply ColdFusion Config Files
mv /tmp/jvm.config /opt/coldfusion10/cfusion/bin/jvm.config
mv /tmp/neo-datasource.xml /opt/coldfusion10/cfusion/lib/neo-datasource.xml
mv /tmp/neo-debug.xml /opt/coldfusion10/cfusion/lib/neo-debug.xml
mv /tmp/neo-mail.xml /opt/coldfusion10/cfusion/lib/neo-mail.xml
mv /tmp/neo-monitoring.xml /opt/coldfusion10/cfusion/lib/neo-monitoring.xml
mv /tmp/neo-runtime.xml /opt/coldfusion10/cfusion/lib/neo-runtime.xml
mv /tmp/neo-websocket.xml /opt/coldfusion10/cfusion/lib/neo-websocket.xml