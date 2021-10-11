FROM google/cloud-sdk:360.0.0

RUN pip3 install ansible pyopenssl requests openshift==0.11.2 google-cloud-storage

RUN ansible-galaxy collection install lazyninjas.gcp

COPY runsible.sh /usr/local/bin/runsible
