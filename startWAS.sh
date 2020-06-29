#!/bin/bash
envlayer=$1
envnum=$2
project=$3
was_base_dir="/opt/IBM/WebSphere"
install_path="${was_base_dir}/AppServer"
full_was_profile_name="${envlayer}${envnum}WSPF-${project}"
cell_name="${envlayer}${envnum}WSCE-${project}"
node_name="${envlayer}${envnum}WSND-${project}"
host_name="$(cat /etc/hostname)"
template_path="${install_path}/profileTemplates/default"
admin_template_path="${install_path}/profileTemplates/management"

${install_path}/bin/manageprofiles.sh -create -profileName ${full_was_profile_name} -profilePath ${was_base_dir}/profiles/${full_was_profile_name} -templatePath ${template_path} -serverName example_server -cellName ${cell_name} -nodeName ${node_name} -hostName ${host_name}
${install_path}/bin/manageprofiles.sh -create -profileName adminagent -profilePath ${was_base_dir}/profiles/adminagent -templatePath ${admin_template_path} -serverType ADMIN_AGENT -nodeName adminagent  -serverName adminagent -hostName ${host_name} 
${was_base_dir}/profiles/adminagent/bin/startServer.sh adminagent

${was_base_dir}/profiles/adminagent/bin/registerNode.sh -profilePath ${was_base_dir}/profiles/${full_was_profile_name} -host ${host_name}  -conntype SOAP  -port 8877 -name adminagent

${was_base_dir}/profiles/adminagent/bin/stopServer.sh adminagent
${was_base_dir}/profiles/adminagent/bin/startServer.sh adminagent

/usr/sbin/sshd -D
