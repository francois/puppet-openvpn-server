class openvpn::client ($server, $client_ip) {
  include openvpn::install

  file { "/etc/openvpn":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service[openvpn],
    owner   => root,
    group   => root,
    source  => "puppet:///modules/openvpn/client-configs",
  }

  file { "/etc/openvpn/net.conf":
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template("openvpn/client-net.erb"),
    notify  => Service[openvpn]
  }
}