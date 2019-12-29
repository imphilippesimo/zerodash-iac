# IAC Platform
Docker Infra as code for services needed for zerodash project deployment

## Services           
Jenkins, Sonarqube, Mysql, Adminer, ElasticSearch, Logstash, Kibana, Redis 

## Deployment       
* Clone the project,      
* Get at the root and launch the services via the `docker-compose` utility:
`docker-compose up`


## Services configuration    
### Jenkins:

> Launching    

Once the jenkins container has started, access it via the url http://<jenkins_host_ip>:8081 , replace localhost by the host IP address.   
Then install the recommended plugins.    

> Global configuration for maven : 

This is done in order to allow jenkins to have access to a maven agent that it can use upon our apps maven builds.
Go to the homepage, click on `Manage Jenkins` then `Global Tool Configuration`;    
Scroll down till the Maven section, click on `Maven Installation` then `Add maven`,    
name it 'myMaven' since it is referenced by this name on the snapanonym projects jenkinsfiles,
Check `Install Automatically`. Don't forget to apply th changes at the end of the page at any time.

> Credential Configuation   

This is about defining the credentials to communicate with github in order to checkout code and the docker registry    
in order to push the artifacts at the end of each build.    

Get back to  the home page, in the main menu, click `Credentials`, click on the dropdown arrow left to the word global and select `add credentials`;    
Add 2 credentials with the following informations.

Docker credentials informations:    

Kind: username and password    
ID: `DockerhubCredentials`  : Important since it is used as is in snapanoym projects jenkinsfiles    
Description: `Docker Hub Credentials`    
Username: DockerHub ID    
password: DockerHub password        

Github Credentials informations:    

Kind: Username and password    
ID: `GitHubCredentials`    
Description: `Github Credentials`        
Username: Github account pseudo     
Password: Github account password       


> Pipeline Configuration

This section shows how to configure the jenkins pipelines for the zerodash projects:

**Backend**:    
Go to the home page:
`New Item` , enter a name, choose `Pipeline` in the list below the name, then click the OK button.    
In the **Build Triggers** section, check `GitHub hook trigger for GITScm polling` to let jenkins listen to new pushes on github and react accordingly.   
In the **Pipeline Script** section, select in the dropdown list `Pipeline script from SCM`, choose `Git` as the source control manager (SCM), enter the     
Enter the backend git repository URL, choose the GithubCedentials that we created earlier, add the `master` and `develop` branches as we want to trigger the pipeline each time someone pushes to one of these branches.
Then save the pipeline and it's done.

> Github webhook configuration


In order for github to push `push` events to jenkins, we must tell github where is jenkins situated by creating a webhook.    
In the Github project we want jenkins to listens, click `Setings` -> `Webhook` -> `Add webhook`    
Fill the Payload URL field with: http://<jenkins_host_ip>:8081/github-webhook/    
Choose `application/json` as Content type
Leave the remaining as they are then Validate. Github will send a test ping to the jenkins server, if everything is ok, then you will notice a green check preceeding your webhook.
  



