# @summary Installs NRPE commands
#
# @example Install a command called `check_users`
#   nrpe::command { 'check_users':
#     ensure  => present,
#     command => 'check_users -w 5 -c 10',
#   }
#
# @param name
#   The name of the command.
# @param command
#   The command plugin to run and its arguments.
# @param ensure
#   Whether to install or remove the command.
# @param file_mode
#   The mode to use for the command file.  By default, this parameter is `undef`, and the command file will use `$nrpe::command_file_default_mode`.
# @param sudo
#   Whether the command should use sudo.
# @param sudo_user
#   The user to run the command as when using sudo.
define nrpe::command (
  String[1]                  $command,
  Enum['present', 'absent']  $ensure       = present,
  Optional[Stdlib::Filemode] $file_mode    = undef,
  Boolean                    $sudo         = false,
  String[1]                  $sudo_user    = 'root',
  String[1]                  $sudo_command = $nrpe::params::sudo_command,
) {
  include nrpe

  file { "${nrpe::include_dir}/${title}.cfg":
    ensure  => $ensure,
    content => epp(
      'nrpe/command.cfg.epp',
      {
        'command_name' => $name,
        'command'      => $command,
        'sudo'         => $sudo,
        'sudo_user'    => $sudo_user,
        'libdir'       => $nrpe::params::libdir,
      },
    ),
    owner   => 'root',
    group   => $nrpe::params::nrpe_files_group,
    mode    => pick($file_mode, $nrpe::command_file_default_mode),
  }
}
