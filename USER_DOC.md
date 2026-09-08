# User Documentation

## Services

- **NGINX:** receives HTTPS requests on port 443.
- **WordPress:** provides the website and administration interface through PHP-FPM.
- **MariaDB:** stores WordPress data and is accessible only inside the Docker network.

## Start and stop

From the repository root, start the stack with:

```bash
make
```

Stop and remove the containers while preserving data:

```bash
make down
```

Restart it with `make`. Use `make fclean` only when all website and database data should be permanently deleted.

## Access

- Website: `https://oafidi.42.fr`
- Administration: `https://oafidi.42.fr/wp-admin/`

The local machine must map `oafidi.42.fr` to its local IP in `/etc/hosts`. A browser warning is expected because NGINX uses a self-signed TLS certificate.

## Credentials

Configuration and credential variables are stored in `srcs/.env`.

## Check service health

```bash
docker compose -f srcs/docker-compose.yml --env-file srcs/.env ps
```

MariaDB should be `healthy`, all three containers should be running, and the HTTPS request should return a successful response.
