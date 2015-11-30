## DevOps Project - Special Milestone

### Restart Monkey
* We have a simple restart monkey in place here, which is a `bash` script
  * The monkey restarts the `tomcat` server.
  * Once the server is restarted, a REST call is made to check if the application is live.
  * The results of this monkey event are sent as email notifications

### Trainer Monkey
* This monkey tests the response time for a request in presence of significant load on the production host
  * This monkey is implemented via a `bash` script
  * `stress-ng` linux service is used to load up the production host
  * All the load configurations are user-configurable which are placed in `stress-config` file. 
  * The monkey randomly chooses between the specified configurations, loads up the host and then measures the response time for a request under this load
  * The results of this monkey event are sent as email notifications

### Components 
* `restart_monkey.sh` : The Restart Monkey script
* `stress_monkey.sh` : The Trainer Monkey script
* `stress-config` : This file contains all the load configurations that we want to stress-test for. The monkey randomly chooses one of these and tests against that load
* `init.sh` : Setup script that SSHes into remote production servers and SCPes the monkey scripts.
* `config.cfg` : A configuration file to control parameters such as email recipients, project source directory and the remote hosts' IPs.
* `chaos_monkey.sh` : A wrapper over the two monkeys. This wrapper randomly selects two things:
  * The production node on which the monkey event needs to be run
  * The monkey which needs to run : `restart_monkey.sh` or `stress_monkey.sh`
