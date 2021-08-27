# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v6.0.0](https://github.com/voxpupuli/puppet-nrpe/tree/v6.0.0) (2023-03-10)

[Full Changelog](https://github.com/voxpupuli/puppet-nrpe/compare/v5.0.0...v6.0.0)

**Breaking changes:**

- Drop EOL Debian 8, Ubuntu 16.04 [\#55](https://github.com/voxpupuli/puppet-nrpe/pull/55) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- NRPEv3 Support for FreeBSD - Add param listen\_queue\_size [\#64](https://github.com/voxpupuli/puppet-nrpe/pull/64) ([Toutzn](https://github.com/Toutzn))
- Add support for Debian 10, 11 and Ubuntu 18.04, 20.04 [\#56](https://github.com/voxpupuli/puppet-nrpe/pull/56) ([smortex](https://github.com/smortex))

**Closed issues:**

- nrpe Package on 20.04 is Persistently Reinstalling as a Corrective Action [\#65](https://github.com/voxpupuli/puppet-nrpe/issues/65)

**Merged pull requests:**

- docs: fix typo [\#62](https://github.com/voxpupuli/puppet-nrpe/pull/62) ([MindTooth](https://github.com/MindTooth))
- dont hardcode facter versions in tests [\#61](https://github.com/voxpupuli/puppet-nrpe/pull/61) ([bastelfreak](https://github.com/bastelfreak))
- Allow stdlib 8.0.0 [\#53](https://github.com/voxpupuli/puppet-nrpe/pull/53) ([smortex](https://github.com/smortex))

## [v5.0.0](https://github.com/voxpupuli/puppet-nrpe/tree/v5.0.0) (2021-05-06)

[Full Changelog](https://github.com/voxpupuli/puppet-nrpe/compare/v4.0.0...v5.0.0)

**Breaking changes:**

- Add Puppet 7 support; Drop Puppet 5 support; concat/stdlib: Allow 7.x [\#48](https://github.com/voxpupuli/puppet-nrpe/pull/48) ([bastelfreak](https://github.com/bastelfreak))
- Drop EOL EL 5 & 6 [\#44](https://github.com/voxpupuli/puppet-nrpe/pull/44) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Support IP addresses with subnets in allowed\_hosts [\#47](https://github.com/voxpupuli/puppet-nrpe/pull/47) ([mleiner](https://github.com/mleiner))
- Add pid directory management [\#38](https://github.com/voxpupuli/puppet-nrpe/pull/38) ([coreone](https://github.com/coreone))

**Fixed bugs:**

- Add amd64 as recognised Gentoo arch [\#40](https://github.com/voxpupuli/puppet-nrpe/pull/40) ([optiz0r](https://github.com/optiz0r))

**Closed issues:**

- Error when package\_name is customized [\#41](https://github.com/voxpupuli/puppet-nrpe/issues/41)

## [v4.0.0](https://github.com/voxpupuli/puppet-nrpe/tree/v4.0.0) (2020-05-10)

[Full Changelog](https://github.com/voxpupuli/puppet-nrpe/compare/v3.0.0...v4.0.0)

**Breaking changes:**

- drop Ubuntu 14.04 support [\#26](https://github.com/voxpupuli/puppet-nrpe/pull/26) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 2.7.0 and drop puppet 4 [\#23](https://github.com/voxpupuli/puppet-nrpe/pull/23) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add `commands` and `plugins` parameters [\#17](https://github.com/voxpupuli/puppet-nrpe/pull/17) ([alexjfisher](https://github.com/alexjfisher))

**Fixed bugs:**

- Allow puppetlabs/concat 6.x, puppetlabs/stdlib 6.x; require at least concat 4.1.0 instead of 3.0.0 [\#24](https://github.com/voxpupuli/puppet-nrpe/pull/24) ([dhoppe](https://github.com/dhoppe))

**Closed issues:**

- Adding interface for Hiera and nrpe resources [\#16](https://github.com/voxpupuli/puppet-nrpe/issues/16)

**Merged pull requests:**

- Use voxpupuli-acceptance [\#33](https://github.com/voxpupuli/puppet-nrpe/pull/33) ([ekohl](https://github.com/ekohl))
- Enable changing allow\_weak\_random\_seed config param [\#29](https://github.com/voxpupuli/puppet-nrpe/pull/29) ([jorhett](https://github.com/jorhett))
- drop RHEL5, add Debian8/ubuntu16 support [\#19](https://github.com/voxpupuli/puppet-nrpe/pull/19) ([bastelfreak](https://github.com/bastelfreak))
- Add more acceptance tests [\#15](https://github.com/voxpupuli/puppet-nrpe/pull/15) ([alexjfisher](https://github.com/alexjfisher))
- Add basic acceptance tests [\#14](https://github.com/voxpupuli/puppet-nrpe/pull/14) ([alexjfisher](https://github.com/alexjfisher))

## [v3.0.0](https://github.com/voxpupuli/puppet-nrpe/tree/v3.0.0) (2018-11-07)

[Full Changelog](https://github.com/voxpupuli/puppet-nrpe/compare/v2.1.1...v3.0.0)

This is the first [VoxPupuli](https://voxpupuli.org) release of [`puppet/nrpe`](https://forge.puppet.com/pupppet/nrpe).  `puppet/nrpe` is a fork of [`pdxcat/nrpe`](https://forge.puppet.com/pdxcat/nrpe).

Users migrating from `pdxcat/nrpe` should carefully review any breaking changes that may affect them.


**Breaking changes:**

- Use modern facts and stdlib `fact()` function [\#10](https://github.com/voxpupuli/puppet-nrpe/pull/10) ([alexjfisher](https://github.com/alexjfisher))
- Add reference docs and remove redundant `recurse` parameter [\#9](https://github.com/voxpupuli/puppet-nrpe/pull/9) ([alexjfisher](https://github.com/alexjfisher))
- Convert to EPP templates and add Puppet 4+ data types to parameters [\#6](https://github.com/voxpupuli/puppet-nrpe/pull/6) ([alexjfisher](https://github.com/alexjfisher))

**Implemented enhancements:**

- Add `supplementary_groups` parameter [\#7](https://github.com/voxpupuli/puppet-nrpe/pull/7) ([alexjfisher](https://github.com/alexjfisher))
- Parameterize `nrpe::command` file mode [\#5](https://github.com/voxpupuli/puppet-nrpe/pull/5) ([alexjfisher](https://github.com/alexjfisher))

**Merged pull requests:**

- Major refactor into install/config/service pattern [\#8](https://github.com/voxpupuli/puppet-nrpe/pull/8) ([alexjfisher](https://github.com/alexjfisher))
- Fixup metadata.json, add travis secret for VP fork [\#4](https://github.com/voxpupuli/puppet-nrpe/pull/4) ([alexjfisher](https://github.com/alexjfisher))
- Use full apache 2 license text [\#3](https://github.com/voxpupuli/puppet-nrpe/pull/3) ([alexjfisher](https://github.com/alexjfisher))
- Update README [\#2](https://github.com/voxpupuli/puppet-nrpe/pull/2) ([alexjfisher](https://github.com/alexjfisher))

## v2.1.1 (2016-06-09)

* Fix file perms

## v2.1.0 (2016-06-07)

* Take the parameters given to the module into account, rather than the defaults from the params.pp when creating commands.
* Fix `nrpe::include_dir` bug
* make management of nrpe package optional
* Use variable for title of service resource to be consistent
* Allow other users than root to be sudoed

## v2.0.0 (2015-06-16)

* Add Gentoo support.
* Re-add inherit params.
* Allow hiera-based override of nrpe user/group/pid.
* Fix variable naming.
* 1ca413e Add all other NRPE config parameters: `allow_bash_command_substitution`, `log_facility`, `server_port`, `command_prefix`, debug, `connection_timeout`; also add `dont_blame_nrpe` to `nrpe::params`.
* Add support for SLES
* Added support to set file mode of plugin file
* Added support for the 'content' attribute for a plugin
* Added sudo support
* Add support for OpenBSD.
* Make `command_timeout` configurable.
* Allow to specify fully qualified commands.
* Specify `server_address` in nrpe class.
* change package name from nrpe2 to nrpe for freebsd
* add 32bit architecture for RedHat OS family
* removed `dont_blame_nrpe` from params
* Fixed typo, missing bracket after list in params.pp near line 78
* corrected syntax
* added `dont_blame_nrpe`
* corrected FreeBSD package names
* added SUSE default params
* cfg template w/ @libdir fact

## (v1.0.0) (2014-02-26)

### Summary:

This release adds FreeBSD osfamily support and support
for adding nrpe plugins.

### Features:

* Add FreeBSD support
* Add plugin command

### Bugfixes:

* OpenCSW changed the paths of configs files

## v0.0.4 (2013-10-20)

### Summary:

This is a bug fix release

### Bug fixes:

* Fix puppet 3.x bug with array namevars
* Puppet lint fixes

## v0.0.3 (2013/09/25)

* Add Rakefile, Gemfile and update .gitignore
* Merge pull request #1 from ripienaar/puppet\_3\_2\_1\_deprecations
* Puppet 3.2.1 has deprecated 'foo' as a means of accessing variables in templates instead now requiring '@foo' and will log warnings about this.

## v0.0.2 (2013/02/02)

* Bump version to 0.0.2 for forge release
* Remove nrpe plugin.
* Fix spelling of the word command in README
* Ignore pkg directory
* Add ability to purge nrpe::commands
* Add smoke tests
* Add dependencies to the README
* Fix typo with `nagios_plugin` package for solaris
* Add nagios-plugin package param
* Add `nrpe::command` functionality
* Add redhat params to nrpe
* Change `allowed_hosts` from a string to an array
* Initial commit for nrpe module


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
