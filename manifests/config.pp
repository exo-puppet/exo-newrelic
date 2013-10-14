class newrelic::config {
  file { '/etc/newrelic/nrsysmond.cfg':
    content => template('newrelic/etc/newrelic/nrsysmond.cfg.erb'),
    path    => $newrelic::params::config_file,
    owner   => 'root',
    group   => $newrelic::params::group,
    mode    => '0640',
    require => Package [ 'newrelic-sysmond' ],
    notify  => Service['newrelic'],
  }
}
