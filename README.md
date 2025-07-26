
#  DevOps CI/CD Project: Java Retail App

This project demonstrates a complete CI/CD pipeline for a Java-based Retail application, containerized with Docker, deployed via Ansible to a Kubernetes cluster (Minikube), and monitored with Prometheus and Grafana — all hosted on AWS EC2 instances.

---

##  Architecture Overview

```
GitHub → Jenkins → Docker → Ansible → Kubernetes (Minikube) → Prometheus & Grafana
```

##  Flow:
1. Source code pushed to GitHub triggers Jenkins Pipeline.
2. Jenkins builds the `.war` file using Maven.
3. Docker image is built and pushed to Docker Hub.
4. Ansible deploys the image to Minikube running on EC2.
5. Kubernetes runs the containerized app via `Deployment` & `Service`.
6. Prometheus scrapes metrics; Grafana visualizes them.

---

##  Tech Stack

 Tool         Purpose                                 

 GitHub       Source Code Version Control              
 Jenkins      CI/CD Orchestration                      
 Maven        Java Build Tool                          
 Docker       Containerization                         
 Ansible      Configuration Management & Deployment    
 Kubernetes   Container Orchestration (Minikube)       
 EC2 (Ubuntu) Cloud Infrastructure                     
 Prometheus   Metrics Collection                       
 Grafana      Monitoring Dashboard                     

---

## 📁 Project Structure

```
retail-app/
│
├── Jenkinsfile
├── Dockerfile
├── ansible/
│   └── deploy.yml
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── src/
│   └── main/java/com/...
|   └── test/java/com/...
├── pom.xml
└── README.md
```

---

## ⚙️ Setup Instructions

### 1.  Launch EC2 Instances
- Control Node (Jenkins + Ansible)
- Managed Node (Docker + Minikube + K8s)

Open required ports: `8080`, `3000`, `30000-32767`, `22`.

---

### 2. Jenkins Setup
```bash
# Install Jenkins
sudo apt update
sudo apt install jenkins -y
```
- Configure credentials and install plugins: Git, Maven, Docker, Ansible.

---

### 3. Maven & Docker Build
```bash
# Inside Jenkinsfile
mvn clean install
docker build -t yourdockerhub/retail-app .
docker push yourdockerhub/retail-app
```

---

### 4.  Ansible Deployment
```bash
ansible-playbook -i inventory.yml playbook.yml
```

---

### 5.  Kubernetes Deployment (on Minikube)
```bash
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
```

---

### 6.  Monitoring (Prometheus + Grafana)
```bash
# Install via Helm
helm install prometheus prometheus-community/prometheus -n monitoring --create-namespace
helm install grafana grafana/grafana -n monitoring

# Forward Port or Set NodePort
kubectl port-forward svc/grafana 3000:80 -n monitoring

Add Prometheus as data source and import dashboards.

---

> _Add these after running the system_:
- ✅ Jenkins CI pipeline
- 🐳 Docker image on DockerHub
- ☸️ Kubernetes Pods & Services
- 📊 Grafana Dashboards


---

##  Author

Ahmed Abdelraouf  
🔗 [GitHub](https://github.com/ahmedabdelraouf75)
🔗 [Dockerhub](https://hub.docker.com/repository/docker/ahmedabdelraouf/retail-app/general)
 DevOps Engineer 

---

