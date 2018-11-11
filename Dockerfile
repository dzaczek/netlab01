FROM alpine:latest

RUN apk add --no-cache dhcp
RUN apk add --no-cache tftp-hpa

EXPOSE 67/udp 67/tcp 69/udp

RUN ["touch", "/var/lib/dhcp/dhcpd.leases"]

VOLUME ["/etc/dhcp"]
VOLUME ["/var/tftpboot"]

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--secure", "/var/tftpboot"]
CMD ["/usr/sbin/dhcpd", "-4", "-f", "-", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
