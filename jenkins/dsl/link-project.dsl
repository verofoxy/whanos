job('link-project') {
    parameters {
        stringParam('GITHUB', null, 'Github repo [owner/name_of_repo]')
        stringParam('DOCKER', null , 'Name Docker image')
        stringParam('NAME',  null , 'Name of the job')
    }

    steps {
        dsl {
            text('''
                job ("Projects/\$NAME") {
                    wrappers {
                        preBuildCleanup()
                    }

                    scm{
                        git {
                            remote {
                                github("\$GITHUB")
                            }
                        }
                    }

                    
                    triggers {
                        scm("* * * * *")
                    }

                    steps {
                        shell ('bash -c /file_checker.sh')
                        conditionalSteps {
                            condition {
                                fileExists('Makefile', BaseDir.WORKSPACE)
                            }
                            steps {
                                // BASED IMAGE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        fileExists('Dockerfile', BaseDir.WORKSPACE)
                                    }
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f Dockerfile .")
                                    }
                                }
                                // STANDALONE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        not {
                                            fileExists('Dockerfile', BaseDir.WORKSPACE)
                                        }
                                    }
                                // DOCKER BUILD 
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f /var/jenkins_home/images/c/Dockerfile.standalone .")
                                    }
                                }
                               
                            }
                        }

                        conditionalSteps {
                            condition {
                                fileExists('requirements.txt', BaseDir.WORKSPACE)
                            }
                            steps {
                                // BASED IMAGE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        fileExists('Dockerfile', BaseDir.WORKSPACE)
                                    }
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f Dockerfile .")
                                    }
                                }
                                // STANDALONE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        not {
                                            fileExists('Dockerfile', BaseDir.WORKSPACE)
                                        }
                                    }
                                // DOCKER BUILD 
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f /var/jenkins_home/images/python/Dockerfile.standalone .")
                                    }
                                }
                               
                            }
                        }

                        conditionalSteps {
                            condition {
                                fileExists('app/pom.xml', BaseDir.WORKSPACE)
                            }
                            steps {
                                // BASED IMAGE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        fileExists('Dockerfile', BaseDir.WORKSPACE)
                                    }
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f Dockerfile .")
                                    }
                                }
                                // STANDALONE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        not {
                                            fileExists('Dockerfile', BaseDir.WORKSPACE)
                                        }
                                    }
                                // DOCKER BUILD 
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f /var/jenkins_home/images/java/Dockerfile.standalone .")
                                    }
                                }
                               
                            }
                        }

                        conditionalSteps {
                            condition {
                                fileExists('package.json', BaseDir.WORKSPACE)
                            }
                            steps {
                                // BASED IMAGE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        fileExists('Dockerfile', BaseDir.WORKSPACE)
                                    }
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f Dockerfile .")
                                    }
                                }
                                // STANDALONE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        not {
                                            fileExists('Dockerfile', BaseDir.WORKSPACE)
                                        }
                                    }
                                // DOCKER BUILD 
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f /var/jenkins_home/images/javascript/Dockerfile.standalone .")
                                    }
                                }
                               
                            }
                        }

                        conditionalSteps {
                            condition {
                                fileExists('app/main.bf', BaseDir.WORKSPACE)
                            }
                            steps {
                                // BASED IMAGE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        fileExists('Dockerfile', BaseDir.WORKSPACE)
                                    }
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f Dockerfile .")
                                    }
                                }
                                // STANDALONE CONTAINERIZATION
                                conditionalSteps {
                                    condition {
                                        not {
                                            fileExists('Dockerfile', BaseDir.WORKSPACE)
                                        }
                                    }
                                // DOCKER BUILD 
                                    steps {
                                        shell("docker build -t $DOCKER:latest -f /var/jenkins_home/images/befunge/Dockerfile.standalone .")
                                    }
                                }
                            }

                        }

                     // DOCKER REGISTRY PUBLISHMENT
                        shell("docker image tag $DOCKER:latest docker:5000/$DOCKER:latest")
                        shell("docker push docker:5000/$DOCKER:latest")


                    // // K8S DEPLOYMENT    
                    //     shell("sudo kubectl create -f /kubernetes/node.deployment.yaml")
                    //     shell("echo Pod is not running")

                    }
                }
            '''.stripIndent())
        }
    }
}

