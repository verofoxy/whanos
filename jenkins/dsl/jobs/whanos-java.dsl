job('Whanos base images/whanos-java') {
    def name = "whanos-java"
    steps{
        shell("docker build -t ${name} /var/jenkins_home/images/java -f /var/jenkins_home/images/java/Dockerfile.base")
    }
}