#!/usr/bin/env groovy


// Expose properties for a parameterized build
properties(
    [
        [ $class : 'ParametersDefinitionProperty', parameterDefinitions: [
                [
                    name: 'JENKINS_VERSION',
                    description: 'Minimum required Jenkins version',
                    $class: 'hudson.model.ChoiceParameterDefinition',
                    choices: "FIXME",
                    defaultValue: '3.7'
                ],
                [
                    name: 'OCP_RELEASE',
                    description: 'OCP target release',
                    $class: 'hudson.model.ChoiceParameterDefinition',
                    choices: "3.7\n3.6\n3.5\n3.4\n3.3",
                    defaultValue: '3.7'
                ],
                [
                    name: 'PLUGIN_LIST',
                    description: 'List of plugin:version to include, one per line',
                    $class: 'hudson.model.TextParameterDefinition'
                ],
                [
                    name: 'TARGET_NODE',
                    description: 'Jenkins agent node',
                    $class: 'hudson.model.StringParameterDefinition',
                    defaultValue: 'openshift-build-1'
                ],
            ]
        ],
        disableConcurrentBuilds()
    ]
)



node() {

    workdir = "jenkins-plugins"
    plugin_file = "${workdir}/plugins.txt"

    stage ("prepare workspace") {
        sh "mkdir ${workdir}"
        writeFile file: plugin_file, text: PLUGIN_LIST
    }

    stage ("collect plugins") {
        sh "scripts/collect-jenkins-plugins.sh ${JENKINS_VERSION} ${plugin_file}"
    }

    stage ("update dist-git") {
        sh "scripts/update-dist-git.sh ${JENKINS_VERSION} ${OCP_RELEASE} ${workdir}/working/hpis"
    }

}
