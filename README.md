## Prerequisites
1. A Datadog account (there are free two week trials available)
2. An AWS account
3. The AWS cli if you plan on running from your local machine

## Using this Repository
There are a couple of options for getting started with this repository:
1. Clone this repository onto your local machine. If you choose this option, you will need to make sure that you can successfully authenticate with your AWS account.
2. Clone this repository onto an AWS CloudShell. This allows you to not need to worry about configuring authentication as well as changing the versions of any of the binaries needed to use this sample.

## Setup
Once you have the code, open up a terminal (if you're in an AWS CloudShell, you'll have one open already) and change directories into the scripts directory. There are 5 scripts in this directory and they should be run in the following order:
1. install-eksctl.sh
    * example: `./install-eksctl.sh`
2. create-cluster.sh
    * you can pass two parameters into the create-cluster script: the name of your cluster and the AWS region to create your cluster in. both parameters are optional.
    * example: `./create-cluster.sh my-eks-cluster us-east-1`
3. taint-nodes.sh
    * example: `./taint-nodes.sh`
4. create-dd-secret.sh
    * you must pass in a Datadog API key into the script.
    * example: `./create-dd-secret.sh <datadog_api_key>`
5. create-ruby-app-secret.sh
    * you must pass a string into this script
    * example: `./create-ruby-app-secret.sh <my_secret_string>`

After running all of the above scripts, we can start deploying kubernetes objects to our cluster. Note if you already have existing cluster contexts in your kubeconfig, be sure to set the context to the cluster you just created with eksctl before proceeding.

## Create Kubernetes Objects
Change directories into the k8s folder. Within this folder there are 3 subfolders:
* nodejs-app
* otel-collector
* ruby-app

Navigate into the otel-collector directory and run the following command:\
`kubectl apply -f deployment.yaml`\
This will create the following kubernetes objects in the default namespace:
* A ConfigMap named otel-collector-config
* A Deployment named otel-collector-deployment
* A Service named otel-collector-svc

Next, we'll deploy our nodejs-app. Navigate to the k8s/nodejs-app folder and run the following:\
`kubectl apply -f deployment.yaml`\
This will create the following kubernetes objects in the default namespace:
* A ConfigMap named nodejs-app-agent-config
* A Deployment named nodejs-app-deployment

Finally, we'll deploy our ruby-app. Navigate to the k8s/ruby-app folder and run the following:\
`kubectl apply -f deployment.yaml`\
This will create the following kubernetes objects in the default namespace:
* A ConfigMap named ruby-app-agent-config
* A Deployment named ruby-app-deployment

Both our nodejs-app and ruby-app pods have containers in them that generate traffic to our applications. We should now start to see traces appear in the Datadog UI.