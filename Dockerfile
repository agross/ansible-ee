FROM registry.fedoraproject.org/fedora-minimal:43

# renovate: pypi=ansible-core
ARG ANSIBLE_CORE_VERSION=2.22.0

# The following packages allow this image to be used as an ambient container
# running GitHub Actions.
#
# git: for actions/checkout to get the code.
# wget: required for the ansible/ansible-lint action.
# python3-*: required for the modules I use in my playbooks.
RUN dnf install --assumeyes \
                git \
                wget \
                openssh-clients \
                sshpass \
                tar \
                python3-pip \
                python3-netaddr \
                python3-passlib \
                python3-bcrypt-4.3.0 \
                python3-jmespath && \
    dnf clean all && \
    python3 -m venv --system-site-packages /opt/ansible && \
    /opt/ansible/bin/pip install --no-cache-dir "ansible-core==${ANSIBLE_CORE_VERSION}" ansible-runner && \
    test "$(/opt/ansible/bin/ansible --version | sed -n '1p')" = "ansible [core ${ANSIBLE_CORE_VERSION}]"

ENV PATH="/opt/ansible/bin:${PATH}"
