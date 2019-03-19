# k8s-webserver
https enables web server with easy deployment steps.

This web server is very easy deployment solution.

# Pre requieties
You should have installed kubectl (docker desktop with kubernetes) in your host machine.

You just have to change into deployment directory and exicute the deploy.sh file to start the system.

```cd deployment```
```sh deploy.sh```

Noy you have to provide the database name and the root user password for the system.
System will be created with following kubernetes pods.

1. webserver

2. database

you may check the created pods with following command

```kubectl get pods -n monitoring```
