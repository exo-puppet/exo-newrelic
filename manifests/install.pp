class newrelic::install {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      # Add the NewRelic .deb repository
      apt::source { 'newrelic':
        location => 'http://apt.newrelic.com/debian/',
        release  => 'newrelic',
        repos    => 'non-free',
        key      => {
          'id'     => 'B60A3EC9BC013B9C23790EC8B31B29E5548C16BF',
          'server' => 'keyserver.ubuntu.com',
        },
        include  => {
          'src' => false,
          'deb' => true,
        },
      }
      # The package to install
      ensure_packages ( 'newrelic-sysmond', {
        'ensure'  => $newrelic::present ? {
          true    => present,
          default => purged,
        },
        'name'    => $newrelic::params::package_name,
        'require' => [Apt::Source['newrelic'],Class['apt::update']],
      } )
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
