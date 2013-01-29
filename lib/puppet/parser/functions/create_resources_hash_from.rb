# From: https://github.com/ashak/puppet-resource-looping
#
# create_resources_hash_from.rb
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# erwbgy: small change to allow the array index number to be included

module Puppet::Parser::Functions
  newfunction(:create_resources_hash_from, :type => :rvalue, :doc => <<-EOS
Given:
    A formatted string (to use as the resource name)
    An array to loop through (because puppet cannot loop)
    A hash defining the parameters for a resource
    And optionally an hash of parameter names to add to the resource and an
      associated formatted string that should be configured with the current
      element of the loop array

This function will return a hash of hashes that can be used with the
create_resources function.

The formatted string used as the resource name can also optionally contain
'%index%' which will be replaced with the array index - ie. 0 for the first
entry, 1 for the second entry etc.

*Example 1:*
    $allowed_hosts = ['10.0.0.0/8', '192.168.0.0/24']
    $resource_name = "100 allow %s to apache on ports 80"
    $my_resource_hash = {
      'proto'  => 'tcp',
      'action' => 'accept',
      'dport'  => 80
    }
    $dynamic_parameters = {
      'source' => '%s'
    }

    $created_resource_hash1 = create_resources_hash_from($resource_name, $allowed_hosts, $my_resource_hash, $dynamic_parameters)

$created_resource_hash1 would equal:
    {
      '100 allow 10.0.0.0/8 to apache on ports 80' => {
        'proto' => 'tcp',
        'action' => 'accept',
        'dport' => 80,
        'source' => '10.0.0.0/8'
      },
      '100 allow 192.168.0.0/24 to apache on ports 80' => {
        'proto' => 'tcp',
        'action' => 'accept',
        'dport' => 80,
        'source' => '192.168.0.0/24'
      }
    }

*Example 2:*
    $software = ['jboss', 'httpd']
    $resource_name = "software%index%"
    $my_resource_hash = {}
    $dynamic_parameters = {
      'value' => '%s'
    }

    $created_resource_hash2 = create_resources_hash_from($resource_name, $software, $my_resource_hash, $dynamic_parameters)

$created_resource_hash2 would equal:
    {
      'software0' => {
        'value' => 'jboss',
      },
      'software1' => {
        'value' => 'httpd',
      }
    }

$created_resource_hash could then be used with create_resources

    create_resources(firewall, $created_resource_hash1)
    create_resources('system::facts', $created_resource_hash2)

To create a bunch of resources in a way that would only otherwise be possible
with a loop of some description.
    EOS
  ) do |arguments|

    raise Puppet::ParseError, "create_resources_hash_from(): Wrong number of arguments " +
      "given (#{arguments.size} for 3 or 4)" if arguments.size < 3 or arguments.size > 4

    formatted_string = arguments[0]

    unless formatted_string.is_a?(String)
      raise(Puppet::ParseError, 'create_resources_hash_from(): first argument must be a string')
    end

    loop_array = arguments[1]

    unless loop_array.is_a?(Array)
      raise(Puppet::ParseError, 'create_resources_hash_from(): second argument must be an array')
    end

    resource_hash = arguments[2]
    unless resource_hash.is_a?(Hash)
      raise(Puppet::ParseError, 'create_resources_hash_from(): third argument must be a hash')
    end

    if arguments.size == 4
      dynamic_parameters = arguments[3]
      unless dynamic_parameters.is_a?(Hash)
        raise(Puppet::ParseError, 'create_resources_hash_from(): fourth argument must be a hash')
      end
    end

    result = {}

    loop_array.each_with_index do |i, index|
      my_resource_hash = resource_hash.clone
      if dynamic_parameters
        dynamic_parameters.each do |param, value|
          if my_resource_hash.member?(param)
            raise(Puppet::ParseError, "create_resources_hash_from(): dynamic_parameter '#{param}' already exists in resource hash")
          end
          my_resource_hash[param] = value..gsub('%index%', "#{index}")
          my_resource_hash[param] = sprintf(value,[i])
        end
      end
      key = formatted_string.gsub('%index%', "#{index}")
      result[sprintf(key,[i])] = my_resource_hash
    end

    result
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
