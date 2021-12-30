job('Whanos base images/whanos-python') {
    def name = "whanos-python"
    steps{
        shell("docker build -t ${name} /var/jenkins_home/images/python -f /var/jenkins_home/images/python/Dockerfile.base")
    }
}