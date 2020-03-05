#!/bin/bash

helm install cool-elasticsearch --set master.replicas=1,client.replicas=1,data.replicas=1 stable/elasticsearch