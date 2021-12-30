job('Whanos base images/whanos-befunge') {
    def name = "whanos-befunge"
    steps{
        shell("docker build -t ${name} /var/jenkins_home/images/befunge -f /var/jenkins_home/images/befunge/Dockerfile.base")
    }
}