#!/bin/bash


set -e

ECHO=`which echo`
KUBECTL=`which kubectl`

# methods

# color refference
#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

# Creating The Banner
#Colours
red="\033[00;31m"
RED="\033[01;31m"

green="\033[00;32m"
GREEN="\033[01;32m"

brown="\033[00;33m"
YELLOW="\033[01;33m"

blue="\033[00;34m"
BLUE="\033[01;34m"

purple="\033[00;35m"
PURPLE="\033[01;35m"

cyan="\033[00;36m"
CYAN="\033[01;36m"

white="\033[00;37m"
WHITE="\033[01;37m"

WHITECHAR="\033[01;39m"

NC="\033[00m"
BOLD="\e[1m"
NRM="\e[0m"

echo "${RED}******************************************************************************"
echo "${WHITE}**                                                                          **"
echo "${WHITECHAR}**          POWERED BY LANKA SOFTWARE FOUNDATION  (LSF)                     **"
echo "${WHITE}**                                                                          **"
echo "${RED}******************************************************************************"

#   Add follwing tag after command for ignoring stdout, errors etc
#   > /dev/null throw away stdout
#   1> /dev/null throw away stdout
#   2> /dev/null throw away stderr
#   &> /dev/null throw away both stdout and stderr


# method to print bold
function echoBold () {
    ${ECHO} $'\e[1m'"${1}"$'\e[0m'
}

# method to print red bold fonts 
function echoRedBold () {
    #    .---------- constant part!
    #    vvvv vvvv-- the code from above
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    BD='\e[1m' # bold
    NM='\e[0m' # normal size
    RDBD='\033[0;31m\e[1m' # red and bold
    RDNM='\e[0m\033[0m' # normal color and normal size
    #printf "* ${BD}${RED}-${1} ${NC}${NM}\n"
    #${ECHO} ${RED}${1}
    printf "* ${RDBD}-${1} ${RDNM}\n"
    
}

# method to print red bold fonts 
function echoGreenBold () {
    #    .---------- constant part!
    #    vvvv vvvv-- the code from above
    RED='\033[0;32m' # green
    NC='\033[0m' # No Color
    BD='\e[1m' # bold
    NM='\e[0m' # normal size
    RDBD='\033[0;32m\e[1m' # green and bold
    RDNM='\e[0m\033[0m' # normal color and normal size
    #printf "* ${BD}${RED}-${1} ${NC}${NM}\n"
    #${ECHO} ${RED}${1}
    printf "* ${RDBD}-${1} ${RDNM}\n"
    
}

echoGreenBold 'Deploying Copper Email Server...'

# Creating the k8s namespace
kubectl create namespace copper 2> /dev/null || true
echoGreenBold 'Copper namespace created...'

############## START OF CONFIGURATION #############################

echoGreenBold 'Please Submit your Input data carefully...'

# Ask the user for their name
# echo Hello, who am I talking to?
# read varname
# echo "It's nice to meet you $varname" >> anu.txt
# echo What is your age?
# read age
# echo "Your age: $age" >> anu.txt
#echo " " > secret.yaml ## inset to file
echo "apiVersion: v1" > secret.yaml # this will clear all previous content in the file
echo "kind: Secret" >> secret.yaml
echo "metadata:" >> secret.yaml
echo "    name: my-secret" >> secret.yaml
echo "    namespace: monitoring" >> secret.yaml
echo "type: Opaque" >> secret.yaml
echo "stringData:" >> secret.yaml

#echo Enter mysql server host name: 
#read mysql_host
echo "    MYSQL_HOST: mysql" >> secret.yaml
echo Enter mysql database name: 
read mysql_db
echo "    MYSQL_DATABASE: $mysql_db" >> secret.yaml
#echo Enter mysql database user: 
#read mysql_user
echo "    MYSQL_USER: root" >> secret.yaml
echo Enter mysql database password: 
read mysql_db_pwd
echo "    MYSQL_PASSWORD: $mysql_db_pwd" >> secret.yaml


# Now Create the configuration secrets

echoGreenBold 'Configuration goint to be created...'
kubectl create -f secret.yaml 2> /dev/null || true
echoGreenBold 'Secret configuration files Created...'





######### END OF CONFIGURATION #############################################

# checking cert file list
# - cert.pem
# - fullchain.pem
# - privkey.key
# - dhparam.pem

# checking the cert.pem files exists
file="../tls/cert.pem"
if [ ! -f "$file" ]
then
    echoRedBold "$0: cert.pem file '${file}' not found in tls directory. !"
    exit 3 
fi

# checking the privkey.key files exists
file="../tls/privkey.pem"
if [ ! -f "$file" ]
then
    echoRedBold "$0: privkey.pem file '${file}' not found in tls directory. !"
    exit 3 
fi

# checking the dhparam.pem files exists
file="../tls/dhparam.pem"
if [ ! -f "$file" ]
then
    echoRedBold "$0: dhparam.pem file '${file}' not found in tls directory. !"
    exit 3 
fi

# checking the fullchain.pem files exists
#file="../tls/fullchain.pem"
#if [ ! -f "$file" ]
#then
#    echoRedBold "$0: fullchain.pem file '${file}' not found in tls directory. !"
#    exit 3 
#fi

echoGreenBold 'Certificate files are avaialbe in the tls folder'


# -------------------------------------


read -r -p "You are going to install copper Email. You should have coppied your certificate and key files to tls folder. Are you ready? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])

# changing to parent directory
cd ..

# Deployment mysql creation

kubectl create -f mysql/mysql-pv.yaml 2> /dev/null || true
kubectl create -f mysql/mysql-deployment.yaml 2> /dev/null || true
echoGreenBold 'mysql database created...'



# Creating the namespace
cd webserver
docker build -t webserver .
cd ..
echoGreenBold 'webmail image created...'
kubectl create namespace monitoring 2> /dev/null || true
echoGreenBold 'namespace monitoring created...'

# Creating the web server
kubectl create -f webserver/webserver.yaml 2> /dev/null || true
echoGreenBold 'Webserver created...'




#kubectl create -f webserver/webmail.yaml

#Deleting

#kubectl delete service webmail -n monitoring

#kubectl delete deployment webmail  -n monitoring


#kubectl delete pods webmail-cb6bfc8d-wtcxv -n monitoring





# wait 1 seconds 
sleep 1s

#use for service starting in all email pods
# https://stackoverflow.com/questions/51026174/running-a-command-on-all-kubernetes-pods-of-a-service

echoGreenBold ' ########################################## Installation completed #######################################'
#echoGreenBold ' Please import ldap.ldif file to import a test user for testing perposes from https://localhost:4433/ url.'
echoGreenBold ' Contact support@copper.opensource.lk for further assistance. ############################################'
#sleep 5s

#kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -n copper -- mysql -h mysql -pc0pperDB


     ;;
    *)
        echoRedBold "Deployment cancelled"
        ;;
esac

