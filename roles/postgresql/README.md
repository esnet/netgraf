![Logo](https://raw.githubusercontent.com/idealista/postgresql_role/master/logo.gif)

[![Build Status](https://travis-ci.org/idealista/postgresql_role.png)](https://travis-ci.org/idealista/postgresql_role)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-idealista.postgresql__role-B62682.svg)](https://galaxy.ansible.com/idealista/postgresql_role)

# PostgreSQL Ansible role

This Ansible role installs an PostgreSQL (9.6 to 12) server in a Debian (9, 10) or RHEL (7, 8) environment.

- [Getting Started](#getting-started)
	- [Prerequisities](#prerequisities)
	- [Installing](#installing)
- [Usage](#usage)
- [Testing](#testing)
- [Built With](#built-with)
- [Versioning](#versioning)
- [Authors](#authors)
- [License](#license)
- [Contributing](#contributing)

## Getting Started

These instructions will get you a copy of the role for your Ansible playbook. Once launched, it will install an [PostgreSQL](https://www.postgresql.org/) server in a Debian or RHEL system.

### Prerequisities
Ansible >=2.9.x.x version installed.
Inventory destination should be a Debian or RHEL environment.

For testing purposes, [Molecule](https://molecule.readthedocs.io/) with [Docker](https://www.docker.com/) as driver. Pipenv 2018.11.26 and Python 3 recommended.

### Installing

Create or add to your roles dependency file (e.g requirements.yml):

```
- src: idealista.postgresql_role
  version: 1.4.0
  name: postgresql
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
    - { role: postgresql }
```

## Usage

Look to the [defaults vars](defaults/) and [specific OS related](vars/) files to see all the possible configuration vars.
*Important note about custom configuration directories*
We tried to develop the most flexible role. But, even when it's possible changing the default configuration directory, it's not recommended. This role will respect the Debian/RHEL style when deploying config files and initializing the database directory:
* in the Debian case, the configuration files will be deployed in /etc/postgresql
* in the RHEL case, the configuration files will be deployed in the same data directory

## Testing

```
$ pipenv sync
$ pipenv run molecule test
```

See [molecule.yml](https://github.com/idealista/postgresql_role/blob/master/molecule/default/molecule.yml) to check possible testing platforms.

## Built With

![Ansible](https://img.shields.io/badge/ansible-2.9.10-green.svg)
![Molecule](https://img.shields.io/badge/molecule-3.0.6-green.svg)

## Versioning

For the versions available, see the [tags on this repository](https://github.com/idealista/postgresql_role/tags).

Additionaly you can see what change in each version in the [CHANGELOG.md](https://github.com/idealista/postgresql_role/blob/master/CHANGELOG.md) file.

## Authors

* **Idealista** - *Work with* - [idealista](https://github.com/idealista)

See also the list of [contributors](https://github.com/idealista/postgresql_role/contributors) who participated in this project.

## License

![Apache 2.0 License](https://img.shields.io/hexpm/l/plug.svg)

This project is licensed under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license - see the [LICENSE](LICENSE) file for details.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/idealista/postgresql_role/blob/master/.github/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.
