This project has been created as part of the 42 curriculum by dlamark-

# Description

The goal of this project is to set up a functional WordPress environment using Docker. This setup provides a self-contained, containerized development environment, including:

- WordPress website for content management.
- MariaDB database for data storage.
- Nginx web server to handle HTTP requests.

By leveraging Docker containers, the project demonstrates key concepts of container orchestration, persistent storage, and proper PHP-FPM configuration, ensuring a reliable and maintainable setup.
Docker allows scalability, reproducibility, and isolation of services, making it suitable for local development and deployment.

## Main Design Choices
This project was designed with modularity, scalability, and maintainability in mind. The main choices include:

1. Custom Docker Images
2. Service Isolation
3. Docker Networks
4. Persistent Storage
5. PHP-FPM Configuration
6. Security and Permissions
7. Automation

### Use of Docker

Docker is used to containerize each component of the stack:
- WordPress runs in its own container, with PHP-FPM managing PHP execution.
-*MariaDB runs in a separate container, ensuring database isolation and security.
- Nginx serves as the reverse proxy and web server, routing traffic to WordPress via PHP-FPM.

## Comparisons

### Virtual Machines vs Docker

- **Virtual Machines (VMs)**:
  - VMs include a full operating system, which consumes more resources and takes longer to boot.
  - Each VM runs its own kernel, making it less efficient in terms of resource utilization.

- **Docker**:
  - Docker containers share the host’s kernel and only include the application and its dependencies, making them more lightweight and faster to start.
  - Containers are ideal for microservices and isolated environments where resources need to be used efficiently.

### Secrets vs Environment Variables

- **Environment Variables**:
  - Environment variables are typically used to pass configuration information into containers or applications. They are easy to manage and can be set at container startup.
  - However, they can be less secure, as they can be visible in logs or process lists.

- **Secrets**:
  - Secrets are sensitive information (such as passwords, API keys, etc.) that should be stored securely. Docker provides a dedicated secrets management system for storing such information securely, making it safer than using environment variables.
  - Secrets are encrypted and only accessible by the services that need them.

### Docker Network vs Host Network

- **Docker Network**:
  - Docker’s bridge network isolates containers from the host and each other, providing secure communication between containers.
  - This network mode ensures that containers can communicate securely with each other without exposing internal services to the host.

- **Host Network**:
  - In host networking, containers share the host’s network stack, meaning that the container's ports are directly mapped to the host’s ports.
  - This mode is typically used when you need maximum performance or when you want the container to behave like it’s part of the host machine’s network.

### Docker Volumes vs Bind Mounts

- **Docker Volumes**:
  - Volumes are managed by Docker and are the preferred method for persistent storage.
  - They are stored outside the container filesystem, making them more portable and easier to back up, restore, and share between containers.

- **Bind Mounts**:
  - Bind mounts allow you to mount specific directories from the host machine into the container.
  - They are often used for development purposes, where you need to reflect changes in the host directory inside the container (e.g., code changes).

# Instructions
## Prerequisites
- Docker
- Docker Compose

# Resources

Docker Documentation
Docker Compose Documentation
WordPress Documentation
MariaDB Documentation
Nginx Documentation
PHP Documentation

# AI Usage

Optimizing container configuration.
Documenting the project
Troubleshooting configuration issues such as PHP modules, network setup, and persistent volumes.