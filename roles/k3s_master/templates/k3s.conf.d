K3S_OPTS="server --datastore-endpoint http://10.0.0.54:2379 --token 24e7f023c2e7a971c49eb82ca0ffd4ad --node-name {{ ansible_hostname }} --log /var/log/k3s.log"
