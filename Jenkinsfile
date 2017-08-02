// bundle exec kitchen list | tail -n +2 | cut -d ' '  -f 1
def vmsToBuild = 'default-freebsd-103-amd64 default-openbsd-60-amd64 default-ubuntu-1404-amd64 default-centos-72-x86-64'.split(' ')

def stepsForParallel = [:]

// The standard 'for (String s: stringsToEcho)' syntax also doesn't work, so we
// need to use old school 'for (int i = 0...)' style for loops.
for (int i = 0; i < vmsToBuild.size(); i++) {
  // Get the actual string here.
  def vm = vmsToBuild[i]

  // Transform that into a step and add the step to the map as the value, with
  // a name for the parallel step as the key. Here, we'll just use something
  // like "echoing (string)"
  def stepName = "testing ${vm}"

  stepsForParallel[stepName] = node('virtualbox') {

    def directory = "ansible-role-localtime"
    env.ANSIBLE_VAULT_PASSWORD_FILE = "~/.ansible_vault_key"
    stage 'Clean up'
    deleteDir()

    stage 'Checkout'
    sh "mkdir $directory"
    dir("$directory") {
      try {
        checkout scm
        sh "git submodule update --init"
      } catch (e) {
        currentBuild.result = 'FAILURE'
        notifyBuild(currentBuild.result)
        throw e
      }
    }
    dir("$directory") {
      stage 'bundle'
      try {
        sh "bundle install --path ${env.JENKINS_HOME}/vendor/bundle"
      } catch (e) {
        currentBuild.result = 'FAILURE'
        notifyBuild(currentBuild.result)
        throw e
      }

      stage "bundle exec kitchen test ${vm}"
      try {
        sh "bundle exec kitchen test ${vm}"
      } catch (e) {
        currentBuild.result = 'FAILURE'
        notifyBuild(currentBuild.result)
        throw e
      } finally {
        sh "bundle exec kitchen destroy ${vm}"
      }
  /* if you have integration tests, uncomment the stage below
      stage 'integration'
      try {
        // use native rake instead of bundle exec rake
        // https://github.com/docker-library/ruby/issues/73
        sh 'rake test'
      } catch (e) {
        currentBuild.result = 'FAILURE'
        notifyBuild(currentBuild.result)
        throw e
      } finally {
        sh 'rake clean'
      }
  */
      stage 'Notify'
      notifyBuild(currentBuild.result)
      step([$class: 'GitHubCommitNotifier', resultOnFailure: 'FAILURE'])
    }
  }
}

// Actually run the steps in parallel - parallel takes a map as an argument,
// hence the above.
parallel stepsForParallel

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} build #${env.BUILD_NUMBER}'"
  def summary = "${subject} <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a>"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  hipchatSend (color: color, notify: true, message: summary)
}
/* vim: ft=groovy */
