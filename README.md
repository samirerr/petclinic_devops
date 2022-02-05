# petclinic
[![Build Status](http://samirer.freeboxos.fr:8080/buildStatus/icon?job=Petclinic-DC)](http://samirer.freeboxos.fr:8080/job/Petclinic-DC/)


# Exécution de l'application Petclinic localement
Petclinic est une application Spring Boot construite à l'aide de Maven. Vous pouvez créer un fichier war et l'exécuter à partir de la ligne de commande (cela devrait fonctionner aussi bien avec Java 8, 11 ou 17)

```
mvn clean deploy -DskipTests -Ddburl=$dburl -Ddbusername=$dbusername -Ddbpassword=$dbpassword
```
 

<a href=''><img src='https://github.com/samirerr/petclinic/blob/master/images/architecture.jpg?raw=true'></a>

# Architechture DevOps proposée


