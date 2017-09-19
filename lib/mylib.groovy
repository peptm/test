def init() {
    this.set_major()
    this.set_link()
}

def set_major() {
    this.jenkins_major = JENKINS_VERSION.tokenize('.')[0].toString()
}

def set_link() {
    env.MYLINK = "http://example.com/cgit/rpms/jenkins-${jenkins_major}-plugins/?h=rhaos-${OCP_RELEASE}-rhel-7"
}

return this
