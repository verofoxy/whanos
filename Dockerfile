# FROM jenkins/jenkins:latest

# USER root

# RUN apt-get update && apt-get install -y lsb-release
# RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
#   https://download.docker.com/linux/debian/gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) \
#   signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
#   https://download.docker.com/linux/debian \
#   $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
# RUN apt-get update && apt-get install -y docker-ce-cli

# USER jenkins

# RUN jenkins-plugin-cli --plugins "blueocean:1.25.1 docker-workflow:1.26"

# ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# COPY jenkins/plugins.txt                        /usr/share/jenkins/ref/plugins.txt
# RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# COPY jenkins/casc.yaml          /var/jenkins_home/casc.yaml
# COPY jenkins/dsl/folder.dsl     /var/jenkins_home/folder.dsl

# COPY jenkins/dsl/jobs/          /var/jenkins_home/
# COPY ./images/                  /var/jenkins_home/images

# COPY jenkins/dsl/link-project.dsl /var/jenkins_home/link-project.dsl

# COPY --chown=jenkins jenkins/scripts /var/jenkins_home/scripts

# RUN chmod -R +x /var/jenkins_home/scripts








FROM  jenkins/jenkins:lts-jdk11

USER  root

RUN   apt-get update && apt-get install -y lsb-release
RUN   curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN   echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN   apt-get update && apt-get install -y docker-ce-cli


USER  jenkins

ENV   JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV   CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

COPY  jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN   /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY jenkins/casc.yaml          /var/jenkins_home/casc.yaml
COPY jenkins/dsl/folder.dsl     /var/jenkins_home/folder.dsl

COPY jenkins/dsl/jobs/          /var/jenkins_home/
COPY ./images/                  /var/jenkins_home/images

COPY jenkins/dsl/link-project.dsl /var/jenkins_home/link-project.dsl

COPY --chown=jenkins jenkins/scripts/file_checker.sh /file_checker.sh

USER root
RUN chmod +x /file_checker.sh

