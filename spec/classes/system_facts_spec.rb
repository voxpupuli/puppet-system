require 'spec_helper'

# system::facts:
#  location:
#    value: 'London'

describe 'system::facts', type: 'class' do
  describe 'config parameter' do
    let(:params) do
      {
        config: {
          'location' => {
            'value'  => 'London'
          }
        }
      }
    end

    it {
      is_expected.to create_system__fact('location').with('value' => 'London')
    }
  end
end
