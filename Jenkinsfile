pipeline {
  agent {

        kubernetes {
yaml """
apiVersion: v1
kind: Pod
metadata:
  name: jenkins-slave
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:4.10-3-jdk11
    imagePullPolicy: IfNotPresent
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: IfNotPresent
    command:
      - /busybox/sh
      - "-c"
    args:
      - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
    - name: jenkins-docker-cfg
      projected:
        sources:
        - secret:
            name: externalregistry
            items:
              - key: .dockerconfigjson
                path: config.json
  restartPolicy: Never
  nodeSelector:
    kubernetes.io/arch: amd64
  imagePullSecrets:
    - name: externalregistry
"""
    idleMinutes 10
    }
  }
    
  environment {
    TARGET_REGISTRY = "ghcr.io/eve-online-tools"
  }

  stages {
    stage('create & push docker-image') {
        steps {        
          container('kaniko') {
              sh "/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination $TARGET_REGISTRY/dind-buildx:0.3 --cleanup"
          }
        }
      }
  }
}
