#!/bin/bash


# methods

set -e

ECHO=`which echo`
KUBECTL=`which kubectl`

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

echo  "${RED}******************************************************************************"
echo  "${WHITE}**                                                                          **"
echo  "${WHITECHAR}**                                                                          **"
echo  "${WHITE}**               Please share your experinace with us                       **"
echo  "${WHITE}**               Email : tharanga.rajapaksha@gmail.com                      **"
echo  "${RED}******************************************************************************"
echo


echoRedBold ' !!!!!!!! -Undeploying Copper Email Server - !!!!!!!! '



read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])


#Deleting webmail

kubectl delete service webserver -n monitoring

kubectl delete deployment webserver -n monitoring

# if you dont want the docker image activate it
#docker -rmi webserver

echoGreenBold 'Webserver deleted...'

# Deleting the database

#deleting the secret
echoRedBold 'secret configurations goint to be deleted...'
kubectl delete secret my-secret -n monitoring 2> /dev/null || true
echoRedBold 'Secret configuration files deleted..'

## deleting namespace
kubectl delete namespace monitoring  2> /dev/null || true
echoRedBold "k8s namespace deleted"

echoGreenBold 'Finished'

    ;;
    *)
        echoRedBold "Undeploying cancelled"
        ;;
esac