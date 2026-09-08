# Developer Documentation

## Prerequisites and initial setup

Install Docker Engine, the Docker Compose plugin. Clone the repository and create `srcs/.env` with these variables:

```env
MYSQL_ROOT_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
DOMAIN_NAME=oafidi.42.fr
WP_TITLE=
WP_ADMIN_USER=
WP_ADMIN_PASSWORD=
WP_ADMIN_EMAIL=
WP_USER=
WP_USER_PASSWORD=
WP_USER_EMAIL=
```

Fill in the empty values locally.

Add the domain mapping to `/etc/hosts`:

```text
127.0.0.1 oafidi.42.fr
```

## Build and launch

```bash
make
```

The Makefile creates the host data directories and calls Docker Compose to build and start all services.

## Management commands

```bash
make build    # Build the images
make down     # Remove containers and network, preserving data
make re       # Delete everything and rebuild from scratch
```

Compose can also be used directly:

```bash
docker compose -f srcs/docker-compose.yml --env-file srcs/.env ps
docker compose -f srcs/docker-compose.yml --env-file srcs/.env logs
```

## Storage and persistence

- MariaDB data: `/home/oafidi/data/mariadb`
- WordPress files: `/home/oafidi/data/wordpress`

The Compose file exposes these locations through named volumes mounted at `/var/lib/mysql` and `/var/www/html`. A normal `make down` preserves them, so data remains after container recreation. `make fclean` permanently removes both directories and their contents.
