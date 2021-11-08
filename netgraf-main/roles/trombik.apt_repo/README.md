# `ansible-role-apt_repo`

Add apt keys and apt repositories.

## Debian and PPA

The role, deliberately, does not support adding PPA repositories in Debian.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `apt_repo_to_add` | list of apt repository URLs | `[]` |
| `apt_repo_keys_to_add` | list of apt key URLs | `[]` |
| `apt_repo_enable_apt_transport_https` | install `apt-transport-https` if `True` | `false` |
| `apt_repo_required_packages`| List of require packages | `{{ __apt_repo_required_packages }}` |
| `apt_repo_codename_devuan_to_debian` | A dict to map Devuan codename to Debian codename | see below |

## `apt_repo_codename_devuan_to_debian`

A dict to map Devuan codename to Debian codename. Keys are Devuan codename,
and values are corresponding Debian codename.

## Debian

| Variable | Default |
|----------|---------|
| `__apt_repo_required_packages` | `["gnupg", "ca-certificates"]` |

# Dependencies

None

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - ansible-role-apt_repo
  vars:
    apt_repo_keys_to_add:
      - https://artifacts.elastic.co/GPG-KEY-elasticsearch
      - https://repos.influxdata.com/influxdb.key
    dist_apt_repo_to_add:
      Debian:
        - deb https://artifacts.elastic.co/packages/7.x/apt stable main
      Devuan:
        - deb https://artifacts.elastic.co/packages/7.x/apt stable main
        - "deb https://repos.influxdata.com/debian {{ apt_repo_codename_devuan_to_debian[ansible_distribution_release] }} stable"
      Ubuntu:
        - deb https://artifacts.elastic.co/packages/7.x/apt stable main
        - ppa:ubuntuhandbook1/audacity

    apt_repo_to_add: "{{ dist_apt_repo_to_add[ansible_distribution] }}"
    apt_repo_enable_apt_transport_https: True
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>
