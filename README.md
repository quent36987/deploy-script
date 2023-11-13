# INSTALLATION

need to put the ansible vault password in ansible/.passwords/vault.txt

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
test sur pc portable

-> backup de bdd et d'images :) dans fichier /backup ou dest_path/backup ?
-> si backup, copier mook data ? ou remplacer backup bah mock ? (sens ?)
-> reduire taille image avec run en 1 ligne ? test avant apres ;)
store-image      latest    af081da534bf   19 minutes ago      1.98GB
backend-image    latest    183455247449   20 minutes ago      1.99GB
postgres-image   latest    5a27f55eff9b   About an hour ago   236MB
site-web-image   latest    b4caaa44385f   30 hours ago        437MB

-> backup serveur en route aussi ? :)
-> image dest dans path/dest/docker-images
-> image store et back  change a chaque build ? why :) ?
-> nv mot depasse ne marche pas :( openssl passwd -apr1
-> bgf des motd e passe :)
## question


## PROBLEME

# sur machine si pas python :)
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
