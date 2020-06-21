#!/usr/bin/env bash

__PY3=$(command -v python3 || true)
__PIP3=$(command -v pip3 || true)
__INVENTORY="${PWD}/env/$(hostname)/inventory.yml"
__PLAYBOOKS=(
    configure_repository
    provision_system
    provision_user_env
)
__RC=0

if [ "${__PY3}" == "" ] ; then echo "Python 3 not found, please install." ; exit ; fi
if [ "${__PIP3}" == "" ] ; then echo "pip3 not found, please install." ; exit ; fi

test -d /tmp/ve-ansible || python3 -m venv --system-site-packages /tmp/ve-ansible

# shellcheck disable=SC1091
source /tmp/ve-ansible/bin/activate

command -v ansible || pip3 install ansible selinux

test -d roles/controller || ansible-galaxy install -r requirements.yml -f

if [[ -f "${__INVENTORY}" ]] ; then
    ansible-playbook -i "${__INVENTORY}" playbooks/bootstrap.yml -vv
    deactivate

    for playbook in ${__PLAYBOOKS[*]} ; do
        echo "PLAYBOOK: ${playbook}"
        
        __REQUIRES_ROOT=$(grep "become: true" "playbooks/${playbook}.yml" || true)

        if [[ "${__REQUIRES_ROOT}" != "" ]] ; then
            __ASK_BECOME_PASS=" --ask-become-pass"
        else
            __ASK_BECOME_PASS=""
        fi

        PREPARED_CMD="ansible-playbook -i ${__INVENTORY} playbooks/${playbook}.yml -vv${__ASK_BECOME_PASS}"

        ${PREPARED_CMD}
    done
else
    echo "Could not find inventory file: ${__INVENTORY}"
    __RC=1
fi

exit ${__RC}
