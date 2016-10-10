ansible-role-localtime
=====================

Set local time zone.

Requirements
------------

None

Role Variables
--------------

| Variable | Description | Default |
|----------|-------------|---------|
| localtime\_zoneinfo\_dir | directory where zoneinfo files are located | {{ \_\_localtime\_zoneinfo\_dir }} |
| localtime\_zone | a hash of ansible\_os\_family in key and timezone in value | {} |

## Debian

| Variable | Default |
|----------|---------|
| \_\_localtime\_zoneinfo\_dir | /usr/share/zoneinfo |

## FreeBSD

| Variable | Default |
|----------|---------|
| \_\_localtime\_zoneinfo\_dir | /usr/share/zoneinfo |

## OpenBSD

| Variable | Default |
|----------|---------|
| \_\_localtime\_zoneinfo\_dir | /usr/share/zoneinfo |

## RedHat

| Variable | Default |
|----------|---------|
| \_\_localtime\_zoneinfo\_dir | /usr/share/zoneinfo |

Created by [yaml2readme.rb](https://gist.github.com/trombik/b2df709657c08d845b1d3b3916e592d3)

Dependencies
------------

None

Example Playbook
----------------

```yaml
- hosts: localhost
  roles:
    - ansible-role-localtime
  vars:
    localtime_zone:
      FreeBSD: Asia/Tokyo
      OpenBSD: Japan
```

License
-------

Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

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

Author Information
------------------

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
