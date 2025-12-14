# User Documentation (USER_DOC.md)

This document explains how to use and manage the WordPress Docker stack.

# Overview

This project provides a **containerized WordPress stack** including:

- **WordPress**: CMS running with PHP-FPM.
- **MariaDB**: Database storing all WordPress content.
- **Nginx**: Web server handling HTTP/HTTPS requests.

All services run in separate containers connected through the `inception` Docker network.


## Starting and Stopping the Project

### Start
cd inception 
make

### Stop
cd inception 
make clean

### Access the website

https://dlamark-.42.fr

### Access the adm panel

https://dlamark-.42.fr/wp-admin 

