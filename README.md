*This project has been created as part of the 42 curriculum by oafidi.*

# Inception

## Description

Inception builds a small web infrastructure with Docker Compose. It contains three services, each built from its own Debian-based Dockerfile:

- NGINX is the only public entry point and serves HTTPS on port 443 with TLS 1.2 or TLS 1.3.
- WordPress runs with PHP-FPM and provides the website.
- MariaDB stores the WordPress database.

The source files are under `srcs/`. Docker Compose connects the containers through a private bridge network. Two named volumes persist the database and WordPress files under `/home/oafidi/data`.

### Design comparisons

- **Virtual machines vs Docker:** A virtual machine includes a complete guest operating system. A Docker container shares the host kernel and isolates only the application and its dependencies, making it smaller and faster to start.
- **Secrets vs environment variables:** Environment variables provide runtime configuration. Docker secrets are more appropriate for confidential values because they can be mounted as files instead of being exposed directly in the environment. This project keeps its untracked configuration in `srcs/.env`.
- **Docker network vs host network:** A Docker bridge network isolates the services and gives them DNS names such as `mariadb` and `wordpress`. Host networking removes that isolation and is forbidden by the subject.
- **Docker volumes vs bind mounts:** Docker named volumes are managed as Docker objects. Bind mounts directly expose host paths. This project declares named volumes and configures their storage under `/home/oafidi/data`.


## Instructions

Requirements: a Linux virtual machine, Docker Engine, Docker Compose, and a local `srcs/.env` file.

Map the domain locally by adding this line to `/etc/hosts`:

```text
127.0.0.1 oafidi.42.fr
```

Build and start the project:

```bash
make
```

Open `https://oafidi.42.fr`. The certificate is self-signed, so the browser will display a warning.


`make fclean` permanently removes the containers, images, volumes, and stored website data.

## Resources

- [Docker documentation](https://docs.docker.com/)
- [Docker Tutorial GeeksForGeeks](https://www.geeksforgeeks.org/devops/docker-tutorial/)

AI was used as a learning assistant to explain Docker, MariaDB, PHP-FPM, NGINX, Compose configuration, and testing commands. The generated suggestions were reviewed and tested against the project requirements.
