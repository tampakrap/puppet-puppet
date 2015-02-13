class puppet::agent::config {

  Ini_setting {
    path    => $puppet::conf,
    section => 'agent',
    ensure  => 'present',
  }

  if defined(Service['puppet_agent']) {
    Ini_setting { notify  => Service['puppet_agent'] }
  }

  if $puppet::agent::ca_server {
    $real_ca_server = $puppet::agent::ca_server
  } else {
    $real_ca_server = $puppet::agent::server
  }

  if $puppet::agent::report_server {
    $real_report_server = $puppet::agent::report_server
  } else {
    $real_report_server = $puppet::agent::server
  }

  ini_setting {
    'server':
      section => 'main',
      setting => 'server',
      value   => $puppet::agent::server;
    'ca_server':
      section => 'main',
      setting => 'ca_server',
      value   => $real_ca_server;
    'report_server':
      section => 'main',
      setting => 'report_server',
      value   => $real_report_server;
    'pluginsync':
      setting => 'pluginsync',
      value   => $puppet::agent::pluginsync;
    'certname':
      setting => 'certname',
      value   => $puppet::agent::certname;
    'report':
      setting => 'report',
      value   => $puppet::agent::report;
    'environment':
      setting => 'environment',
      value   => $puppet::agent::environment;
    'show_diff':
      setting => 'show_diff',
      value   => $puppet::agent::showdiff;
    'splay':
      setting => 'splay',
      value   => $puppet::agent::splay;
    'configtimeout':
      setting => 'configtimeout',
      value   => $puppet::agent::configtimeout;
    'usecacheonfailure':
      setting => 'usecacheonfailure',
      value   => $puppet::agent::usecacheonfailure;
    'stringify_facts_agent':
      setting => 'stringify_facts',
      value   => $puppet::agent::stringify_facts;
  }
}
