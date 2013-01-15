require 'spec_helper'

#system::facts:
#  location:
#    value: 'London'

describe 'system::fact', :type => 'define' do
  describe 'location fact' do
    let(:title) { 'location' }
    let(:params) {
      {
        :value => 'London',
      }
    }
    it {
      should create_system__sysconfig__entry('system-fact-location').with( {
        'file'  => 'puppet',
        'var'   => 'export FACTER_location',
        'val'   => 'London',
      } )
    }
  end
  # TODO: add execs
end
