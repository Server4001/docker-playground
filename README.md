# docker-playground

## Ubuntu vagrant environment with Docker exammples.

### TODO

* What does testing a PHP app using containers look like?
* Jenkins and docker?
* Swarm mode?
* Kubernetes?

### Ansible container:

* `apt-get update`
* `apt-get install -y python-pip python-dev build-essential`
* `pip install --upgrade pip`
* `pip install --upgrade virtualenv`
* `pip install ansible==2.4.3.0`
* `pip install ansible-container[docker,openshift]`
* `pip install urllib3==1.14`
* `export PYTHONPATH=/usr/local/lib/python2.7/dist-packages:/usr/lib/python2.7/dist-packages`
