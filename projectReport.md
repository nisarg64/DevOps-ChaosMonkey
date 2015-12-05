## Final Project Report

### Milestone 1 - BUILD
* For this milestone of our project, we set up a build server and used `Jenkins` as the CI tool to configure our build environment
* We set up post build steps such as sending email notifications in case of failed builds
* Each working `git` branch in our project source has a corresponding job on `Jenkins`
* A build ( and creation of a new Jenkins job, if committing from a new branch for the first time ) was triggeres using `post-commit` hooks
* Detailed work for M1 here : https://github.com/nkdalmia/devops-project/tree/M1

### Milestone 2 - TEST / ANALYSIS
* We used a couple of Jenkins plugins for the following requirements in this milestone
  * `JaCoCo plugin` for measuring and reporting the test coverage results
  * `FindBugs plugin` for static analysis of the project source and reporting (any) warnings
* We used a test suite generation framework, `Evosuite` for automated tests generation
* We implemented a custom checkstyle rule <>
* Using Jenkins, we setup thresholds for a build to fail if the current commits broke the minimum required testing coverage threshold.
* Git hooks were used to do the following :
  * `pre-commit` hook to detect for the presence of any security tokens / config keys
  * `post-commit` hook to reject commits if minimum testing coverage threshold was not met.
* Detailed work for M2 here : https://github.com/nkdalmia/devops-project/tree/M2

### Milestone 3 - DEPLOY
* Blue-Green deployment strategy was used for this milestone. We configured two hosts as the production hosts, one for the `blue` slice and the other one for the `green` slice
  * An `init.sh` script configured the production hosts automatically. Following were the tasks performed by this script:
    * Provision two nodes on Digital Ocean
    * Install required packages such as `git`, `maven`, `jdk` using an Ansible playbook
    * Setup bare `git` repositories on these two nodes
* `git push blue master` pushed the source to the blue slice and likewise for the green slice.
* `Nagios` was used to monitor remote production hosts.
* Detailed work for M3 here : https://github.com/okeashwin/DevOps_M3

### Milestone 4 - SPECIAL
* Implemented two different types of monkeys ( `restart-monkey` and `trainer-monkey`) to run on remote production hosts and send the results of these monkey events as email notifications
* Two random selections were made while executing the `chaos monkey` wrapper script:
  * Random selection of the production host on which a monkey script needs to be run
  * Random selection of the monkey script itself
* Detailed work for M4 here : https://github.com/nisarg64/DevOps-ChaosMonkey

### Link to the Final Video
* Following is the link to screencast of all the milestones : https://www.youtube.com/watch?v=MSokvD16yco




