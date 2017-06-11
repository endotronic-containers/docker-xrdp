FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get install -y supervisor xrdp x11vnc xvfb
RUN apt-get install -y openbox
RUN apt-get install -y dbus-x11 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY xrdp.ini /etc/xrdp/xrdp.ini
COPY entry.sh /root/entry.sh
RUN chmod +x /root/entry.sh

RUN mkdir -p /var/log/supervisor
RUN useradd -m foo && \
    echo "foo:bar" | chpasswd

RUN mkdir -p /home/foo/.config/openbox
RUN dbus-uuidgen > /etc/machine-id

# Allow all users to connect via RDP.
RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

EXPOSE 3389
EXPOSE 5900
ENTRYPOINT ["/bin/sh", "/root/entry.sh"]
