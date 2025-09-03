docker run -it --rm \
  -p 5678:5678 \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_HOST=aws-1-us-east-2.pooler.supabase.com \
  -e DB_POSTGRESDB_PORT=5432 \
  -e DB_POSTGRESDB_DATABASE=postgres \
  -e DB_POSTGRESDB_USER=postgres.egveyjmlqzdzhvsppqni \
  -e DB_POSTGRESDB_PASSWORD=W0u01vLEIOIIH8z \
  -e DB_POSTGRESDB_SSL_ENABLED=true \
  -e DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false \
  -e N8N_LOG_LEVEL=debug \
  n8nio/n8n:latest
