
<p align="center">
<img src="https://github.com/esnet/netgraf/blob/main/logo/logo.png" width="1000%" height="100%" title="NetGraf logo">
<p>

# NetGraf: Real-time Network Monitoring Tool that uses Machine Learning

Network performance monitoring collects heterogeneous data such as network flow data to give an overview of network performance, and other metrics, necessary for diagnosing and optimizing service quality. However, due to disparate and heterogeneity, to obtain metrics and visualize entire data from several devices, engineers have to log into multiple dashboards.
Here we present NetGraf: An end-to-end learning monitoring system that utilizes current monitoring tools and libraries to analyze the data and perform real-time anomaly finding. It can learn network performance baselines,  understand important data features, and can capture a holistic view of the networking infrastructure from a packet,flow, and device-level data by tapping into multiple  opensource solutions. NetGraf uses automated deployment with Ansible to provide real-time visualizations of various network health metrics from different multiple monitoring sources into a single dashboard for valuable insight on the network. With its machine learning libraries, NetGraf can learn baseline performance, and eventually the ability to optimize in a self-learning network. 
    

## Guide and Documentation

- NetGraf API documentations: 
- NetGraf Example Tutorials: https://github.com/esnet/daphne/tree/master/NetGraf-Ansible


## Explanations
- Website
- Blog
- Video

## Installation Guide
Please ensure you have the IP addresses of the network devices, switches, routers ,servers, systems or hosts you intend to monitor. Netgraf has been tested on Chameleon cloud and Digital ocean instances. To get started, please feel free to use any enviroment or provider of your choice.


## Installation Pre-requisite

* Create a set of Virtual Machine(VM) Instances or network devices that you intend to monitor, and ensure they can communicate and pingable to each other.
* For example you can spin up VMs Using Chameleon Cloud, Amazon EC2, Digital Ocean or any other cloud provider of your choice. 
* To reserve a node and lauch an instance on Chameleon, follow the steps provided [here](https://chameleoncloud.readthedocs.io/en/latest/getting-started/index.html#reserving-a-node).
* Make one of your host or network devices your Control Node, and then others your Target Nodes.
* Modify your hosts file to match the number of intended Target hosts by specifying the IP addresses.
* Depending on your Controller node OS, Install ansible using the steps provided [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-with-pip).

Ensure the devices or host machines are pingable to each other by creating a public key using the instruction [here](https://www.ssh.com/academy/ssh/keygen#what-is-ssh-keygen?), and then copy over your keys to your target nodes using:

	ssh-copy-id user@0.0.0.0 

Once the installtion is complete and your environment is all set up, check the version of your ansible:

    ansible --version


Clone the repository accordingly from a terminal whilst in your home directory with the following command -:

    git clone https://github.com/esnet/netgraf.git

    cd netgraf-main


Test the connectivity between your nodes(Control Node and Target Nodes):

    ansible all -m ping 

    ansible all -m ping -o


Install NetGraf using one push button:

    ansible-playbook playbook.yml 

    time ansible-playbook playbook.yml -vvv


Once the NetGraf installtion is complete, view the PLAY RECAP for any errors and check the prometheus and grafana status.

    sudo systemctl status prometheus

 	sudo systemctl status grafana


To view all the active target nodes and metrics, type the following below. Please note that our controller IP address is 159.65.60.19. Please refer to our environment setup and IP address assignment [here](https://github.com/esnet/netgraf/blob/main/hosts):

     http://159.65.60.19:9090/targets

     http://159.65.60.19:9090/graph

To view the all-in-one NetGraf Dashboard on the controller node:

     http://159.65.60.19:3000


To check the log if the collected metrics is streaming into the central database:

    cd /var/log/promscale/
  
    tail -n 30 -f promscale.log promscale.log 

To check login to the Central database:

	sudo su postgres -c psql

	\l+

	\c timescaledb_db

	select * from  metric;

	\q

	\exit

To extract specific network related metrics and store them into the DB for analysis:


	 bash monitoring_script.sh

To export collected data to a remote location using [rlcone](https://rclone.org/remote_setup/) - Google

	rclone copy /opt/monitor_metrics netgraf_metrics:/metrics_data/ -v



To run the Machine learning component, change to the ml-pipepine directory and follow the instructions [here](https://github.com/esnet/netgraf/tree/main/ml-pipeline/)

    cd ml-pipeline



## Network and System Monitoring tools

Currently, NetGraf library supports the following Monitoring tools: 

**Supported Network and System Monitoring tools:**

* ntopng
* netdata
* collectl
* prometheus
* perfSONAR
* Confluo
* zabbix
* node_exporter
* grafana




## Features

Currently, NetGraf library contains the following features: 

**Machine Learning Models:**

* LSTM,
* SARIMA,
* Exponential smoothing,
* ARIMA,
* Facebook Prophet,
* FFT (Fast Fourier Transform),
* DDCRNN,



### Tests

A [gradle](https://gradle.org/) setup works best when used in a python environment, but the only requirement is to have `pip` installed for Python 3+

To run all tests at once just run
```bash
./gradlew test_all
```

alternatively you can run
```bash
./gradlew unitTest_all # to run only unittests
./gradlew coverageTest # to run coverage
./gradlew lint         # to run linter
```


### Documentation

To build documantation locally just run
```bash
./gradlew buildDocs
```
After that docs will be available in `./docs/build/html` directory. You can just open `./docs/build/html/index.html` using your favourite browser.

## Important Links
- Docs: 
- Example Notebooks: 
- Tutorials: 
- pypi package: 
- Release notes:
- Issue Logs: 
- Contribute:
- Join Slack Community:
- Other Resources: 

## Contact Us
See attached Licence to Lawrence Berkeley National Laboratory
Email: Mariam Kiran <mkiran@es.net>
