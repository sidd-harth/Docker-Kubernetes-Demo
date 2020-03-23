docker run --name mysqlservice -e MYSQL_ROOT_PASSWORD=hcl -e MYSQL_USER=hcl -e MYSQL_PASSWORD=hcl -e MYSQL_DATABASE=hcldemo -d mysql:5.7

docker logs -f ae

docker exec -it ae bash
mysql -uroot -proot


docker run -d   -e MYSQL_ROOT_PASSWORD=my-secret-pw   -v /r/devops-dba/mysql-data:/var/lib/mysql   --name mysqlserver   mysql:5.7

docker run --link mysqlservice:mysql -p 1111:9099 -it employees:v1
docker commit -m "running in dev" springboot-mysql siddharth67/springboot-mysql:latest


kubectl create deployment demo --image=siddharth67/springboot-mysql:secret --dry-run -o=yaml > deployment.yaml

kubectl create service clusterip demo --tcp=8080:8080 --dry-run -o=yaml >> deployment.yaml

kubectl create secret generic mysql-secrets \
--from-literal=password=hcl \
--from-literal=username=hcl \
--from-literal=root-password=hcl 

kubectl create configmap mysql-config \
--from-literal=database=hcldemo \
--from-literal=port=3306 \
--from-literal=host=mysql-service 



docker run --name ganesh-mysql-v35 \
-v /r/devops-dba/mysql-data-dir:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=mypasswd -d mysql:5.7



docker run --name ganesh-mysql-www -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypasswd -d mysql:latest


minikube start --vm-driver hyperv --hyperv-virtual-switch "Kube Virtual Switch" --memory 5120

 kubectl cluster-info

 kubectl get nodes
kubectl describe node
kubectl proxy

minikube addons enable metrics-server

 //kubectl autoscale rs employees-app-79485446f6 --min=2 --max=3 --cpu-percent=10
 kubectl autoscale deployment employee-app --cpu-percent=1 --min=1 --max=3

   while true; do  curl -s http://192.168.0.17:31003/api/employees  | grep --color -E 'employees-app|$' ; sleep .1; done

    while true; do  curl -s http://192.168.0.17:31003/api/pod; sleep .5; done




INSERT INTO employees (id,name,city) VALUES (100,"Todd","Pointe-aux-Trembles"),(101,"Avram","Maglie"),(102,"Medge","Naninne"),(103,"Hadley","Lourdes"),(104,"Melodie","Vandoeuvre-lès-Nancy"),(105,"Brittany","Nemi"),(106,"Rahim","Montignoso"),(107,"Dean","Naro"),(108,"Addison","Sorgà"),(109,"Jordan","Appelterre-Eichem"),(110,"Joel","Kakisa"),(111,"Asher","Haren"),(112,"Ila","Muzaffargarh"),(113,"Griffith","Perth"),(114,"Lenore","Aizwal"),(115,"Shafira","Toltén"),(116,"Brandon","Moncton"),(117,"Damian","Morpeth"),(118,"Larissa","Créteil"),(119,"Olympia","Neuruppin"),(120,"Maxine","Castanhal"),(121,"Martha","Akron"),(122,"Nerea","Kanchipuram"),(123,"Eve","Chemnitz"),(124,"Berk","Tehuacán"),(125,"Honorato","Chaitén"),(126,"Lacey","Acoz"),(127,"John","Slough"),(128,"Anne","Montebello"),(129,"Brenden","Tiegem"),(130,"Jorden","Lanco"),(131,"Ora","Outremont"),(132,"Silas","Billings"),(133,"Naomi","South Portland"),(134,"Amal","Shrewsbury"),(135,"Kyra","Fogo"),(136,"Samuel","Vorselaar"),(137,"Felicia","Sakhalin"),(138,"Ginger","Couillet"),(139,"Troy","Panguipulli"),(140,"Ferdinand","Miass"),(141,"Odette","Dumai"),(142,"Elton","Devonport"),(143,"Nadine","Giustino"),(144,"Camden","Newmarket"),(145,"Elmo","Mathura"),(146,"Quin","Namyangju"),(147,"Raja","Neustrelitz"),(148,"Lila","Loreto"),(149,"Rebecca","Wolfsburg"),(150,"Noelle","Batu"),(151,"Athena","Parla"),(152,"Galena","Ensenada"),(153,"Vance","Blankenberge"),(154,"Quinn","Momignies"),(155,"Grace","Fontenoille"),(156,"Liberty","Chapra"),(157,"Keegan","Noisy-le-Grand"),(158,"Willa","Dro"),(159,"Natalie","Buzenol"),(160,"Helen","Leernes"),(161,"Alfonso","Morro Reatino"),(162,"Blythe","Padre las Casas"),(163,"Walter","Hartford"),(164,"Susan","Baie-Comeau"),(165,"Cleo","Koningshooikt"),(166,"Blossom","Badalona"),(167,"Geoffrey","Tarragona"),(168,"Zeph","Yamuna Nagar"),(169,"Whoopi","Miass"),(170,"Sigourney","Cannock"),(171,"Reuben","Xhoris"),(172,"Jenna","Kester"),(173,"Addison","Heusden"),(174,"Hilel","Fort Simpson"),(175,"Stella","Washuk"),(176,"Phyllis","North Dum Dum"),(177,"Allistair","Coutisse"),(178,"Alfonso","Épernay"),(179,"Paula","West Jordan"),(180,"Martena","San Vito Chietino"),(181,"Carla","Losino-Petrovsky"),(182,"Sydnee","Barrhead"),(183,"Kyla","Cisterna di Latina"),(184,"Melissa","Aberystwyth"),(185,"Ainsley","Nelson"),(186,"Wyatt","Lanklaar"),(187,"Cheyenne","Vanderhoof"),(188,"Leila","Weyburn"),(189,"Ashely","Markham"),(190,"Veronica","Floreffe"),(191,"Chaney","Navsari"),(192,"Keiko","Calera"),(193,"Calista","Dorval"),(194,"Cairo","Bottrop"),(195,"Darius","Gudivada"),(196,"Melissa","Ulyanovsk"),(197,"Zephr","Lompret"),(198,"Erin","Redwater"),(199,"Basia","Moffat");


 env:
          - name: KUBE_USERNAME
            valueFrom:
              secretKeyRef:
                name: mysql-secrets
                key: username
          - name: KUBE_PASSWORD
            valueFrom:
              secretKeyRef:
                name: mysql-secrets
                key: password
          - name: KUBE_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: mysql-secrets
                key: root-password
          - name: KUBE_URL
            valueFrom:
              secretKeyRef:
                name: mysql-secrets
                key: url
          - name: CONFIGMAP_PORT
           	valueFrom:
	            configMapKeyRef:
	              name: mysql-config
	              key: port
	      - name: CONFIGMAP_DDL
	        valueFrom:
	            configMapKeyRef:
	              name: mysql-config
	              key: ddl
        ports:
        - containerPort: 3306
          name: mysql