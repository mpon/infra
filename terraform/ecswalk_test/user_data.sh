#!/bin/bash
yum update -y

# change timezone
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
echo 'UTC=true' >> /etc/sysconfig/clock

# add to ECS cluster
echo ECS_CLUSTER=${cluster} >> /etc/ecs/ecs.config

# Restart service
service docker restart
start ecs
