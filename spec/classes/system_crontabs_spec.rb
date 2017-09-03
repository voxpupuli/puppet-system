require 'spec_helper'

# system::crontabs:
#  'logrotate':
#    command: '/usr/sbin/logrotate'
#    user:    'root'
#    hour:    '2'
#    minute:  '0'

describe 'system::crontabs', type: 'class' do
  describe 'config parameter' do
    let(:params) do
      {
        config: {
          'logrotate' => {
            'ensure'  => 'present',
            'command' => '/usr/sbin/logrotate',
            'user'    => 'root',
            'hour'    => '4',
            'minute'  => '17'
          }
        }
      }
    end

    it {
      is_expected.to create_cron('logrotate').with('ensure' => 'present',
                                                   'command' => '/usr/sbin/logrotate',
                                                   'user'    => 'root',
                                                   'hour'    => '4',
                                                   'minute'  => '17')
    }
  end
end
