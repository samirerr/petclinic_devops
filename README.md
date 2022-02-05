# petclinic



# Exécution de l'application Petclinic localement
Petclinic est une application Spring Boot construite à l'aide de Maven. Vous pouvez créer un fichier war et l'exécuter à partir de la ligne de commande (cela devrait fonctionner aussi bien avec Java 8, 11 ou 17)

```
mvn clean deploy -DskipTests -Ddburl=$dburl -Ddbusername=$dbusername -Ddbpassword=$dbpassword
```
 
<a href=''><img src='https://github.com/samirerr/petclinic/blob/master/images/appli_petclinic.png?raw=true'></a>


# Architechture DevOps proposée

<a href=''><img src='https://github.com/samirerr/petclinic/blob/master/images/architecture.jpg?raw=true'></a>


# Deploiement de ressources Azure avec Terraform

```
terraform init
terraform plan -out main.tfplan
terraform apply main.tfplan
```

# Installation et configuration des outils avec Ansible
```
ansible-playbook playbook.ymk -K
```

# Slack
<a href=''><img src='https://github.com/samirerr/petclinic/blob/master/images/screen-slack.jpg?raw=true'></a>

# Tableau Kanban
<a href=''><img src='https://github.com/samirerr/petclinic_devops/blob/master/images/tableau_kanban.jpg?raw=true'></a>
