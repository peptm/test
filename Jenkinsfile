#!/usr/bin/env groovy

properties(
    [
        [ $class : 'ParametersDefinitionProperty', parameterDefinitions: [
                [
                    name: 'JENKINS_VERSION',
                    description: 'Minimum required Jenkins version',
                    $class: 'hudson.model.StringParameterDefinition'
                    // Probably better it this was a choice, but might not be
                    // flexible enough
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
                    name: 'MAIL_LIST_SUCCESS',
                    description: 'Success Mailing List',
                    $class: 'hudson.model.StringParameterDefinition',
                    defaultValue: 'FIXME: failure list'
                ],
                [
                    name: 'MAIL_LIST_FAILURE',
                    description: 'Failure Mailing List',
                    $class: 'hudson.model.StringParameterDefinition',
                    defaultValue: 'FIXME: failure list'
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

def mail_success() {

    jenkins_major = { JENKINS_VERSION.split(".")[0] }

    distgit_link = "http://pkgs.devel.redhat.com/cgit/rpms/jenkins-${jenkins_major}-plugins/?h=rhaos-${OCP_RELEASE}-rhel-7"

    echo """SUCCESS!
        to: "${MAIL_LIST_SUCCESS}",
        from: "aos-cd@redhat.com",
        replyTo: 'jupierce@redhat.com',
        subject: "jenkins plugins RPM updated in dist-git",
        body: The Jenkins plugins RPM for OCP ${OCP_RELEASE} has been updated in dist-git:
${distgit_link}

Jenkins version: ${JENKINS_VERSION}

Plugin list:
${PLUGIN_LIST}

Plugin RPM update job: ${env.BUILD_URL}
"""
}

def mail_failure(err) {

    echo """FAILURE!
        to: "${MAIL_LIST_FAILURE}",
        from: "aos-cd@redhat.com",
        replyTo: 'jupierce@redhat.com',
        subject: "Error during jenkins plugin RPM update on dist-git",
        body: The job to update the jenkins plugins RPM in dist-git encountered an error:
${err}

Jenkins job: ${env.BUILD_URL}
"""
}

node() {

    checkout scm

    try {
        stage ("prepare workspace") {

            scripts_dir = "${env.WORKSPACE}/hacks/update-jenkins-plugins"
            tmpdir = "${env.WORKSPACE}/jenkins-plugins-job"
            plugin_file = "${tmpdir}/plugins.txt"
            // Note that collect-jenkins-plugins.sh has a hardcoded output dir:
            plugin_dir = "${scripts_dir}/working_hpis"

            echo "Adding the plugin scripts directory (${scripts_dir}) to PATH"
            env.PATH = "${scripts_dir}:${env.PATH}"

            sh "mkdir -p ${tmpdir}"
            writeFile file: plugin_file, text: PLUGIN_LIST
        }

        stage ("collect plugins") {
            sh "collect-jenkins-plugins.sh ${JENKINS_VERSION} ${plugin_file}"
        }

        stage ("update dist-git") {
            sh "update-dist-git.sh ${JENKINS_VERSION} ${OCP_RELEASE} ${plugin_dir}"
        }

        mail_success()

    } catch (err) {

        mail_failure(err)

        // Re-throw the error in order to fail the job
        throw err
    }
}
