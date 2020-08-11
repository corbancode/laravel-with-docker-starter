## Laravel With Docker Starter
1. [Introduction](#introduction)
2. [Technologies](#technologies)
3. [Setup](#setup)
4. [Installation & Configuration](#installation-and-configuration)
5. [Testing](#testing)
6. [Security Vulnerabilities](#security-vulnerabilities)

### Introduction

The aim of this project is to make it easy to startup a Laravel project with Docker already configured and ready for use both on local and production environments.

### Technologies

- [PHP](https://www.php.net//)
- [Laravel](https://laravel.com/)
- [Mysql](https://www.mysql.com/)
- [Docker](https://www.docker.com/)


### Setup

**Pre-requisites:**

Make sure Docker is installed.

**Configure your database:**

Find file **.env** or create one in your root directory and set the environment variables listed below:

* **APP_URL**
* **DB_CONNECTION**
* **DB_HOST**
* **DB_PORT**
* **DB_DATABASE**
* **DB_USERNAME**
* **DB_PASSWORD**

**Note:**
If your database is on the same machine, use **docker.host.internal** as the **DB_HOST**

**Change Workspace:**

Find file **docker-compose.yml**, **docker-compose-production.yml** and **docker-compose-testing.yml** in your root directory and replace **laravel-with-docker-starter** with your project folder name:

### Installation
**To start your application**:

##### On server:

The production docker-compose file pulls the latest changes directly from your repository. Find file **docker-compose-production.yml** and set the environment variables listed below:

* **GIT_OAUTH2_TOKEN**
* **REPOSITORY_URL**
* **GIT_BRANCH**

Then run the command below:

```
docker-compose -f docker-compose-production.yml up
```

##### On local:

```
docker-compose up
```

### Testing

Find file **.env.testing** in your root directory and set the environment variables listed below:

* **DB_CONNECTION**
* **DB_HOST**
* **DB_PORT**
* **DB_DATABASE**
* **DB_USERNAME**
* **DB_PASSWORD**

**Note:**
If your database is on the same machine, use **docker.host.internal** as the **DB_HOST**

```
composer test
```

This project uses Codeception for testing.  For more information on how to use codeception for testing, visit [Codeception](https://codeception.com/) official website.

### Security Vulnerabilities

If you discover a security vulnerability within this project, please send an e-mail to me [oayomideelijah@gmail.com](mailto:oayomideelijah@gmail.com). All security vulnerabilities will be promptly addressed.
