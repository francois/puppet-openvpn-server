class openvpn::server($dh_file="/etc/openvpn/net/keys/dh1024.pem"){

  package { "openvpn":
    ensure => installed,
  }

  service { "openvpn":
    ensure  => "running",
    require => Package[openvpn],
  }

  exec { "openvpn_dh":
    command => "/usr/bin/openssl dhparam -out $dh_file 1024",
    creates => $dh_file,
    require => File["/etc/openvpn"],
  }

  file { "/etc/openvpn":
    ensure  => directory,
    recurse => true,
    purge   => false,
    force   => false,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/openvpn_server/configs",
    notify  => Service[openvpn],
  }

  file { "/etc/openvpn/net.conf":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template("openvpn/server/net.erb"),
    notify  => Service[openvpn]
  }
}
