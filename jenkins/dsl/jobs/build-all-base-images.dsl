multiJob('Whanos base images/Build all base images') {
    steps {
        phase('Whanos base images/whanos-c', "SUCCESSFUL") { 
            phaseJob("Whanos base images/whanos-c")
        }
        
        phase('Whanos base images/whanos-python', "SUCCESSFUL") { 
            phaseJob("Whanos base images/whanos-python")
        }

        phase('Whanos base images/whanos-java', "SUCCESSFUL") { 
            phaseJob("Whanos base images/whanos-java")
        }

        phase('Whanos base images/whanos-javascript', "SUCCESSFUL") { 
            phaseJob("Whanos base images/whanos-javascript")
        }

        phase('Whanos base images/whanos-befunge', "SUCCESSFUL") { 
            phaseJob("Whanos base images/whanos-befunge")
        }
    }
}