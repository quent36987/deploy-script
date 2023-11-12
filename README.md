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
- refacto compose
- mettre au propre histoire de sdonné
- tt les infos dans un env propre
- plusieur env fil plutot que all.yml ? services.yml ?
- env avec les secrets
- mettre les secret strip et a rien dans le local
- test asnyc


## question
> si 2 variable déclarer dans 2 inventory, le quel il prends, ca a du sens ?

## PROBLEME

-> vaul tt cacher :)
-> pull image ne marche pas ? :( suprimer tt avant de relancer ? ou comment forcer pull et build ?

#sur machine
sudo apt install -y python3-pip

# scénario

## 1. sur test serveur

```shell
docker exec -it ansible ansible-playbook  playbook.yml -i inventory/server/hosts -i inventory/local/hosts
```

Clone repo, build, tar image en local
envoi sur le serveur de test, les images,
la bdd de test et les différentes données ainsi que la config du proxy.
lance le docker compose avec les bonne données et environnement

## 2. sur prod serveur

```shell
docker exec -it ansible ansible-playbook  playbook.yml -i inventory/prod/hosts -i inventory/local/hosts
```

Clone repo, build, tar image en local
envoi sur le serveur de prod et les différentes données ainsi que la config du proxy.
lance le docker compose avec les bonne données et environnement

## 3. en local ?

```shell
docker exec -it ansible ansible-playbook  playbook.yml -i inventory/local/hosts ...
```

Clone repo, build, tar image en local
change le docker compose ainsi que la confid pour reverse traefik proxy local :)
lance le docker compose avec les bonne données et environnement + donner de test en local
