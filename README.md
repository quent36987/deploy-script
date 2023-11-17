# INSTALLATION

need to put the ansible vault password in ansible/.passwords/vault.txt
use the make file to run the ansible playbook


# Récapitulatif des services:

## 1. Site Web

    -> netwoks: site-network
    -> label: traefik

## 2. Backend

    -> networks: store-network
    -> label: traefik
    -> envinoment: some env
    -> volumes: starter_images +  all the images

## 3. Frontend

    -> networks: store-network
    -> label: traefik

## 4. Reverse Proxy

    -> networks: site-network + store-network + traefik-network
    -> label: traefik
    -> exposed on: ${DOMAIN} with HTTPS
    -> port inside container: 80 and 443
    -> volumes: /var/run/docker.sock:/var/run/docker.sock:ro
    -> volumes: ./traefik/traefik.yml:/traefik.yml:ro
    -> volumes: .traefik/acme:/acme

## 5. Postgres

    -> networks: store-network
    -> label: traefik
    -> envinoment: some env
    -> volumes: postgres-data (the bdd)
    -> we pass the starter bdd to the image in seed-bdd

## 6. Redis

    -> networks: store-network

## 7. PgAdmin

    -> networks: store-network
    -> label: traefik
    -> envinoment: some env

## TODO
- vault apsser en mode tt secret est chiffré et ajoute regle makefile pour chiffe et dechiffe
  - mettre les autre variabel dans un autre env


## PROBLEME

# sur machine si pas python :)
sudo apt install -y python3-pip

