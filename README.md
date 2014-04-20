# Setup Vagrant

My personal configuration for Development Environment with Vagrant


## Getting Started

**Installation**

1 - First of all, make sure you have [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed. <br/>
2 - Clone this repository and create your project folder

```bash
git clone git://github.com/vitorbritto/setup-vagrant.git vagrant
cd vagrant
```

3 - Run the makefile with `vagrant up` <br/>
4 - Profit! :)

**Usage**

     destroy      stops and deletes all traces of the vagrant machine
     halt         stops the vagrant machine
     help         shows the help for a subcommand
     init         initializes a new Vagrant environment by creating a Vagrantfile
     reload       restarts vagrant machine, loads new Vagrantfile configuration
     resume       resume a suspended vagrant machine
     suspend      suspends the machine
     up           starts and provisions the vagrant environment

**Initial Config**

Feel free to change the configuration for paths and server to be whatever you want. Just modify the `path` properties in `./just.js` file.


## Available Provisions

- Base Items
- Apache and PHP
- Composer Packages
- NodeJS and Global Packages
- RVM and RubyGems
- MongoDB
- MySQL
- Git FTP
- Sublime Setup
- VIM Setup


## License

[MIT License](http://vitorbritto.mit-license.org/) © Vitor Britto
