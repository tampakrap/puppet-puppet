class puppet::server::config {

  include puppet

  Ini_setting {
    path    => $puppet::conf,
    ensure  => 'present',
    section => 'master',
    notify  => Service[$puppet::server::service],
  }

  if $puppet::server::directoryenvs == true {
    validate_string($puppet::server::environmentpath)
    validate_string($puppet::server::default_manifest)

    $env_ensure              = 'present'
    $basemod_ensure          = 'present'
    $default_manifest_ensure = 'present'

    # Remove deprecated settings
    $mod_ensure            = 'absent'
  } else {
    $env_ensure              = 'absent'
    $basemod_ensure          = 'absent'
    $default_manifest_ensure = 'absent'

    # Leave deprecated settings in place
    $mod_ensure            = 'present'
  }

  ini_setting {
    'environmentpath':
      ensure  => $env_ensure,
      setting => 'environmentpath',
      value   => $puppet::server::environmentpath;

    'basemodulepath':
      ensure  => $basemod_ensure,
      setting => 'basemodulepath',
      value   => join(flatten([$puppet::server::basemodulepath]), ':');

    'default_manifest':
      ensure  => $default_manifest_ensure,
      setting => 'default_manifest',
      value   => $puppet::server::default_manifest;

    'modulepath':
      ensure  => $mod_ensure,
      setting => 'modulepath',
      value   => join(flatten([$puppet::server::modulepath]), ':');

    'manifest':
      ensure  => $mod_ensure,
      setting => 'manifest',
      value   => $puppet::server::manifest;

    'user':
      setting => 'user',
      value   => $puppet::user;
    'group':
      setting => 'group',
      value   => $puppet::group;

    'stringify_facts_master':
      setting => 'stringify_facts',
      section => 'main',
      value   => $puppet::server::stringify_facts;
  }

  ini_setting { 'ca':
    setting => 'ca',
    value   => $puppet::server::ca,
  }

  if $puppet::server::servertype == 'standalone' and $puppet::server::bindaddress {
    $bindaddress_ensure = 'present'
  } else {
    $bindaddress_ensure = 'absent'
  }

  ini_setting { 'bindaddress':
    ensure  => $bindaddress_ensure,
    setting => 'bindaddress',
    value   => $puppet::server::bindaddress,
  }

  if $puppet::server::ssl_client_header {
    $ssl_client_header_ensure = 'present'
  } else {
    $ssl_client_header_ensure = 'absent'
  }

  ini_setting { 'ssl_client_header':
    ensure  => $ssl_client_header_ensure,
    setting => 'ssl_client_header',
    value   => $puppet::server::ssl_client_header,
  }

  ini_setting { 'ssl_client_verify_header':
    ensure  => $ssl_client_header_ensure,
    setting => 'ssl_client_verify_header',
    value   => $puppet::server::ssl_client_verify_header,
  }

  ini_setting { 'reporturl':
    setting => 'reporturl',
    value   => $puppet::server::reporturl
  }

  if $puppet::server::reportfrom {
    $reportfrom_ensure = 'present'
  } else {
    $reportfrom_ensure = 'absent'
  }

  ini_setting { 'reportfrom':
    ensure => $reportfrom_ensure,
    setting => 'reportfrom',
    value   => $puppet::server::reportfrom;
  }

  unless empty($puppet::server::reports) {
    ini_setting { 'reports':
      setting => 'reports',
      value   => join(flatten([ $puppet::server::reports ]), ', '),
    }
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

  if $puppet::server::parser {
    ini_setting { 'parser':
        setting => 'parser',
        value   => $puppet::server::parser,
    }
  }

  if $puppet::server::dns_alt_names {
    $dns_alt_names_ensure = 'present'
  } else {
    $dns_alt_names_ensure = 'absent'
  }

  ini_setting { 'dns_alt_names':
    ensure  => $dns_alt_names_ensure,
    setting => 'dns_alt_names',
    value   =>  $puppet::server::dns_alt_names
  }

  if $puppet::server::autosign {
    ini_setting { 'autosign':
        setting => 'autosign',
        value   =>  $puppet::server::autosign
    }
  }

}
