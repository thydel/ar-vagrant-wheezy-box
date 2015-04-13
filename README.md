<!--- -*- Mode: Markdown; fill-column: 96; -*- --->
<!--- Ansible managed: /home/thy/usr/epi/ar-vagrant-wheezy-box/setup/templates/README.md.j2 modified on 2015-04-13 21:05:50 by thy on make.epiconcept.local --->

# Role Name

use git@github.com:dotzero/vagrant-debian-wheezy-64.git

## Role Variables

```yaml
vagrantwheezybox_name: debian-wheezy
vagrantwheezybox_git: git@github.com:thydel/vagrant-debian-wheezy-64.git
vagrantwheezybox_dir: ../vagrant-debian-wheezy-64
```

## Example Playbook

```yaml
- hosts: servers
  roles:
    - role: thydel.vagrant-wheezy-box
```

## Usage

- ansible-playbook -i localhost, vagrant-wheezy-box-setup.yml --diff
- ansible-playbook -i localhost, -c local vagrant-wheezy-box-play.yml --check
- ansible-playbook -i server, vagrant-wheezy-box-play.yml --check

## License

MIT

