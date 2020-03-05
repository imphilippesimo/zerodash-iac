#!/bin/bash
kubectl apply -f logstash-pv.yaml
kubectl apply -f logstash-pvc.yaml
kubectl apply -f logstash-deployment.yaml