class newrelic::params {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      $service_name = 'newrelic-sysmond'
      $package_name = 'newrelic-sysmond'

      $config_file  = '/etc/newrelic/nrsysmond.cfg'

      $user         = 'newrelic'
      $group        = 'newrelic'
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
