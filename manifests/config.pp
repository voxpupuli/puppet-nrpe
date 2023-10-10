# @summary Configures NRPE
#
# @api private
class nrpe::config {
  if $nrpe::manage_group {
    group { $nrpe::nrpe_group:
      ensure => 'present',
      system => true,
    }
    $group_req = Group[$nrpe::nrpe_group]
  } else {
    $group_req = undef
  }

  if $nrpe::manage_user {
    user { $nrpe::nrpe_user:
      ensure  => 'present',
      before  => Service[$nrpe::service_name],
      comment => $nrpe::user_comment,
      gid     => $nrpe::nrpe_group,
      groups  => $nrpe::supplementary_groups,
      home    => $nrpe::user_home_dir,
      require => $group_req,
      shell   => $nrpe::user_shell,
      system  => true,
    }
  } else {
    unless $nrpe::supplementary_groups.empty {
      user { $nrpe::nrpe_user:
        gid    => $nrpe::nrpe_group,
        groups => $nrpe::supplementary_groups,
      }
    }
  }

  concat { $nrpe::config:
    ensure => present,
  }

  $_allow_bash_command_substitution = $nrpe::allow_bash_command_substitution ? {
    undef   => undef,
    default => bool2str($nrpe::allow_bash_command_substitution, '1', '0'),
  }

  concat::fragment { 'nrpe main config':
    target  => $nrpe::config,
    content => epp(
      'nrpe/nrpe.cfg.epp',
      {
        'log_facility'                    => $nrpe::log_facility,
        'nrpe_pid_file'                   => $nrpe::nrpe_pid_file,
        'server_port'                     => $nrpe::server_port,
        'server_address'                  => $nrpe::server_address,
        'nrpe_user'                       => $nrpe::nrpe_user,
        'nrpe_group'                      => $nrpe::nrpe_group,
        'allowed_hosts'                   => $nrpe::allowed_hosts,
        'dont_blame_nrpe'                 => bool2str($nrpe::dont_blame_nrpe, '1', '0'),
        'allow_bash_command_substitution' => $_allow_bash_command_substitution,
        'libdir'                          => $nrpe::params::libdir,
        'command_prefix'                  => $nrpe::command_prefix,
        'debug'                           => bool2str($nrpe::debug, '1', '0'),
        'command_timeout'                 => $nrpe::command_timeout,
        'connection_timeout'              => $nrpe::connection_timeout,
        'allow_weak_random_seed'          => bool2str($nrpe::allow_weak_random_seed, '1', '0'),
        'listen_queue_size'               => $nrpe::listen_queue_size,
      }
    ),
    order   => '01',
  }

  if $nrpe::ssl_cert_file_content {
    contain nrpe::config::ssl
  }

  concat::fragment { 'nrpe includedir':
    target  => $nrpe::config,
    content => "include_dir=${nrpe::include_dir}\n",
    order   => '99',
  }

  file { 'nrpe_include_dir':
    ensure  => directory,
    name    => $nrpe::include_dir,
    purge   => $nrpe::purge,
    recurse => $nrpe::purge,
  }
}
