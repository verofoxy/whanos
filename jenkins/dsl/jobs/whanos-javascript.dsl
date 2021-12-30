job('Whanos base images/whanos-javascript') {
    def name = "whanos-javascript"
    steps{
        shell("docker build -t ${name} /var/jenkins_home/images/javascript -f /var/jenkins_home/images/javascript/Dockerfile.base")
    }
}