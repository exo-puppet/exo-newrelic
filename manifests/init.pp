# Class: newrelic_server_monitor
#
#   This module manage the New Relic Server Monitor.
#
# Parameters:
#
#  [*license_key*] - The license key supplied by New Relic on the instructions
#                    page for setting up a new Server Monitor instance.
#
# Sample Usage:
#   # Install NewRelic server monitoring system
#   class { 'newrelic_server_monitor':
#     present     => true,
#     license_key => 'YOUR_LICENSE_KEY',
#   }
#
#   # Uninstall NewRelic server monitoring system
#   class { 'newrelic_server_monitor':
#     present     => false,
#   }
#
class newrelic (
  $present     = true,
  $license_key = undef,) {
  if $license_key == undef {
    fail('The license_key parameter must be defined.')
  }

  include newrelic::params, newrelic::install, newrelic::config, newrelic::service

}
