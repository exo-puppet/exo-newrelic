class newrelic::service {
  require newrelic::config

  service { 'newrelic':
    ensure     => $newrelic::present ? {
      true    => running,
      default => stopped,
    },
    name       => $newrelic::params::service_name,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['newrelic::config'],
  }
}

