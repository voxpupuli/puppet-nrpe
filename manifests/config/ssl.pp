# @summary Configures SSL for NRPE
#
# @api private
class nrpe::config::ssl {
  $_ssl_client_certs = $nrpe::ssl_client_certs ? {
    'ask'     => '1',
    'require' => '2',
    default   => '0', # $ssl_client_certs = 'no'
  }

  concat::fragment { 'nrpe ssl fragment':
    target  => $nrpe::config,
    content => epp(
      'nrpe/nrpe.cfg-ssl.epp',
      {
        'ssl_version'           => $nrpe::ssl_version,
        'ssl_use_adh'           => $nrpe::ssl_use_adh,
        'ssl_ciphers'           => $nrpe::ssl_ciphers,
        'nrpe_ssl_dir'          => $nrpe::nrpe_ssl_dir,
        'ssl_client_certs'      => $_ssl_client_certs,
        'ssl_cert_file_content' => $nrpe::ssl_cert_file_content,
        'ssl_logging'           => nrpe::ssl_logging(
          $nrpe::ssl_log_startup_params,
          $nrpe::ssl_log_remote_ip,
          $nrpe::ssl_log_protocol_version,
          $nrpe::ssl_log_cipher,
          $nrpe::ssl_log_client_cert,
          $nrpe::ssl_log_client_cert_details
        )
      }
    ),
    order   => '02',
  }

  if $nrpe::ssl_cert_file_content {
    file { $nrpe::nrpe_ssl_dir:
      ensure => directory,
      owner  => 'root',
      group  => $nrpe::nrpe_group,
      mode   => '0750',
    }
    file { "${nrpe::nrpe_ssl_dir}/ca-cert.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe::nrpe_group,
      mode    => '0640',
      content => $nrpe::ssl_cacert_file_content,
    }
    file { "${nrpe::nrpe_ssl_dir}/nrpe-cert.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe::nrpe_group,
      mode    => '0640',
      content => $nrpe::ssl_cert_file_content,
    }
    file { "${nrpe::nrpe_ssl_dir}/nrpe-key.pem":
      ensure  => file,
      owner   => 'root',
      group   => $nrpe::nrpe_group,
      mode    => '0640',
      content => $nrpe::ssl_privatekey_file_content,
    }
  }
}
