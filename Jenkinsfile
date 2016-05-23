node ('virtualbox') {
  def directory = "localtime"
  stage 'Clean up'
  deleteDir()

  stage 'Checkout'
  sh "mkdir $directory"
  dir("$directory") {
    checkout scm
  }
  dir("$directory") {
    stage 'bundle'
    sh 'bundle install --path vendor/bundle'
    sh 'if vagrant box list | grep trombik/ansible-freebsd-10.3-amd64 >/dev/null; then echo "installed"; else vagrant box add trombik/ansible-freebsd-10.3-amd64; fi'

    stage 'bundle exec kitchen test'
    sh 'bundle exec kitchen test'

    stage 'bundle exec kitchen destroy'
    sh 'bundle exec kitchen destroy'

    stage 'Notify'
    step([$class: 'GitHubCommitNotifier', resultOnFailure: 'FAILURE'])
  }
}
