# @summary Installs required NRPE packages
#
# @api private
class nrpe::install {
  if $nrpe::manage_package {
    ensure_packages($nrpe::package_name,
      {
        ensure   => installed,
        provider => $nrpe::provider,
      }
    )
  }
  if $nrpe::manage_package_daemon {
    ensure_packages($nrpe::package_name_daemon,
      {
        ensure   => installed,
        provider => $nrpe::provider,
      }
    )
  }
  if $nrpe::manage_package_plugins {
    ensure_packages($nrpe::package_name_plugins,
      {
        ensure   => installed,
        provider => $nrpe::provider,
      }
    )
  }
}
