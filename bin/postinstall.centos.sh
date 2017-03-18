yum install -y ntp iptables-services
systemctl enable ntpd
systemctl start ntpd

systemctl stop firewalld
systemctl disable firewalld
systemctl enable iptables
systemctl start iptables

iptables -A INPUT -s 172.16.0.0/24 -j ACCEPT
iptables-save > /etc/sysconfig/iptables

systemctl restart network
