class system {
  # Ensure packages, users and groups are created
  # before other resources that may depend on them
  stage { 'first': before => Stage['main'] }
  class {
    'system::packages': stage => first;
    'system::groups':   stage => first;
    'system::users':    stage => first;
  }

  include system::yumrepos
  include system::packages
  include system::groups
  include system::users
}
