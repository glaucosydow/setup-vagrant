# -*- mode: ruby -*-
# vi: set ft=ruby :


################################################################################
# General Configuration
################################################################################

# Config Github Settings
github_username = "vitorbritto"
github_repo     = "setup-vagrant"
github_branch   = "master"

# Server Configuration
# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_host     = "mybox"
server_domain   = "vitorbritto.com"
server_ip       = "192.168.0.1"
server_memory   = "256" # MB
server_timezone = "UTC"

# Database Configuration
mysql_root_password   = "root"   # We'll assume user "root"
mysql_version         = "5.5"    # Options: 5.5 | 5.6
mysql_enable_remote   = "false"  # remote access enabled when true


################################################################################
# Languages and Packages
################################################################################

# Ruby Options
ruby_version          = "latest"   # Choose what ruby version should be installed (will also be the default version)
ruby_gems             = [          # List any Ruby Gems that you want to install
    "rails",
    "sass",
    "compass",
    "haml",
    "jekyll",
    "bundler",
    "capistrano",
    "sinatra"
]

# PHP Options
php_version           = "previous" # Options: latest=5.5, previous=5.4, distributed=5.3
composer_packages     = [          # List any global Composer packages that you want to install
  "phpunit/phpunit:4.0.*",
  "phpspec/phpspec:2.0.*@dev",
  "squizlabs/php_codesniffer:1.5.*"
]

# NodeJS Options
nodejs_version        = "latest"   # By default "latest" will equal the latest stable version
nodejs_packages       = [          # List any global NodeJS packages that you want to install
    "grunt-cli gulp",
    "bower",
    "express",
    "imageoptim-cli",
    "docpad",
    "nave",
    "browserify",
    "beefy",
    "shelljs",
    "uglify-js",
    "jshint",
    "csslint",
    "csscomb",
    "stylus",
    "coffee-script",
    "browser-sync",
    "karma",
    "markdown",
    "pageres",
    "jade",
    "harp",
    "jasmine-node",
    "mocha",
    "coveralls",
    "nightwatch",
    "yuidocjs",
    "dploy"
]

Vagrant.configure("2") do |config|

    # Set server to Ubuntu 12.04
    config.vm.box = "#{server_host}"

    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    # Create a hostname, don't forget to put it to the `hosts` file
    # This will point to the server's default virtual host
    # TO DO: Make this work with virtualhost along-side xip.io URL
    config.vm.hostname = "#{server_host}.#{server_domain}"

    # Create a static IP
    config.vm.network :private_network, ip: "#{server_ip}"

    # Use NFS for the shared folder
    config.vm.synced_folder ".", "/vagrant",
            id: "core",
            :nfs => true,
            :mount_options => ['nolock,vers=3,udp,noatime']

    # If using VirtualBox
    config.vm.provider :virtualbox do |vb|

        # Set server memory
        vb.customize ["modifyvm", :id, "--memory", "#{server_memory}"]

        # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
        # If the clock gets more than 15 minutes out of sync (due to your laptop going
        # to sleep for instance, then some 3rd party services will reject requests.
        vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

        # Prevent VMs running on Ubuntu to lose internet connection
        # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        # vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    end

    # If using VMWare Fusion
    config.vm.provider "vmware_fusion" do |vb, override|
        override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

        # Set server memory
        vb.vmx["memsize"] = "#{server_memory}"

    end


    ################################################################################
    # Base Items
    ################################################################################

    # Provision Base Packages
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/base.sh"

    # Provision PHP
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/php.sh", args: [php_version, server_timezone]


    ################################################################################
    # Web Servers
    ################################################################################

    # Provision Apache Base
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/apache.sh", args: [server_ip, public_folder]


    ################################################################################
    # Databases
    ################################################################################

    # Provision MySQL
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mysql.sh", args: [mysql_root_password, mysql_version, mysql_enable_remote]

    # Provision MongoDB
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mongodb.sh"


    ################################################################################
    # Utility
    ################################################################################

    # Install Heroku Toolbelt
    config.vm.provision "shell", path: "https://toolbelt.heroku.com/install-ubuntu.sh"


    ################################################################################
    # Tooling
    ################################################################################

    # Install Nodejs and Packages
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/nodejs.sh", privileged: false, args: nodejs_packages.unshift(nodejs_version)

    # Install Ruby Version Manager (RVM) and RubyGems
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/rvm.sh", privileged: false, args: ruby_gems.unshift(ruby_version)

    # Install Composer and Packages
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/composer.sh", privileged: false, args: composer_packages.join(" ")

    # Install git-ftp
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/git-ftp.sh", privileged: false


    ################################################################################
    # Editors Config
    ################################################################################

    # Provision Vim
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/vim.sh"

    # Provision Sublime
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/subl.sh"


    ################################################################################
    # Plugins Config
    ################################################################################
    #
    # Installed plugins
    #   - vagrant-bundler    : https://github.com/mocoso/vagrant-bundler
    #   - vagrant-cachier    : https://github.com/fgrehm/vagrant-cachier
    #   - vagrant-mongodb    : https://github.com/smdahlen/vagrant-mongodb
    #   - vagrant-mysql      : https://github.com/Logaritmisk/vagrant-mysql
    #   - vagrant-node       : https://github.com/fjsanpedro/vagrant-node
    #   - vagrant-proxy      : https://github.com/clintoncwolfe/vagrant-proxy
    #   - vagrant-rake       : https://github.com/mitchellh/vagrant-rake
    #   - vagrant-rsync      : https://github.com/cromulus/vagrant-rsync
    #   - vagrant-vbguest    : https://github.com/dotless-de/vagrant-vbguest
    #
    ################################################################################

    # Provision Plugins
    config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/plugins.sh"

    # If using vagrant-cachier
    if Vagrant.has_plugin?("vagrant-cachier")

        config.cache.scope = :box

        config.cache.synced_folder_opts = {
            type: :nfs,
            mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
        }

    end

    # If using vagrant-mongodb
    if Vagrant.has_plugin?("vagrant-mongodb")

        config.mongodb.auto_initiate = false

        config.mongodb.replset :rs0 do |rs|
          rs.ignore_private_ip = false
          rs.member :server1, :priority => 1
          rs.member :server2, :priority => 2
          rs.member :server3, :priority => 1
        end

    end

    # If using vagrant-rake
    if Vagrant.has_plugin?("vagrant-rake")

        config.rake.directory = "/my/custom/directory"

    end

    # If using vagrant-vbguest
    if Vagrant.has_plugin?("vagrant-vbguest")

        # we will try to autodetect this path.
        # However, if we cannot or you have a special one you may pass it like:
        # config.vbguest.iso_path = "#{ENV['HOME']}/Downloads/VBoxGuestAdditions.iso"
        # or
        # config.vbguest.iso_path = "http://company.server/VirtualBox/%{version}/VBoxGuestAdditions.iso"

        # set auto_update to false, if you do NOT want to check the correct
        # additions version when booting this machine
        config.vbguest.auto_update = false

        # do NOT download the iso file from a webserver
        config.vbguest.no_remote = true

    end


    ############################################################
    # Local Scripts
    # Any local scripts you may want to run post-provisioning.
    # Add these to the same directory as the Vagrantfile.
    ############################################################
    config.vm.provision "shell", path: "./script-local.sh"

end
