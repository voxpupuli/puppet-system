require 'spec_helper'

#system::facts:
#  location:
#    value: 'London'

describe 'system::facts', :type => 'class' do
  describe 'config parameter' do
    let(:params) {
      {
        :config => {
          'location' => {
            'value'  => 'London',
          }
        }
      }
    }
    it {
      should create_system__fact('location').with( {
        'value'  => 'London',
      } )
    }
  end
end
