#!/usr/bin/env bash

#docker exec -it ansible ansible-playbook playbook.yml -i inventory/local/hosts
docker exec -it ansible ansible-playbook  playbook.yml -i inventory/local/hosts -i inventory/server/hosts
