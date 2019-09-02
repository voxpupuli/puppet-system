class system::limits (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  include limits
  class { 'limits':
    config    => $config,
    use_hiera => false,
    #schedule => $sys_schedule,
  }
}
