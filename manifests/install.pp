# @summary Installs required NRPE packages
#
# @api private
class nrpe::install {
  if $nrpe::manage_package {
    # The classic way: install the daemon and plugins as defined by params.pp
    $packages_to_install = $nrpe::package_name
  } else {
    # The selective way: install the daemon and/or plugins, as requested by your parameters.
    if $nrpe::manage_package_daemon {
      $_daemon_pkgs = [] + $nrpe::package_name_daemon
    } else {
      $_daemon_pkgs = []
    }
    if $nrpe::manage_package_plugins {
      $_plugins_pkgs = [] + $nrpe::package_name_plugins
    } else {
      $_plugins_pkgs = []
    }
    $packages_to_install = $_daemon_pkgs + $_plugins_pkgs
  }

  package { $packages_to_install:
    ensure   => installed,
    provider => $nrpe::provider,
  }
}
