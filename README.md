<h1 align="center">Inception</h1>

<div align="center">
<img alt="Static Badge" src="https://img.shields.io/badge/Status-Finished-green">
<img alt="Static Badge" src="https://img.shields.io/badge/42-Project-blue">
<img alt="Static Badge" src="https://img.shields.io/badge/Docker-Compose-2496ED">
</div>

## About

**Inception** is a project focused on system administration and containerization. The goal is to set up a small, isolated infrastructure made up of multiple **Docker** containers, each running a single service, all orchestrated together with **Docker Compose** inside a virtual machine.

Rather than relying on pre-built images from Docker Hub, every container is built from a **custom Dockerfile**, based on a Debian, configuring and compiling each service from scratch. This project is a deep dive into how modern infrastructure is composed: isolating services, managing persistent data with volumes, setting up secure internal networking between containers, and handling secrets properly — all without relying on shortcuts like `latest` tags, `network: host`, `--link`, or infinite/hacky loops (like `tail -f`) to keep containers alive.

## Architecture

The infrastructure is built around three core services, each running in its own container:

- **NGINX** — the single entry point of the infrastructure, configured to serve **TLSv1.2/1.3 only**, acting as the sole exposed port (443) to the outside world.
- **WordPress + PHP-FPM** — a WordPress instance with `php-fpm`, communicating with NGINX (not directly exposed to the outside).
- **MariaDB** — the database container, storing all of WordPress's data.

```
                        ┌────────────┐
   HTTPS (443)  ───────▶│   NGINX    │
                        └─────┬──────┘
                              │
                        ┌─────▼──────┐
                        │ WordPress  │
                        │ + PHP-FPM  │
                        └─────┬──────┘
                              │
                        ┌─────▼──────┐
                        │  MariaDB   │
                        └────────────┘
```

Each service runs in its own container with **its own dedicated Dockerfile**, and the containers communicate through a custom **Docker network**. Data persistence is guaranteed through **Docker volumes**, mapped to `/home/<login>/data` on the host, so the WordPress database and website files survive container restarts and rebuilds.

## Features

- **One service per container** — NGINX, WordPress/PHP-FPM, and MariaDB are fully isolated from one another.
- **Custom-built images** — every image is built from a Dockerfile based on the **penultimate stable version** of Debian or Alpine, with no `latest` tag used anywhere.
- **Automatic restart** — containers are configured to restart automatically in case of a crash.
- **Persistent volumes** — the WordPress files and the MariaDB database are stored in Docker volumes on the host machine, so data isn't lost when containers are rebuilt.
- **Secure networking** — containers communicate exclusively through a custom Docker network; no use of `network: host` or container `--link`.
- **TLS-only access** — NGINX is the only service exposed to the host, and only over **HTTPS (port 443)**, using TLSv1.2 or TLSv1.3.
- **Environment variables & secrets** — sensitive information (database credentials, WordPress admin credentials, etc.) is kept out of the Dockerfiles and passed through a `.env` file and/or Docker secrets.
- **Domain name** — the site is accessible through a custom domain pointing to the local machine (e.g. `login.42.fr`), configured via the host's `/etc/hosts`.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Makefile Commands](#makefile-commands)
- [Project Structure](#project-structure)

## Requirements

To build and run **Inception**, you'll need:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- `make`

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/debsalbornoz/inception.git
    cd inception
    ```

2. Set up your environment variables by creating a `.env` file (see `srcs/.env.example` if provided) with your database credentials, WordPress admin info, and domain name.

3. Add your domain to `/etc/hosts` so it resolves to your local machine:

    ```bash
    echo "127.0.0.1 login.42.fr" | sudo tee -a /etc/hosts
    ```

## Usage

Build and start the entire infrastructure with:

```bash
make
```

Once the containers are up and running, access the site at:

```
https://login.42.fr
```

(Replace `login` with your actual 42 login / configured domain.)

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make` / `make all` | Builds and starts all containers. |
| `make up` | Starts the containers (builds if needed). |
| `make down` | Stops and removes the containers. |
| `make clean` | Stops containers and removes images, containers, and networks. |
| `make fclean` | Full clean: also removes volumes and persisted data. |
| `make re` | Equivalent to `make fclean` followed by `make all`. |

## Project Structure

```
inception/
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        ├── wordpress/
        │   ├── Dockerfile
        │   └── conf/
        └── mariadb/
            ├── Dockerfile
            └── conf/
```

---

<p align="center">Built as part of the 42 curriculum 🐳</p>
