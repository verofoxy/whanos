job('Whanos base images/whanos-c') {
    def name = "whanos-c"
    steps{
        shell("docker build -t ${name} /var/jenkins_home/images/c -f /var/jenkins_home/images/c/Dockerfile.base")
    }
}