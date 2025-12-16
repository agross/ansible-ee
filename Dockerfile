FROM ghcr.io/ansible-community/community-ee-minimal:2.20.1-1

# Do not revert to user 1000 as in the base image because it causes problems
# with GitHub Actions.
# https://github.com/actions/checkout/issues/956
USER 0

# The following packages allow this image to be used as an ambient container
# running GitHub Actions.
#
# git: for actions/checkout to get the code.
# wget: required for the ansible/ansible-lint action.
# python3-*: required for the modules I use in my playbooks.
RUN dnf install --assumeyes \
                git \
                wget \
                python3-netaddr \
                python3-passlib \
                python3-bcrypt-4.3.0 && \
    dnf clean all
