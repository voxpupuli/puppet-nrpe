# @summary Manages the NRPE service
#
# @api private
class nrpe::service {
  if $nrpe::manage_pid_dir {
    $pid_dir = dirname($nrpe::nrpe_pid_file)

    if $nrpe::manage_package or $nrpe::manage_packages_daemon {
      $req_package = Package[$nrpe::package_name]
    } else {
      $req_package = undef
    }

    file { 'nrpe_pid_dir':
      ensure  => directory,
      before  => Service[$nrpe::service_name],
      group   => $nrpe::nrpe_group,
      owner   => $nrpe::nrpe_user,
      path    => $pid_dir,
      require => $req_package,
    }
  }

  service { $nrpe::service_name:
    ensure => running,
    enable => true,
  }
}
