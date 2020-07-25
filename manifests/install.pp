# @summary Installs required NRPE packages
#
# @api private
class nrpe::install {
  if $nrpe::manage_package {
    package { $nrpe::package_name:
      ensure   => installed,
      provider => $nrpe::provider,
    }
  }
}
