# Developer Documentation (DEV_DOC.md)

This document explains how a developer can set up, build, and manage the WordPress Docker stack.


## Environment Setup

### Prerequisites
- Docker
- Docker Compose
- Make
- Git

### Configuration
1. Clone the repository:
git clone <repository_url>
cd inception

### Build and start containers using Makefile:
make

### Create a .env file in the root with required variables: 
DATABASE_NAME
DATABASE_ADMIN
DATABASE_ADMIN_PASS
URL=dlamark-.42.fr
TITLE=Inception
WORDPRESS_ADMIN_EMAIL=dlamark-@email.com
WORDPRESS_USER_PASS
VOLUMES_PATH

### Managing Containers:

List running containers:
docker ps

List Docker volumes:
docker volume ls