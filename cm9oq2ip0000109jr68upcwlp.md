---
title: "DevOps CI/CD-Pipeline"
datePublished: Sat Apr 19 2025 21:20:26 GMT+0000 (Coordinated Universal Time)
cuid: cm9oq2ip0000109jr68upcwlp
slug: devops-cicd-pipeline
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1745089608143/5e14031c-6a26-4d89-9ff1-b9e2cf811669.png
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1745097594133/a8c4c3aa-d5cb-48b4-a6f0-f5f7cb735527.png
tags: docker, aws, sonarqube, jenkins, ci-cd, devops-articles

---

**Kurze Projektbeschreibung:**  
Ich möchte mein neues Projekt vorstellen, bei dem meine Website auf einem Docker-Server bereitgestellt wird. Die verwendeten Ressourcen für dieses Projekt sind:

* **VSCode**, um mein Repository von GitHub zu klonen
    
* **GitHub-Webhooks** für automatische Trigger
    
* **AWS-Instanzen** für die Server:
    
    * **Jenkins** zur Automatisierung der Pipeline
        
    * **SonarQube** zur Überprüfung des Codes auf Sicherheitslücken
        
    * **Docker** zur Bereitstellung der Website
        

Um einen sicheren Zugriff auf die Website über den Browser zu ermöglichen, habe ich ein **SSL-Zertifikat** im **AWS Certificate Manager** erstellt und einen **CNAME-Eintrag** in **AWS Route 53** eingerichtet. Außerdem habe ich eine **CloudFront-Distribution** mit einem **A-Eintrag** erstellt, um den Datenverkehr an meinen Docker-Server mit installierter **Nginx-Anwendung** weiterzuleiten.

Dieses Projekt ist eine **CI/CD-Pipeline**, die meine Website mithilfe einer automatisierten Pipeline in Docker ausführt und den Zugriff über **HTTPS** ermöglicht.

## 📌 Schritte zur Umsetzung

1. Ich habe **drei Ubuntu T2.medium Instanzen** auf AWS erstellt für:
    
    * Jenkins-Server
        
    * SonarQube-Server
        
    * Docker-Server ↓
        
    * ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745095971064/e793e073-768c-4ffe-a988-52c59399dd46.png align="center")
        
2. Ich habe mich über das Terminal mit den Servern verbunden und deren **Hostnamen entsprechend angepasst mit Commando hostnamectl set-hostname &lt;Server Name&gt;**. ↓
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745096057971/eb0d60df-b0d7-4a09-ae6a-0119af921602.png align="center")
    
3. In **GitHub** habe ich ein Repository erstellt und mit **VSCode** mein Repository geklont.  
    Dort habe ich **HTML- und CSS-Dateien sowie eine Dockerfile** geschrieben und alles in das Repository gepusht:  
    👉 [GitHub Repository – website-jenkins-docker](https://github.com/Mahmoodi1984/website-jenkins-docker.git)
    
4. Ich habe in **GitHub Webhooks** eingerichtet, um **automatisch Änderungen im Repository** über die Jenkins-Pipeline zu triggern.
    
5. Ich habe auf meinen **Jenkins-Server über den Browser** zugegriffen, die benötigten Plugins wie **Docker** und **SonarScanner** installiert und anschließend eine **Pipeline erstellt**, die automatisch auf Änderungen im GitHub-Repository reagiert.
    
6. In **SonarQube** habe ich ein Projekt mit dem Namen `website-jenkins-docker` erstellt.  
    Nach dem Erstellen eines **Tokens für Jenkins** habe ich die **IP-Adresse und den Token** des SonarQube-Servers in Jenkins integriert. ↓↓
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745096642228/2ec022c6-a9a2-44c7-adc7-447ef647e2af.png align="center")
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745096768117/75eba860-92bf-475e-ab39-6aef8744d97c.png align="center")
    
7. Nach einer erfolgreichen Analyse durch SonarQube habe ich den **Docker-Server in die Jenkins-Pipeline** integriert.
    
      
    Über den **SSH-Agent** wurde das Projekt `website-jenkins-docker` auf dem Docker-Server ausgeführt, und **Nginx** wurde dort installiert.
    
8. Ich konnte meine Website im **Browser über** [**localhost**](http://localhost) **und den HTTP-Port** aufrufen. ↓
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745096814767/3dedcbfb-1d8b-43de-99f0-1398cc1b7a3d.png align="center")
    
9. Für eine **sichere HTTPS-Verbindung (Port 443)** habe ich:
    
    * Ein **SSL-Zertifikat** im **AWS Certificate Manager (ACM)** erstellt
        
    * Einen **CNAME-Eintrag** in **AWS Route 53** gesetzt ↓
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745096946801/32c3af05-fef5-4397-8e6e-28e7c28194b4.png align="center")
        
10. Zur Weiterleitung des Traffics habe ich eine **CloudFront-Distribution** erstellt,  
    die das bereits in ACM generierte SSL-Zertifikat verwendet.  
    Mit einem **A-Eintrag in Route 53** wird der Traffic von Port 80 (HTTP) auf Port 443 (HTTPS) zum Docker-Server geleitet, der die Website hostet. ↓
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745097006680/6a974a02-dc18-40a9-9362-970bb2d01651.png align="center")
    
    Am Ende konnte ich erfolgreich auf meine Website über eine **sichere HTTPS-Verbindung (Port 443)**  
    unter meiner **persönlichen Domain https://mahmoodi-tech.de** zugreifen: ↓
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1745097154179/7b1dac4c-3e36-4f00-aa07-cfbd9b1096c6.png align="center")
    

---

## ✅ Ergebnis

Eine vollständige **CI/CD-Pipeline**, die:

* Änderungen automatisch von GitHub abruft
    
* Den Code auf Schwachstellen mit SonarQube überprüft
    
* Die Website auf einem Docker-Server bereitstellt
    
* Über **HTTPS sicher zugänglich** ist