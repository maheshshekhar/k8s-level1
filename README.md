# mstakx - K8s assignment - Level 1 #

## Automated Script ##

Run the below command to bring up the stack: `./wrapper.sh <project_id>`

project_id is the GCP Project ID where our cluster needs to be created.

Note: Step 6 and onwards is not part of this automation script

### Creating the cluster ###
1. Create a Kubernetes cluster on GCP

    We have utilized Terraform to create the K8s. Go into the terraform directory and run the below command.

    Command: `terraform apply -var='project_id=<project_id>'` # Specify the project id
        Ex: `terraform apply -var='project_id=mstakx-248316'`

2. Create namespaces called staging and production

    Navigate to the guestbook folder and run the below command to create the Staging, Production and Ingress namespace.

    Command: `kubectl apply -f namespace.yml`

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/namespace.jpg" alt="namespace"/>

3. Install nginx ingress controller on the cluster

    Navigate to the guestbook folder and run the below command to create the ingress controller.

    Command: `kubectl apply -f ingress/`

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/staging-ingress.jpg" alt="staging-ingress"/>

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/production-ingress.jpg" alt="production-ingress"/>

4. Install guest-book application on both namespaces, Expose the staging application and implement pod           autoscaler

    Navigate to the guestbook folder and run the below command:

    Command: `kubectl apply -f staging/`

    This will create the frontend application, the redis cluster, ingress and horizontal pod autoscaler using the files: frontend-staging.yml, redis-master-staging.yml, redis-slave-staging.yml, ingress-staging.yml and hpa-staging.yml respectively.

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/staging-application.jpg" alt="staging-application"/>

5. Similarly for Prodction

    Navigate to the guestbook folder and run the below command:

    Command: `kubectl apply -f production/`

    This will create the frontend application, the redis cluster, ingress and horizontal pod autoscaler using the files: frontend-production.yml, redis-master-production.yml, redis-slave-production.yml, ingress-production.yml and hpa-production.yml respectively.

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/production-application.jpg" alt="production-application"/>

6. Demonstrate how the pods are scaling up and down by increasing/decreasing load on existing pods

    Navigate to the guestbook folder and run the below command:

    Command: `kubectl apply -f staging-load-generator.yml` and 
             `kubectl apply -f production-load-generator.yml`

    This will hit the service using wget creating stress on the CPU. As soon as the CPU utilization goes more than 70%, new pods will start getting added. Min of 1 pod and a maximum of 5 pods will be available at any given point of time.

    - HPA Status before load

      <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/before-hpa.jpg" alt="before-hpa"/>

    - HPA Status after load

      <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/after-hpa.jpg" alt="after-hpa"/>

7. Finally, manually updated the /etc/hosts file for to add the public IP of the ingress load balancer.

      <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/hosts.jpg" alt="hosts"/>

8. Open the browser and navigate to: 
    - Staging:    <http://staging-guestbook.mstakx.io>

    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/staging-page.jpg" alt="staging-page"/> 


    - Production: <http://guestbook.mstakx.io> 


    <img src="https://github.com/maheshshekhar/k8s-level1/blob/master/images/production-page.jpg" alt="production-page"/>
=======================================================================================

1. What was the node size chosen for the Kubernetes nodes? And why?

    Here I have considered 3 vCPU with total of 11.25GB Memory. I have choosen this to demonstrate the HPA. And also i have free credits to create the GCP K8s cluster and hence not compromised on the vCPU's.

2. What method was chosen to install the demo application and ingress controller on the cluster, justify the
   method used

    Here I have used YAML in order to install the demo application and its dependencies. I have choosen this as YAML gives numerous advantages like Human readability, easy maintenance, easy to use.

3. What would be your chosen solution to monitor the application on the cluster and why?

    I would like to choose prometheus and grafana for monitoring as they are open source. Apart from this I would prefer to use Datadog. And also utilize Kibana for logs searchability.

4. What additional components / plugins would you install on the cluster to manage it better?

    I would like to implement node autoprovisioning and also would like to introduce additional security features.
