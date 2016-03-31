#!/bin/bash

if [ ! -f /.tomcat_admin_created ]; then
  /create_tomcat_admin_user.sh
fi

sed -i "/^dbType=.*/c\dbType=$OC_dbType" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^dbUser=.*/c\dbUser=$OC_dbUser" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^dbPass=.*/c\dbPass=$OC_dbPass" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^dbHost=.*/c\dbHost=$OC_dbHost" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^db=.*/c\db=$OC_db" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^dbPort=.*/c\dbPort=$OC_DB_PORT_5432_TCP_PORT" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^userAccountNotification=.*/c\userAccountNotification=$OC_userAccountNotification" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^# about\.text1=.*/c\about.text1= Powered by" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^# about\.text2=.*/c\about.text2= my-cdms.de" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^# supportURL=.*/c\supportURL=$OC_supportURL" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^collectStats=.*/c\collectStats=$OC_collectStats" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
sed -i "/^designerURL=.*/c\designerURL=" $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties
cp $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/datainfo.properties $CATALINA_HOME/webapps/OpenClinica-ws/WEB-INF/classes/

if [ -z "$LOG_LEVEL" ]; then
  echo "Using default log level."
else
  echo "org.apache.catalina.core.ContainerBase.[Catalina].level = $LOG_LEVEL" > $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].handlers = java.util.logging.ConsoleHandler" >> $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].level = $LOG_LEVEL" > $CATALINA_HOME/webapps/OpenClinica-ws/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].handlers = java.util.logging.ConsoleHandler" >> $CATALINA_HOME/webapps/OpenClinica-ws/WEB-INF/classes/logging.properties
fi  

exec ${CATALINA_HOME}/bin/catalina.sh run
