pipeline {
    agent any

    tools {
        jdk "JDK21"
        maven "MAVEN3.9"
    }

    environment {
        NEXUS_VERSION       = "nexus3"
        NEXUS_PROTOCOL      = "http"
        NEXUSIP             = "172.31.27.151"
        NEXUSPORT           = "8081"
        NEXUS_REPOSITORY    = "maven-releases"
        NEXUS_REPOGRP_ID    = "vprofile-grp-repo"
        NEXUS_CREDENTIAL_ID = "nexuslogin"
        ARTVERSION          = "${env.BUILD_ID}"
    }

    stages {
        stage('Build') {
            steps {
                sh "mvn -s settings.xml -DskipTests install -DNEXUSIP=${NEXUSIP} -DNEXUSPORT=${NEXUSPORT} -DNEXUS-GRP-REPO=${NEXUS_REPOGRP_ID}"
            }
            post {
                success {
                    echo "Now Archiving."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }

        stage('Test') {
            steps {
                sh "mvn -s settings.xml test -DNEXUSIP=${NEXUSIP} -DNEXUSPORT=${NEXUSPORT} -DNEXUS-GRP-REPO=${NEXUS_REPOGRP_ID}"
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh "mvn -s settings.xml checkstyle:checkstyle -DNEXUSIP=${NEXUSIP} -DNEXUSPORT=${NEXUSPORT} -DNEXUS-GRP-REPO=${NEXUS_REPOGRP_ID}"
            }
        }
    }
}