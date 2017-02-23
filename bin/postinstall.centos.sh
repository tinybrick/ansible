yum install -y ntp iptables-services
systemctl enable ntpd
systemctl start ntpd

systemctl stop firewalld
systemctl disable firewalld
systemctl enable iptables
systemctl start iptables