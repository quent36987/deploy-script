FROM  postgres:14-alpine

COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
COPY seed-bdd /seed-bdd

# Remove all the .gitkeep files
RUN find /seed-bdd -name .gitkeep -exec rm {} \;

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

EXPOSE 5432


