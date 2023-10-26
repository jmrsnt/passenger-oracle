# Passenger with Oracle Instantclient

This Docker image is based on the `phusion/passenger-full` image and has the Oracle Instantclient v12.2 installed.

## How to use

To use this image, simply include the following command in your Dockerfile:

```Dockerfile
FROM jmrsnt/passenger-oracle
```

## Build

To build this image, use the command

```bash
$ ./build
```