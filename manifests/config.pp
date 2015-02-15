class puppet::config {

  Ini_setting {
    path    => $puppet::conf,
    ensure  => 'present',
    section => 'main',
  }

  $srv_ensure = $puppet::use_srv_records ? {
    true  => 'present',
    false => 'absent',
  }

  ini_setting {
    'logdir':
      setting => 'logdir',
      value   => $puppet::logdir;
    'vardir':
      setting => 'vardir',
      value   => $puppet::vardir;
    'ssldir':
      setting => 'ssldir',
      value   => $puppet::ssldir;
    'rundir':
      setting => 'rundir',
      value   => $puppet::rundir;
    'use_srv_records':
      ensure  => $srv_ensure,
      setting => 'use_srv_records',
      value   => $puppet::use_srv_records;
    'srv_domain':
      ensure  => $srv_ensure,
      setting => 'srv_domain',
      value   => $puppet::srv_domain;
  }
}
