################################################################################
#
#   This module deploys all resources required to setup a newrelic java agent
#
#   Tested platforms:
#    - Ubuntu 12.04
#
#
# == Modules Dependencies
#
# [+wget+]
#   the +wget+ puppet module is used to download the agent JAR
#
#
################################################################################
define newrelic::java (
  $present       = true,
  $app_name,
  $directory,
  $log_file_path = '',
  $user,
  $group,
  $version       = '3.4.2',
  $license_key,) {
  # modules dependencies
  include wget

  # The directory must exist
  File[$directory] ->
  wget::fetch { "download-newrelic-agent-${name}":
    source_url       => "http://repo.maven.apache.org/maven2/com/newrelic/agent/java/newrelic-agent/${version}/newrelic-agent-${version}.jar",
    target_directory => $directory,
    target_file      => "newrelic-agent-${version}.jar",
  } -> file { "${directory}/newrelic.jar":
    ensure => $present ? {
      true    => 'link',
      default => 'absent'
    },
    owner  => $user,
    group  => $group,
    mode   => 0644,
    target => "${directory}/newrelic-agent-${version}.jar",
  } -> file { "${directory}/newrelic.yml":
    ensure  => $present ? {
      true    => 'file',
      default => 'absent'
    },
    owner   => $user,
    group   => $group,
    mode    => 0600,
    content => template('newrelic/newrelic.yml.erb'),
  }
}
