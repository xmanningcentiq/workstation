# Ansible Project: Workstation

_"Weapons of War"_

## Prerequisites

  - Linux Machine (x86-64)
  - Python 3

**Note**: Ansible not required initially.

## Quickstart

  1. Ensure you have met the above prerequisites, if not the controller
     role should prompt you for what needs installing.
  1. Create an env/ folder for your `$(hostname)`, you can copy an existing
     one or create a new one. It needs to have the following structure:

     ```text
     env/
       |_ group_vars/
       |    |_ all.yml
       |
       |_ inventory.yml
     ```

  1. Set your inventory to connect locally, a template example is as
     follows:

     ```yml
     ---

     all:
       hosts:
         localhost:
           ansible_connection: local
           ansible_python_interpreter: "{{ ansible_playbook_python }}"

     workstation:
       hosts:
         localhost:
     ```

  1. Ensure you configure the variables for each role in
     `env/$(hostname)/group_vars/all.yml` to meet your needs.
  1. You may fire when ready: `./bootstrap.sh`
     - This will create a temporary virtualenv with the latest Ansible
       installed.
     - This repository will be configured with all the roles requested.
     - Each role will be run to acheive the desired outcome.
