#!/bin/bash
kubectl apply -f jenkins-pv.yaml
kubectl apply -f jenkins-pvc.yaml
helm install chilling-jenkins --set master.serviceType=NodePort,persistence.existingClaim=jenkins-pvc stable/jenkins
kubectl apply -f service-reader.yaml
kubectl apply -f deployment-reader.yaml
kubectl apply -f event-reader.yaml
kubectl apply -f dr-reader.yaml
kubectl apply -f secret-reader.yaml