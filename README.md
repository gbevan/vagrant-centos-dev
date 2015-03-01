gbevan/vagrant-centos-dev
-------------------------

Docker image of CentOS with developer tools etc for development.  For use with Vagrant as a package build environment for the PasTmon project.

    VAGRANTFILE_API_VERSION = "2"
    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
        config.vm.define "centos-dev", primary: true do |centos|
            centos.vm.synced_folder "/", "/home/vagrant/src"
            centos.vm.provider "docker" do |d|
                d.image = "gbevan/vagrant-centos-dev:latest"
                d.has_ssh = true
            end
        end
    end

Build images using:

    docker build -t gbevan/vagrant-centos-dev:latest .
    
    docker build -t gbevan/vagrant-centos-dev:trusty centos6/
    
    docker build -t gbevan/vagrant-centos-dev:precise centos7/
