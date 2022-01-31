import groovy.json.JsonSlurper
pipeline {
	environment {
    	dburl="petclinic-server.mysql.database.azure.com"
    	dbusername="petclinic"
    	dbpassword="Groupe123"
        dockerImage = "petclinic-img"
        containerImage="petclinic"
        Url_registre = "petclinic4acr.azurecr.io"
        Url_sonarqube="http://192.168.1.101:9000"
        Sonar_login="admin"
        Sonar_password="samir"
        Acr_servername="petclinic4acr.azurecr.io"
        Acr_user="petclinic4acr"
        Acr_password="JdUC9htdPChYFutybvKSW=4v9eht90Dz"
        
	}
		
	
	agent none
	stages {	

			stage('cloner le repo') {
				 agent any
				 steps {
					git credentialsId: 'jenkins-ssh-github', url: 'git@github.com:samirerr/petclinic.git'
				 }
			}
			
			
			stage('Builder  l application') {
				 agent any
					steps {
						 script {
							 sh 'mvn clean deploy -DskipTests -Ddburl=$dburl -Ddbusername=$dbusername -Ddbpassword=$dbpassword'
							}
						}
			}
		
			stage('Analyse avec SonarQube') {
				 agent any
				 	steps {
		sh 'mvn sonar:sonar -Dsonar.host.url=$Url_sonarqube -Dsonar.login=$Sonar_login -Dsonar.password=$Sonar_password -Dsonar.java.binaries=**/*'
					    }
				 
			}
			
			stage('test de performance') {
				 agent any
					steps {
						 script {
							 sh'rm -rf /usr/share/nginx/html/jmeter/* resultats.jtl'
							 sh '/opt/apache-jmeter-5.4.3/bin/jmeter -n -t ./src/test/jmeter/petclinic_test_plan.jmx -l resultats.jtl -e -o /usr/share/nginx/html/jmeter'
							 sh 'cat resultats.jtl'
							 perfReport 'resultats.jtl'
							}
						}
			}
			
			stage('Builder  l image') {
				 agent any
					steps {
						 script {
							 sh 'docker build -t $dockerImage .'
							}
						}
			}
		
			stage('Demarrer  l image') {
				 agent any
					steps {
						 script {
							 sh 'docker run -d --rm -p 8082:8080 --name $containerImage $dockerImage:latest '
							 sh 'sleep 10'
							}
						}
			}
		
			
		
			stage("Tester la reponse httpRequest") {
				agent any
				    steps {
					script {
					    final String response = sh(script: "curl -s -o /dev/null -w '%{http_code}' localhost:8082", returnStdout: true).trim()
					    echo response
					    }
					}
			}
		
		    stage('pusher  l image') {
				 agent any
					steps {
						 script {
							
							 sh 'docker login petclinic4acr.azurecr.io -u petclinic4acr -p a9l4sblUfyUB+g9vekADvEVgrAnop2j7'
							 sh' docker tag $dockerImage $Url_registre/$dockerImage'
							sh 'docker push $Url_registre/$dockerImage'
						     
						     
						 }
						}
			}
			
			
			stage('Supprimer  l image') {
				 agent any
					steps {
						 script {
							 sh 'docker stop $containerImage'
							 sh 'docker rmi $dockerImage  '
							 sh 'docker rmi $Url_registre/$dockerImage '
							}
						}
			}
			
			
			stage('Deploiment automatique') {
				 agent any
					steps {
						 script {
							 sh 'az login --service-principal --username c71d3f77-6487-4147-b9c7-38a9c128dc6d --password r2Cgk~6BAfKANin65nLNRGTrbbeXaHgRew --tenant be8e3d88-370c-4c79-8b37-c4efc1f6a6ee'
							 sh 'az aks get-credentials --resource-group petclinic --name petclinic-aks --overwrite-existing'
							 sh '/usr/local/bin/kubectl apply -f aks'
							 sh 'rm -rf *'
					
							}
						}
			}
			
	}

 post {
       success {
         slackSend (color: '#00FF00', message: "SUCCES: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
         }
      failure {
            slackSend (color: '#FF0000', message: "ECHEC: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          }   
    }

}
