# Private class
class gitolite::config inherits gitolite {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { "${gitolite::home_dir}/admin.pub":
    ensure  => file,
    source  => $gitolite::admin_key_source,
    content => $gitolite::admin_key_content,
  }->
  exec { "${gitolite::params::cmd_install} admin.pub":
    path        => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    user        => 'gitolite',
    cwd         => $gitolite::home_dir,
    environment => "HOME=${gitolite::home_dir}",
    creates     => "${gitolite::home_dir}/projects.list",
  }
}