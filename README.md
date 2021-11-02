
<p align="center">
<img src="https://github.com/esnet/daphne/blob/master/NetGraf-Ansible/logo/6.png" width="1000%" height="100%" title="NetGraf logo">
<p>

# NetGraf: Real-time Network Monitoring Tool that uses Machine Learning

<!-- %![](https://github.com/esnet/daphne/blob/master/NetGraf-Ansible/static/5.png)
--- -->
<!-- ![PyPI version](https://badge.fury.io/py/hylia.svg)
![Supported versions](https://img.shields.io/pypi/pyversions/hylia) -->


Building a one-stop dashboard for our machine learning experiments on networks
------------------------------------------------------------------------------

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
Current installation of NetGraf has been tested on Python 3.6. This is Optional, but to get started, we recommend to first setup a clean Python environment for your project with at least Python 3.6 using any of your favorite tool forinstance, ([conda](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html "conda-env"), [venv](https://docs.python.org/3/library/venv.html), [virtualenv](https://virtualenv.pypa.io/en/latest/) with or without [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)).

## Installation Pre-requisite

* Create a set of Virtual machines(VMs) or network devices that can communicate and pingable to each other.
* For example you can spin up VMs Using Chameleon Cloud, Amazon EC2, Digital Ocean or any other cloud provider of your choice. 
* To reserve a node and lauch an instance on Chameleon, follow the steps provided [here](https://chameleoncloud.readthedocs.io/en/latest/getting-started/index.html#reserving-a-node).
* Make one your VMs or network device as your Controller Node, and then others as your Target Nodes. 
* Modify your hosts file to match the number of intended Target hosts by specifying the IP addresses.
* Depending on your OS, Install ansible using the steps provided [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

Once the installtion is complete and your environment is all set up, check the version of your ansible:

    ansible --version


Clone the repository accordingly from a terminal whilst in your home directory with the following command -:

    git clone https://github.com/esnet/daphne/tree/master/NetGraf-Ansible

    cd netgraf-main 


Test the connectivity between your nodes(Controller and Target Nodes):

    ansible all -m ping 

    ansible all -m ping -o


Install NetGraf using one push button:

    ansible-playbook netplaybook.yaml 


Once the NetGraf installtion is complete, check the PLAY RECAP for any errors.

 

<!-- <div style="text-align:center;">
<img src="https://github.com/esnet/hylia_networkprediction/blob/master/static/example.png" alt="hylia forecast example" />
</div> -->


Please feel free go over the example and tutorial notebooks in 
the [examples](https://github.com/esnet/daphne/tree/master/NetGraf-Ansible) directory.


## Network and System Monitoring tools

Currently, NetGraf library supports the following Monitoring tools: 

**Supported Network and System Monitoring tools:**

* ntopng
* perfSONAR
* Confluo
* Netdata
* collectl
* tcpdump
* prometheus
* iperf3


## Features

Currently, NetGraf library contains the following features: 

**Machine Learning Models:**

* LSTM,
* SARIMA (For seasonality),
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
