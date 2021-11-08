# Promscale Ansible role
![Logo](logo.gif)

[![Build Status](https://travis-ci.com/idealista/promscale_role.png)](https://travis-ci.com/idealista/promscale_role)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-idealista.promscale_role-B62682.svg)](https://galaxy.ansible.com/idealista/promscale_role)



This ansible role installs [Promscale](https://github.com/timescale/promscale#documentation) in a Debian environment. It has been tested for the following Debian versions:
* Buster

This role has been generated using the [cookiecutter](https://github.com/cookiecutter/cookiecutter) tool, you can generate a similar role that fits your needs using the this [cookiecutter template](https://github.com/idealista/cookiecutter-ansible-role).

- [Getting Started](#getting-started)
  - [Prerequisities](#prerequisities)
  - [Installing](#installing)
- [Usage](#usage)
- [Testing](#testing)
  - [Install dependencies](#install-dependencies)
  - [Testing](#testing-1)
- [Built With](#built-with)
- [Versioning](#versioning)
- [Authors](#authors)
- [License](#license)
- [Contributing](#contributing)

## Getting Started
These instructions will get you a copy of the role for your Ansible playbook. Once launched, it will install Promscale in a Debian system.

### Prerequisities

Ansible 2.9.9 version installed.

Molecule 3.x.x version installed.

For testing purposes, [Molecule](https://molecule.readthedocs.io/) with [Docker](https://www.docker.com/) as driver and [Goss](https://github.com/aelsabbahy/goss) as verifier.

### Installing

Create or add to your roles dependency file (e.g requirements.yml):

```
- src: idealista.promscale_role
  version: 1.0.0
  name: promscale_role
```

Install the role with ansible-galaxy command:

```
ansible-galaxy install -p roles -r requirements.yml -f
```

Use in a playbook:

```
---
- hosts: someserver
  roles:
    - role: promscale_role
```

## Usage

Look to the [defaults](defaults/main.yml) properties file to see the possible configuration properties, it is very likely that you will not need to override any variables.

If you need go over and to customize the promscale connector, please check [promscale configuration documentation](https://github.com/timescale/promscale/blob/master/docs/binary.md#%EF%B8%8F-configuration).

To configure promscale to run with Multi-Node deployment of TimescaleDB, please check [promscale Multi-Node TimescaleDB](https://github.com/timescale/promscale/blob/master/docs/multinode.md)

## Testing

```sh
$ pipenv sync
$ pipenv run molecule test 
```

## Built With

![Ansible](https://img.shields.io/badge/ansible-2.9.9-green.svg)
![Molecule](https://img.shields.io/badge/molecule-3.0.4-green.svg)
![Goss](https://img.shields.io/badge/goss-0.3.16-green.svg)

## Versioning

For the versions available, see the [tags on this repository](https://github.com/idealista/promscale_role/tags).

Additionaly you can see what change in each version in the [CHANGELOG.md](CHANGELOG.md) file.

## Authors

* **Idealista** - *Work with* - [idealista](https://github.com/idealista)

See also the list of [contributors](https://github.com/idealista/promscale_role/contributors) who participated in this project.

## License

![Apache 2.0 License](https://img.shields.io/hexpm/l/plug.svg)

This project is licensed under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license - see the [LICENSE](LICENSE) file for details.

## Contributing

Please read [CONTRIBUTING.md](.github/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.
