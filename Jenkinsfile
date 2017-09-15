#!/usr/bin/env groovy


// Expose properties for a parameterized build
properties(
    [
        [ $class : 'ParametersDefinitionProperty', parameterDefinitions: [
                [
                    name: 'MIN_JENKINS_VERSION',
                    description: 'OCP Version to build',
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
                    name: 'PLUGIN_LIST_FILE',
                    description: 'File with the plugin list',
                    $class: 'hudson.model.FileParameterDefinition'
                ],
                [
                    name: 'TARGET_NODE',
                    description: 'Jenkins agent node',
                    $class: 'hudson.model.StringParameterDefinition',
                    defaultValue: 'openshift-build-1'
                ],
            ],
            disableConcurrentBuilds()
        ]
    ]
)



node(TARGET_NODE) {

            TEST = sh(returnStdout: true, script: "cat FILE").trim()

            echo "File:\n${TEST}"

}
