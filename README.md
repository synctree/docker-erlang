# synctree/erlang

The `synctree/erlang` image is intended for use as a base image for Erlang/OTP applications. This Debian-based image uses the packages from [Erlang Solutions Limited](https://www.erlang-solutions.com/).

This image comes in three versions:

* R15 (based on `debian:squeeze`)
* R16 (based on `debian:wheezy`)
* R17 (based on `debian:jessie`)

These images install the `erlang` package from ESL, which pulls in `erlang-base` and the OTP framework packages. Additionally, the R16 and R17 versions include a `slim` variant that only installs `erlang-base` with no additional packages.
