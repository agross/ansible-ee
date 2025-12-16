FROM ghcr.io/ansible-community/community-ee-minimal:2.20.1-1

USER 0

RUN dnf install --assumeyes git \
                            python3-netaddr \
                            python3-passlib \
                            python3-bcrypt-4.3.0 && \
    dnf clean all

USER 1000

RUN git --version
RUN ansible --version
