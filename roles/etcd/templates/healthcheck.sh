etcdctl endpoint health --endpoints={% for node in groups[mygroup] %}https://{{ hostvars[node].static_address }}:2379{% if not loop.last %},{% endif %}{% endfor %} --cert=/etc/etcd/{{ static_address }}.pem --key=/etc/etcd/{{ static_address }}-key.pem --cacert=/etc/etcd/ca.pem