FROM google/cloud-sdk

RUN pip3 install ansible requests openshift==0.11.2 google-cloud-storage

RUN ansible-galaxy collection install lazyninjas.gcp
