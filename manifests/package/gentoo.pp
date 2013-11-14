class puppet::package::gentoo {

  include puppet::params
  include puppet::agent

  package_use { 'sys-apps/net-tools':
    use    => 'old-output',
    target => 'puppet',
  }

  if $::puppet_master {
    include puppet::server
    $keywords = $puppet::server::gentoo_keywords
    $package  = $puppet::params::master_package
    $use      = $puppet::server::gentoo_use
    $ensure   = $puppet::server::ensure
  } else {
    $keywords = $puppet::agent::gentoo_keywords
    $package  = $puppet::params::agent_package
    $use      = $puppet::agent::gentoo_use
    $ensure   = $puppet::agent::ensure
  }

  portage::package { $package:
    keywords => $keywords,
    use      => $use,
    target   => 'puppet',
    ensure   => $ensure,
  }
}
