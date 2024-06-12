# @summary Sets defaults based on OS
#
# @api private
class nrpe::params {
  $nrpe_provider = fact('os.family') ? {
    'Solaris' => pkgutil,
    default   => undef,
  }

  $nrpe_files_group = fact('os.family') ? {
    /(Free|Open)BSD/ => 'wheel',
    default          => 'root',
  }

  $nrpe_plugin_file_mode = '0755'

  case fact('os.family') {
    'Debian':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nagios/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nagios/nrpe.d'
      $nrpe_service     = 'nagios-nrpe-server'
      $nrpe_packages    = [
        'nagios-nrpe-server',
        'monitoring-plugins',
      ]
      $user_home_dir    = '/var/lib/nagios'
      $user_shell       = '/bin/false'
    }
    'Solaris': {
      $libdir           = '/opt/csw/libexec/nagios-plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe.pid'
      $nrpe_config      = '/etc/opt/csw/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/opt/csw/nrpe-ssl'
      $nrpe_include_dir = '/etc/opt/csw/nrpe.d'
      $nrpe_service     = 'cswnrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios_plugins',
      ]
      $user_home_dir    = '/var/lib/nagios'
      $user_shell       = '/bin/false'
    }
    'RedHat':  {
      $libdir           = fact('os.architecture') ? {
        /x86_64/ => '/usr/lib64/nagios/plugins',
        default  => '/usr/lib/nagios/plugins',
      }
      $nrpe_user        = 'nrpe'
      $nrpe_group       = 'nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'nagios-plugins-all',
      ]
      $user_home_dir    = '/var/run/nrpe'
      $user_shell       = '/sbin/nologin'
    }
    'FreeBSD': {
      if versioncmp($facts['kernelversion'], '13.1') <= 0 {
        $nrpe_packages  = ['nrpe3', 'nagios-plugins']
        $nrpe_service   = 'nrpe3'
      }
      elsif versioncmp($facts['kernelversion'], '12.3') <= 0 {
        $nrpe_packages  = ['nrpe3', 'nagios-plugins']
        $nrpe_service   = 'nrpe3'
      }
      else {
        $nrpe_packages  = ['nrpe', 'nagios-plugins']
        $nrpe_service   = 'nrpe'
      }
      $libdir           = '/usr/local/libexec/nagios'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe3/nrpe3.pid'
      $nrpe_config      = '/usr/local/etc/nrpe.cfg'
      $nrpe_ssl_dir     = '/usr/local/etc/nrpe-ssl'
      $nrpe_include_dir = '/usr/local/etc/nrpe.d'
      $user_home_dir    = '/var/spool/nagios'
      $user_shell       = '/sbin/nologin'
    }
    'OpenBSD': {
      $libdir           = '/usr/local/libexec/nagios'
      $nrpe_user        = '_nrpe'
      $nrpe_group       = '_nrpe'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_config      = '/etc/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nrpe-ssl'
      $nrpe_include_dir = '/etc/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'nrpe',
        'monitoring-plugins',
      ]
      $user_home_dir    = '/var/lib/nagios'
      $user_shell       = '/bin/false'
    }
    'Suse':  {
      $libdir           = '/usr/lib/nagios/plugins'
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe/nrpe.pid'
      $nrpe_service     = 'nrpe'
      case fact('os.name') {
        'SLES': {
          $nrpe_config      = '/etc/nagios/nrpe.cfg'
          $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
          $nrpe_include_dir = '/etc/nagios/nrpe.d'
          $nrpe_packages    = [
            'nagios-nrpe',
            'nagios-plugins',
            'nagios-plugins-nrpe',
          ]
        }
        default:   {
          $nrpe_config      = '/etc/nrpe.cfg'
          $nrpe_ssl_dir     = '/etc/nrpe-ssl'
          $nrpe_include_dir = '/etc/nrpe.d'
          $nrpe_packages    = [
            'nrpe',
            'nagios-plugins-all',
          ]
        }
      }
      $user_home_dir    = '/var/lib/nagios'
      $user_shell       = '/bin/false'
    }
    'Gentoo':  {
      $libdir           = fact('os.architecture') ? {
        /amd64|x86_64/ => '/usr/lib64/nagios/plugins',
        default        => '/usr/lib/nagios/plugins',
      }
      $nrpe_user        = 'nagios'
      $nrpe_group       = 'nagios'
      $nrpe_pid_file    = '/var/run/nrpe.pid'
      $nrpe_config      = '/etc/nagios/nrpe.cfg'
      $nrpe_ssl_dir     = '/etc/nagios/nrpe-ssl'
      $nrpe_include_dir = '/etc/nagios/nrpe.d'
      $nrpe_service     = 'nrpe'
      $nrpe_packages    = [
        'net-analyzer/nrpe',
        'net-analyzer/nagios-plugins',
      ]
      $user_home_dir    = '/dev/null'
      $user_shell       = '/sbin/nologin'
    }
    default:   {
    }
  }

  $dont_blame_nrpe                 = false
  $allow_bash_command_substitution = undef # not in very old NRPE
  $log_facility                    = 'daemon'
  $server_port                     = 5666
  $command_prefix                  = undef
  $debug                           = false
  $connection_timeout              = 300
  $allow_weak_random_seed          = true
  $listen_queue_size               = 16

  $ssl_version                 = 'TLSv1.2+'
  $ssl_ciphers                 = [
    'DHE-RSA-AES128-GCM-SHA256',
    'DHE-RSA-AES256-GCM-SHA384',
    'DHE-RSA-AES128-SHA',
    'DHE-RSA-AES256-SHA',
    'DHE-RSA-AES128-SHA256',
    'DHE-RSA-AES256-SHA256',
  ]
  $ssl_client_certs            = 'ask'
}
