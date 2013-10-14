class newrelic::install {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      # Add the NewRelic .deb repository
      repo::define { 'newrelic-repo':
        file_name    => 'newrelic',
        url          => 'http://apt.newrelic.com/debian/',
        distribution => 'newrelic',
        sections     => ['non-free'],
        source       => false,
        key          => '548C16BF',
        key_server   => 'keyserver.ubuntu.com',
        notify       => Exec['repo-update'],
      } ->
      # The package to install
      package { 'newrelic-sysmond':
        ensure  => $newrelic::present ? {
          true    => present,
          default => purged,
        },
        name    => $newrelic::params::package_name,
        require => [
          Repo::Define['newrelic-repo'],
          Exec['repo-update']],
      }
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
