# @summary Manages the NRPE service
#
# @api private
class nrpe::service {
  service { $nrpe::service_name:
    ensure => running,
    enable => true,
  }
}
