#!/bin/bash

helm install  smiling-mysql --set service.type=NodePort,service.nodePort=30539,mysqlRootPassword=zerodash,mysqlUser=zerodash,mysqlPassword=zerodash,mysqlDatabase=zerodash stable/mysql
