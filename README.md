# Inception

## 🚀 Project Summary

This project is part of the 42 curriculum and focuses on system administration using **Docker** and **Docker Compose**. The goal is to virtualize an infrastructure consisting of multiple services inside Docker containers. I have built and configured everything from scratch, including custom Dockerfiles, secure networking, and service orchestration.

---

## 📦 What I Built

- **NGINX Container**
  - Serves as the single entry point via **HTTPS** (TLSv1.2/1.3 only)
  - Handles SSL certificate setup and reverse-proxy to WordPress

- **WordPress Container**
  - Uses **php-fpm** to run the PHP backend
  - Automatically installs and configures WordPress on first boot

- **MariaDB Container**
  - Stores the WordPress data
  - Secured with separate root and user passwords
  - All credentials are passed through environment variables

- **Volumes**
  - One volume for the **WordPress website files**
  - Another volume for the **WordPress database**

- **Networking**
  - All containers are connected through a private Docker network
  - No use of `host`, `--link`, or similar deprecated features

- **Automation**
  - A `Makefile` to build and run everything automatically
  - Containers auto-restart if they crash
  - No infinite loops, no bad Docker practices like `tail -f`

- **Security**
  - Environment variables are used throughout
  - Sensitive credentials are stored in a `secrets/` folder and ignored by Git
  - The administrator username avoids "admin" variants as required

---

## 🧾 Directory Structure

```shell
.
├── Makefile
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── nginx/
│       ├── mariadb/
│       └── wordpress/
