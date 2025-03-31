# AtCoder(C++/Python) on Docker
## Description
- **C++/Python environment for AtCoder with docker**
- Because it is docker, it is highly portable and can be run without contaminating the host environment

## Prerequisites
* Docker (and enough PC to run it)
* Visual Studio Code (in host)
* AtCoder Account

## Build
Clone this repository to an arbitrary location.
```shell
$ git clone https://github.com/kurimochi/atcoder_on_docker
```
Next, log in to AtCoder in your browser and press F12 to open DevTools. Then, go to `Application -> Cookies -> https://atcoder.jp` and copy the Value of the cookie named `REVEL_SESSION`.  
The copied values will be used later for `online-judge-tools` login. Therefore, copy `.devcontainer/src/cookie-template.jar` to `.devcontainer/secrets/cookie.jar` and replace `{Insert the copied value}` in the third line with the value you just copied.
```shell
$ cp .devcontainer/src/cookie-template.jar .devcontainer/secrets
```
Go to `.devcontainer` and create a container.
```shell
$ cd .devcontainer
$ docker compose up -d --build
```
In my environment, it took about a little over 3 minutes. This image will eventually be over 3 GB, so it requires a good amount of disk space.

## Usage
If the container has been terminated, start it up again.
```shell
$ docker compose up -d
```
Install the `Dev Containers` extension in VSCode and attach it to the `atcoder` container from a remote tab.

### Download Test Data
In the following, we will explain the procedure for actually solving the problem. First, go to `contest/` and download the test data for the problem. For example, the problem `abc001` can be downloaded as follows. You may be asked for a user name and password, but you can leave them blank.
```shell
$ acc new abc001
```
If you want to answer in Python, add the `--template python` option.
```shell
$ acc new abc001 --template python
```
For more information, please see the [`atcoder-cli` repository](https://github.com/Tatamo/atcoder-cli) and help (`-h`).

### Solution
There is a contest directory under `contest/` and a directory for each problem under `contest/`. Edit `main.*` in the directory of the problem you want to solve using VSCode.

### Test
Originally, you would have to type a longer command, but I preconfigured an alias, so no problem. You can run the test with the following commands, respectively.

C++: `cpptest`  
Python3(PyPy): `pypytest`  
Python3(CPython): `py3test`

### Submit
If the test shows no problems, the code will be submitted to AtCoder. Note that the alias is also set as follows.

C++: `cppsb`  
Python3(PyPy): `pypysb`  
Python3(CPython): `py3sb`

Before submission, you will receive a confirmation in the form of a text string, which you can follow and submit. The results can be viewed on the site.

## Customize
This repository consists of the following And the places marked with * are where you can customize it. If a directory is marked with *, it means that the files under the directory can be customized.
```
.
│  .gitignore
│  README.md
│
├─.devcontainer/
│  │  devcontainer.json         *
│  │  docker-compose.yml        *
│  │  Dockerfile                *
│  │
│  └─src
│      │  .bashrc               *
│      │  cookie-template.jar
│      │  requirements.txt      *
│      │  template.json
│      │
│      └─templates              *
│          ├─cpp
│          │      main.cpp
│          │      template.json
│          │
│          └─python
│                  main.py
│                  template.json
│
├─.vscode
│      c_cpp_properties.json
│
└─contest
    └─...
```
The following sections describe how to customize each file/directory.

### .devcontainer/devcontainer.json
`devcontainer.json` is the configuration file used by VSCode in this configuration. It is `{.customizations.vscode}` that can be customized here. You can specify preinstalled extensions in `extensions` and standard settings in `settings`.

### .devcontainer/docker-compose.yml
`docker-compose.yml` is the container configuration file. You can change the container name in `.service.atcoder.container_name`.

### .devcontainer/Dockerfile
`Dockerfile` is a container image design document. What you can customize here is the `apt install` command on line 5. You can customize the packages to be installed here. For example, if you want to install `Ruby` in this environment, you can add `ruby` after `apt install -y`. You can also add your own commands, although this is not recommended for beginners.

### .devcontainer/src/.bashrc
In `.bashrc`, the alias is set. If you want to add a new language or set an alias for another command, you can add it here.

### .devcontainer/src/requirements.txt
In `requirements.txt`, you can customize which libraries to install with pip. For example, if you want to install `numpy`, you can add `numpy` to `requirements.txt`.

### .devcontainer/src/templates/
In this directory, the template for downloading test data with `atcoder-cli` is set up. The template can be changed as you wish in `main.*`.  
To add a template, create a directory under `templates` (the directory name should be the template name) and write a code template for your language. Then copy `src/template.json` to that directory and replace {insert file name} with the file name of the code you created.  
To change the default template, execute the following command Replace {Insert template name} with the name of the template.
```shell
$ acc config default-template {Insert template name}
```