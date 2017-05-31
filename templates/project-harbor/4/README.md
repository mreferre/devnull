## Harbor 1.1.1 deployment (revision 1)

This catalog item version deploys `Harbor` 1.1.1 on a Cattle cluster and it leverages [Harbor setup wrapper](https://hub.docker.com/r/mreferre/harbor-setupwrapper/tags/) version 1.1.1-1. 

This catalog item version supports both a basic (i.e. standalone) as well as advanced (i.e. distributed) deployment model for Harbor. 

The basic model has less pre-requisites but it's less powerful. The advanced model has more pre-requisites but it's more powerful.  

### Governing the deployment model ###

You govern the deployment model being used by setting the `harbor-host` label:
- if you set the label on one host, you opt in for the basic model.
- if you set the label on two or more hosts, you opt in for the advanced model.

### Storage pre-requisites ###

If you opt in for the basic model there is no storage prerequisite and you can use the `local` volume driver. All volumes will be created locally and transparently on the host with the `harbor-host` label. 

If you opt in for the advanced model you have to configure a volume driver that supports sharing among containers (this catalog entry has been tested with `rancher-nfs` which needs to be activated separately and prior to launch the advanced deployment model).

You can use a volume driver that supports sharing among containers when deploying with the basic model but it is not required. 

### Network pre-requisites ###

> **Note:** the Harbor name you choose at deployment time to use must be exact same end-point (IP, FQDN, etc) that you are going to use on your Docker client to `login` into Harbor, `pull` and `push` images from and to Harbor. This has ramification on how you configure access to the service. 

Access to Harbor is fullfilled by a Rancher load balancer that forwards the host port 80 to port 80 of the Harbor proxy container. The Rancher load balancer is deployed on all hosts that have the `harbor-lb-host` label. The network pre-requisites as described in this section apply to both the basic and advanced deployment models.

The simplest way to fullfill the requirements is to set the `harbor-lb-host` label on a single host and use the IP address of that host in the Harbor `IP/Hostname/FQDN` field. 

A more sophisticated way to fullfill the requirements is to set the `harbor-lb-host` label on multiple hosts and have an external component (e.g. DNS with RR, or external LB) that can send requests to multiple hosts. In this case the Harbor `IP/Hostname/FQDN` field will need to be filled with the FQDN provided by the DNS or by the external LB virtual IP. 

In general, the only real prerequisite is that the `IP/Hostname/FQDN` field at deployment time maps exactly what the user will be using as an endpoint when interacting with the Harbor registry. 

### Additional considerations and known issues ###

- this catalog entry only supports `http` (`https` access is not supported)
- because only `http` is supported, the Docker Host pulling/pushing from/to Harbor needs to have the `--insecure-registry` flag properly configured
- the host(s) with the `harbor-lb-host` label need to have port `80` free for use (different port forwarding configurations hasn't been tested)
- while the Rancher UI may show that stack upgrades are available, upgrades are not supported at this point  
- sometimes the proxy front-end fails to configure properly (due to a race condition) and it shows the "welcome to NGINX" page. If it happens, try to re-deploy the restart the `proxy` container
