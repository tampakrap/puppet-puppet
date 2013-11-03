class puppet::package {

  include puppet::params
  include puppet::agent

  if $puppet::agent::manage_repos {
    include puppet::package::repository
  }

  if $::operatingsystem == 'gentoo' {
    include puppet::package::gentoo
  } else {
    package { $puppet::params::agent_package:
      ensure => $puppet::agent::ensure;
    }

    if $::puppet_master and $puppet::params::master_package != $puppet::params::agent_package {
      include puppet::server
      package { $puppet::params::master_package:
        ensure => $puppet::server::ensure;
      }
    }
  }

  # Fixes a bug. #12813
  class { '::puppet::package::patches': }
}
