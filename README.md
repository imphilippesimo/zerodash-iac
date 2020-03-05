# IAC Platform with kubernetes
Kubernetes Infra as code for services needed for zerodash project deployment

## Services           
Jenkins, Mysql, dashboard.

{ElasticSearch, Logstash, Kibana, Sonarqube} : Later 


## Deployment
###Prerequisites

We suppose you already have a access to a running kubernetes cluster
Make sure you have installed locally Kubectl and that it's connected to your cluster

Clone the project and open a terminal at the project's root

###Installing jenkins

`cd jenkins && ./init.sh`

The init script will install jenkins and give him the right
 permissions to create elements in the cluster.       

***Jenkins configuration:***

 *Launching Jenkins*    

    
> NOTE: It may take a few minutes for the Load balancer IP to be available.
> You can watch the status of by running :
>
>`kubectl get svc --namespace default -w chilling-jenkins`

>Get your 'admin' user password by running:
>
>
 `printf $(kubectl get secret --namespace default chilling-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo`

> Get the Jenkins URL to visit by running these commands in the same shell:
>
>
  `export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services chilling-jenkins)`
  
  
  `export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")`
  
  
  `echo http://$NODE_IP:$NODE_PORT/login`
  
Your NODE_IP should be a public address, otherwise get your node ip from your provider web interface 
> Login with the password from step 1 and the username: admin

> Note do not forget to open the corresponding ports on your hosts

*Credential Configuration*   

This is about defining the credentials to communicate with github in order to checkout code and the docker registry    
in order to push the artifacts at the end of each build.    

Get back to  the home page, in the main menu, click `Credentials`, 
click on the dropdown arrow left to the word global and select `add credentials`;    
Add 2 credentials with the following informations.

Docker credentials informations:    

Kind: username and password    
ID: `DockerHubCredentials`  : Important since it is used as is in snapanoym projects jenkinsfiles    
Description: `Docker Hub Credentials`    
Username: DockerHub ID    
password: DockerHub password        

Github Credentials informations:    

Kind: Username and password    
ID: `GitHubCredentials`    
Description: `Github Credentials`        
Username: Github account pseudo     
Password: Github account password       


*Pipeline Configuration*

This section shows how to configure the project jenkins pipeline :
  
Go to the home page:
`New Item` , enter a name, choose `Pipeline` in the list below the name, then click the OK button.    
In the **Build Triggers** section, check `GitHub hook trigger for GITScm polling` to let jenkins listen to new pushes on github and react accordingly.   
In the **Pipeline Script** section, select in the dropdown list `Pipeline script from SCM`, choose `Git` as the source control manager (SCM), enter the     
Enter the backend git repository URL, choose the GithubCredentials that we created earlier, add the `master` and `develop` branches as we want to trigger the pipeline each time someone pushes to one of these branches.
Then save the pipeline and it's done.

***Github webhook configuration***


In order for github to push `push` events to jenkins, we must tell github where is jenkins situated by creating a webhook.    
In the Github project we want jenkins to listens, click `Setings` -> `Webhook` -> `Add webhook`    
Fill the Payload URL field with: http://<jenkins_host_ip>:<jenkins_port>/github-webhook/    
Choose `application/json` as Content type
Leave the remaining as they are then Validate. Github will send a test ping to the jenkins server, if everything is ok, then you will notice a green check preceeding your webhook.
  

#Installing mysql

Edit the file mysql/init.sh and replace the credentials with your own
Then
`./init.sh` to install mysql service

* get mysql URL and port  to visit by running these commands

 `MYSQL_HOST=$(kubectl get nodes --namespace default -o jsonpath='{.items[0].status.addresses[1].address}')`
 
 
`MYSQL_PORT=$(kubectl get svc --namespace default smiling-mysql -o jsonpath='{.spec.ports[0].nodePort}')` 


 
#Kubernetes dashboard config

[Use this documentation](https://docs.ovh.com/gb/en/kubernetes/installing-kubernetes-dashboard/)





