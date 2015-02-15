class puppet::server::config {

  include puppet::params

  Ini_setting {
    path    => $puppet::conf,
    ensure  => 'present',
    section => 'master',
    notify  => Service[$puppet::server::service],
  }

  if $puppet::server::servertype == 'standalone' and $puppet::server::bindaddress {
    $bindaddress_ensure = 'present'
  } else {
    $bindaddress_ensure = 'absent'
  }

  if $puppet::server::directoryenvs {
    if $puppet::server::environmentpath {
      $environmentpath_ensure = 'present'
    } else {
      $environmentpath_ensure = 'absent'
    }

    if $puppet::server::basemodulepath {
      $basemodulepath_ensure = 'present'
    } else {
      $basemodulepath_ensure = 'absent'
    }

    if $puppet::server::default_manifest {
      $default_manifest_ensure = 'present'
    } else {
      $default_manifest_ensure = 'absent'
    }

    $manifest_ensure       = 'absent'
    $modulepath_ensure     = 'absent'
    $config_version_ensure = 'absent'
  } else {
    if $puppet::server::manifest {
      $manifest_ensure = 'present'
    } else {
      $manifest_ensure = 'absent'
    }

    if $puppet::server::modulepath {
      $modulepath_ensure = 'present'
    } else {
      $modulepath_ensure = 'absent'
    }

    if $puppet::server::config_version {
      $config_version_ensure = 'present'
    } else {
      $config_version_ensure = 'absent'
    }

    $environmentpath_ensure  = 'absent'
    $basemodulepath_ensure   = 'absent'
    $default_manifest_ensure = 'absent'
  }

  if $puppet::server::ssl_client_header {
    $ssl_client_ensure = 'present'
  } else {
    $ssl_client_ensure = 'absent'
  }

  if $puppet::server::autosign {
    $autosign_ensure = 'present'
  } else {
    $autosign_ensure = 'absent'
  }

  if $puppet::server::dns_alt_names {
    $dns_alt_names_ensure = 'present'
  } else {
    $dns_alt_names_ensure = 'absent'
  }

  if $puppet::server::parser {
    $parser_ensure = 'present'
  } else {
    $parser_ensure = 'absent'
  }

  if $puppet::server::reports {
    $reports_ensure = 'present'
  } else {
    $reports_ensure = 'absent'
  }

  if $puppet::server::reporturl {
    $reporturl_ensure = 'present'
  } else {
    $reporturl_ensure = 'absent'
  }

  ini_setting {
    'bindaddress':
      ensure  => $bindaddress_ensure,
      setting => 'bindaddress',
      value   => $puppet::server::bindaddress;
    'environmentpath':
      ensure  => $environmentpath_ensure,
      setting => 'environmentpath',
      value   => $puppet::server::environmentpath;
    'basemodulepath':
      ensure  => $basemodulepath_ensure,
      setting => 'basemodulepath',
      value   => join(flatten([$puppet::server::basemodulepath]), ':');
    'default_manifest':
      ensure  => $default_manifest_ensure,
      setting => 'default_manifest',
      value   => $puppet::server::default_manifest;
    'modulepath':
      ensure  => $modulepath_ensure,
      setting => 'modulepath',
      value   => join(flatten([$puppet::server::modulepath]), ':');
    'manifest':
      ensure  => $manifest_ensure,
      setting => 'manifest',
      value   => $puppet::server::manifest;
    'config_version':
      ensure  => $config_version_ensure,
      setting => 'config_version',
      value   => $puppet::server::config_version;
    'user':
      setting => 'user',
      value   => $puppet::params::puppet_user;
    'group':
      setting => 'group',
      value   => $puppet::params::puppet_group;
    'ca':
      setting => 'ca',
      value   => $puppet::server::ca;
    'ssl_client_header':
      ensure  => $ssl_client_ensure,
      setting => 'ssl_client_header',
      value   => 'HTTP_X_CLIENT_DN';
    'ssl_client_verify_header':
      ensure  => $ssl_client_ensure,
      setting => 'ssl_client_verify_header',
      value   => 'HTTP_X_CLIENT_VERIFY';
    'autosign':
      ensure  => $autosign_ensure,
      setting => 'autosign',
      value   => $puppet::server::autosign;
    'dns_alt_names':
      ensure  => $dns_alt_names_ensure,
      setting => 'dns_alt_names',
      value   => join(flatten([$puppet::server::dns_alt_names ]), ', ');
    'parser':
      ensure => $parser_ensure,
      setting => 'parser',
      value   => $puppet::server::parser;
    'reports':
      ensure  => $reports_ensure,
      setting => 'reports',
      value   => join(flatten([ $puppet::server::reports ]), ', ');
    'reporturl':
      ensure  => $reporturl_ensure,
      setting => 'reporturl',
      value   => $puppet::server::reporturl;
  }

  if $puppet::server::enc == 'exec' {
    ini_setting {
      'node_terminus':
        setting => 'node_terminus',
        value   => 'exec';
      'external_nodes':
        setting => 'external_nodes',
        value   => $puppet::server::enc_exec;
    }
  }
}
