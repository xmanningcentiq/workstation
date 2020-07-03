# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.9.7"

$provisioningScriptRHEL8 = <<-SCRIPT
if [[ ! -f /.provision ]] ; then
  echo "Linking inventory for this VM ..."
  THISHOST="$(hostname)"
  TARGETHOST="${THISHOST:0:-1}"
  if [[ -d "/vagrant/env/${TARGETHOST}" ]] ; then
    cp -r "/vagrant/env/${TARGETHOST}" "/vagrant/env/${THISHOST}"
    echo "virtualbox_skip_virtualization_test: true" >> "/vagrant/env/${THISHOST}/group_vars/all.yml"
    echo "[Done]"
  else
    if [[ "${THISHOST: -1}" != "x" ]] ; then
      echo "${THISHOST} doesn't appear to follow the naming convention!"
      echo "[FAILED]"
    else
      echo "Can't find ${TARGETHOST} directory."
      echo "[FAILED]"
    fi
  fi
  echo "Installing GNOME desktop (this may take a while) ..."
  sudo dnf install -y @gnome-desktop >> /.provision && echo "[Done]"
  sudo dnf install -y git gcc >> /.provision && echo "[Done]"
  sudo systemctl set-default graphical.target >> /.provision
  sudo systemctl isolate graphical.target >> /.provision
fi
SCRIPT

$provisioningScriptRHEL7 = <<-SCRIPT
if [[ ! -f /.provision ]] ; then
  echo "Linking inventory for this VM ..."
  THISHOST="$(hostname)"
  TARGETHOST="${THISHOST:0:-1}"
  if [[ -d "/vagrant/env/${TARGETHOST}" ]] ; then
    cp -r "/vagrant/env/${TARGETHOST}" "/vagrant/env/${THISHOST}"
    echo "virtualbox_skip_virtualization_test: true" >> "/vagrant/env/${THISHOST}/group_vars/all.yml"
    echo "[Done]"
  else
    if [[ "${THISHOST: -1}" != "x" ]] ; then
      echo "${THISHOST} doesn't appear to follow the naming convention!"
      echo "[FAILED]"
    else
      echo "Can't find ${TARGETHOST} directory."
      echo "[FAILED]"
    fi
  fi
  echo "Installing GNOME desktop (this may take a while) ..."
  sudo yum install -y @gnome-desktop >> /.provision && echo "[Done]"
  sudo yum install -y python3 libselinux-python3 git gcc >> /.provision && echo "[Done]"
  sudo systemctl set-default graphical.target >> /.provision
  sudo systemctl isolate graphical.target >> /.provision
fi
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define "pc-centiq-33" do |ws|
    ws.vm.hostname    = "pc-centiq-33x"
    ws.vm.box         = "fedora/32-cloud-base"
    ws.vm.network     "private_network", ip: "192.168.12.3"

    ws.vm.provider "virtualbox" do |vb|
      vb.gui    = true
      vb.name   = "Workstation VM"
      vb.cpus   = 2
      vb.memory = "2048"
    end

    ws.vm.provision "shell", inline: $provisioningScriptRHEL8
  end

  ##
  # RETIRED SYSTEM
  ##
  # config.vm.define "pc-xmann-01" do |ws|
  #   ws.vm.hostname    = "pc-xmann-01x"
  #   ws.vm.box         = "centos/7"
  #   ws.vm.network     "private_network", ip: "192.168.12.2"
  #
  #   ws.vm.provider "virtualbox" do |vb|
  #     vb.gui    = true
  #     vb.name   = "Workstation VM"
  #     vb.cpus   = 2
  #     vb.memory = "2048"
  #   end
  #
  #   ws.vm.provision "shell", inline: $provisioningScriptRHEL7
  # end
end
