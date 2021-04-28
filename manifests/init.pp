# @summary Installs and configures NRPE
#
# @example Basic usage
#   class { 'nrpe':
#     allowed_hosts => [
#       '127.0.0.1',
#       'nagios.example.org',
#     ],
#   }
#
# @see https://github.com/NagiosEnterprises/nrpe
#
# @example With SSL
#   class { 'nrpe':
#     allowed_hosts               => 'nagios.example.org',
#     ssl_cert_file_content       => file('profile/ssl/nagios.example.org.crt'),
#     ssl_privatekey_file_content => file('profile/ssl/nagios.example.org.key'),
#     ssl_cacert_file_content     => file('profile/ssl/GeoTrust_RSA_CA_2018.crt'),
#     ssl_client_certs            => 'require',
#   }
#
# @see https://github.com/NagiosEnterprises/nrpe/blob/master/README.SSL.md
#
# @param allowed_hosts
#   Specifies the hosts that NRPE will accept connections from.
# @param server_address
#   Specifies the IP address of the inteface that NRPE should bind to. Useful when the system has more than one interface.
# @param commands
#   A Hash of `nrpe::command` resources you want to create.  Recommended when you want to define `nrpe::command`s in hiera data.
# @param plugins
#   A Hash of `nrpe::plugin` resources you want to create.  Recommended when you want to define `nrpe::plugin`s in hiera data.
# @param command_timeout
#   Specifies the maximum number of seconds that the NRPE daemon will allow plugins to finish executing before killing them off.
# @param package_name
#   The package name or array of package names that will be installed. The default is often fine, but you may wish to set this to install extra packages like `nrpe-selinux`.
# @param manage_package
#   By default, set to `true` and the `nrpe` class will manage the OS package(s).
# @param purge
#   When set to true, the module will purge any unmanaged commands from the NRPE includedir.
# @param dont_blame_nrpe
#   Determines whether or not the NRPE daemon will allow clients to specify arguments to commands that are executed. ENABLING THIS OPTION IS A SECURITY RISK!
# @param log_facility
#   The syslog facility that should be used for logging purposes.
# @param server_port
#   The port that NRPE should listen for connections on.
# @param command_prefix
#   This option allows you to prefix all commands with a user-defined string.  Although often used to run all commands with sudo, `nrpe::command` has dedicated `sudo` parameters for this.
# @param debug
#   This option determines whether or not debugging messages are logged to the syslog facility.
# @param connection_timeout
#   Specifies the maximum number of seconds that the NRPE daemon will wait for a connection to be established before exiting.
# @param allow_weak_random_seed
#   Determines whether or not the NRPE daemon will use weak sources of randomness
# @param allow_bash_command_substitution
#   Determines whether or not the NRPE daemon will allow clients to specify arguments that contain bash command substitutions of the form `$(...)`. ** ENABLING THIS OPTION IS A HIGH SECURITY RISK! **
# @param nrpe_user
#   Determines the effective user that the NRPE daemon should run as.
# @param nrpe_group
#   Determines the effective group that the NRPE daemon should run as.
# @param nrpe_pid_file
#   The name of the file in which the NRPE daemon should write it's process ID number.
# @param command_file_default_mode
#   The default file mode to use when creating NRPE command files in the includedir.
# @param supplementary_groups
#   If set, the `nrpe_user` will be added to these supplementary groups.
# @param nrpe_ssl_dir
#   The directory that SSL certificates and keys will be created in.
# @param ssl_cert_file_content
#   A string containing the SSL Certificate.
# @param ssl_privatekey_file_content
#   A string containing the SSL private **KEY**.  It is recommended to source this parameter from hiera and use EYAML or similar to encrypt the data.
# @param ssl_cacert_file_content
#   A string containing the SSL CA Cert file contents.
# @param ssl_version
#   The SSL Version to use.  The default of `TLSv1.2+` is the most secure option available at time of writing.  Avoid having to set it to a lower value if possible.
# @param ssl_ciphers
#   An array of ciphers that should be allowed by NRPE.  The defaults are for RSA keys and were taken from https://github.com/ssllabs/research/wiki/SSL-and-TLS-Deployment-Best-Practices.
# @param ssl_client_certs
#   This options determines client certificate usage.
# @param ssl_log_startup_params
#   Whether to log startup SSL/TLS parameters.
# @param ssl_log_remote_ip
#   Whether to log remote IP address of SSL client.
# @param ssl_log_protocol_version
#   Whether to log SSL/TLS version of connections.
# @param ssl_log_cipher
#   Whether to log which encryption cipher is being used for SSL connections.
# @param ssl_log_client_cert
#   Whether to log if an SSL client has presented a certificate.
# @param ssl_log_client_cert_details
#   Whether to log details of client SSL certificates.
# @param manage_pid_dir
#   Whether to manage the directory where the PID file should exist.
# @param config
#   **Private** You should not need to override this parameter.
# @param include_dir
#   **Private** You should not need to override this parameter.
# @param provider
#   **Private** You should not need to override this parameter.
# @param service_name
#   **Private** You should not need to override this parameter.
class nrpe (
  Array[Variant[Stdlib::Fqdn,Stdlib::IP::Address]]                  $allowed_hosts                   = ['127.0.0.1'],
  Stdlib::IP::Address                  $server_address                  = '0.0.0.0',
  Hash                                 $commands                        = {},
  Hash                                 $plugins                         = {},
  Integer[0]                           $command_timeout                 = 60,
  Variant[String[1], Array[String[1]]] $package_name                    = $nrpe::params::nrpe_packages,
  Boolean                              $manage_package                  = true,
  Boolean                              $purge                           = false,
  Boolean                              $dont_blame_nrpe                 = $nrpe::params::dont_blame_nrpe,
  Nrpe::Syslogfacility                 $log_facility                    = $nrpe::params::log_facility,
  Stdlib::Port::Unprivileged           $server_port                     = $nrpe::params::server_port,
  Optional[Stdlib::Absolutepath]       $command_prefix                  = $nrpe::params::command_prefix,
  Boolean                              $debug                           = $nrpe::params::debug,
  Integer[0]                           $connection_timeout              = $nrpe::params::connection_timeout,
  Boolean                              $allow_weak_random_seed          = $nrpe::params::allow_weak_random_seed,
  Optional[Boolean]                    $allow_bash_command_substitution = $nrpe::params::allow_bash_command_substitution,
  String[1]                            $nrpe_user                       = $nrpe::params::nrpe_user,
  String[1]                            $nrpe_group                      = $nrpe::params::nrpe_group,
  Stdlib::Absolutepath                 $nrpe_pid_file                   = $nrpe::params::nrpe_pid_file,
  Stdlib::Absolutepath                 $nrpe_ssl_dir                    = $nrpe::params::nrpe_ssl_dir,
  Optional[String[1]]                  $ssl_cert_file_content           = undef,
  Optional[String[1]]                  $ssl_privatekey_file_content     = undef,
  Optional[String[1]]                  $ssl_cacert_file_content         = undef,
  Nrpe::Sslversion                     $ssl_version                     = $nrpe::params::ssl_version,
  Array[String[1]]                     $ssl_ciphers                     = $nrpe::params::ssl_ciphers,
  Enum['no','ask','require']           $ssl_client_certs                = $nrpe::params::ssl_client_certs,
  Boolean                              $ssl_log_startup_params          = false,
  Boolean                              $ssl_log_remote_ip               = false,
  Boolean                              $ssl_log_protocol_version        = false,
  Boolean                              $ssl_log_cipher                  = false,
  Boolean                              $ssl_log_client_cert             = false,
  Boolean                              $ssl_log_client_cert_details     = false,
  Stdlib::Filemode                     $command_file_default_mode       = '0644',
  Array[String[1]]                     $supplementary_groups            = [],
  Boolean                              $manage_pid_dir                  = false,

  # Private parameters.  You shouldn't need to override these.
  Stdlib::Absolutepath                 $config                          = $nrpe::params::nrpe_config,
  Stdlib::Absolutepath                 $include_dir                     = $nrpe::params::nrpe_include_dir,
  Optional[String[1]]                  $provider                        = $nrpe::params::nrpe_provider,
  String[1]                            $service_name                    = $nrpe::params::nrpe_service,
) inherits nrpe::params {
  # Extra validation
  if $ssl_cert_file_content {
    assert_type(String[1], $ssl_privatekey_file_content)
    assert_type(String[1], $ssl_cacert_file_content)
  }

  contain nrpe::install
  contain nrpe::config
  contain nrpe::service

  Class['nrpe::install']
  -> Class['nrpe::config']
  ~> Class['nrpe::service']

  $commands.each |String $key, Hash $attrs| {
    nrpe::command { $key:
      * => $attrs,
    }
  }
  $plugins.each |String $key, Hash $attrs| {
    nrpe::plugin { $key:
      * => $attrs,
    }
  }

  Class['nrpe::install'] -> Nrpe::Plugin <||>
  Class['nrpe::install'] -> Nrpe::Command <||> ~> Class['nrpe::service']
}
