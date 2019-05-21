### This repository is a private fork of [Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV)

This repository contains the WordPress environment setup for 2 WordPress networks
* wordpress-skydreams (used for all SEO knowledge websites and SEA/SEO combi websites)
* homedeal (used for all homedeal websites)

# Getting started
1. **Before running vagrant up**: Import Database, plugins and file uploads.   
   * Copy the latest WordPress export files from Google Drive File Stream (G:\Team Drives\Team IT\WordPress export) to the following directory: `database/sql/imports/`.
   These files contain all the plugins, file uploads and other data that are used on production.
1. Install Wordpress Themes
   * Open a bash shell **on your host machine**, such as 'Git Bash' and run `./scripts/install-themes.sh` from the repository root. This script will clone the required themes in the correct directories
1. Configure VVV Dashboard (optional)
   * Add this entry to your host file if you want to have access to the VVV dashboard. It gives you an overview of all the available WordPress domains.
      ```
      192.168.55.4  vvv.test
      ```
1. Run `vagrant up --provision`. When it's done, visit http://vvv.test. Please make sure that your web VM is running, since the traffic is proxied from there via the nginx-leadsites docker container

The online documentation contains more detailed [installation instructions](https://varyingvagrantvagrants.org/docs/en-US/installation/).

* **Web**: [https://varyingvagrantvagrants.org/](https://varyingvagrantvagrants.org/)
* **Contributing**: Contributions are more than welcome. Please see our current [contributing guidelines](https://varyingvagrantvagrants.org/docs/en-US/contributing/). Thanks!


## Minimum System requirements

- [Vagrant](https://www.vagrantup.com) 2.2.4+
- [Virtualbox](https://www.virtualbox.org) 5.2+
- 8GB+ of RAM
- Virtualisation ( VT-X ) enabled in the BIOS ( Windows/Linux )
- Hyper-V turned off ( Windows )

## Software included

For a comprehensive list, please see the [list of installed packages](https://varyingvagrantvagrants.org/docs/en-US/installed-packages/).

