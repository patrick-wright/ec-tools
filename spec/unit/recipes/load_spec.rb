#
# Cookbook Name:: ec-tools
# Spec:: load
#
# Copyright (c) 2015 Irving Popovetsky, All Rights Reserved.

require 'spec_helper'

describe 'ec-tools::load' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        server.create_data_bag('user', {
          'pinkiepie' => {
            'id' => 'pinkiepie',
            'first_name' => 'pinkiepie',
            'middle_name' => 'pinkiepie',
            'last_name' => 'pinkiepie',
            'email' => 'pinkiepie@chef.io',
            'password' => 'pinkiepie'
          },
          'soarin' => {
            'id' => 'soarin',
            'first_name' => 'pinkiepie',
            'middle_name' => 'pinkiepie',
            'last_name' => 'pinkiepie',
            'email' => 'pinkiepie@chef.io',
            'password' => 'pinkiepie'
          }
        })

        server.create_data_bag('org', {
          'ponyville' => {
            'id' => 'ponyville',
            'description' => 'The Ville of Ponies',
            'groups' => ['foobars'],
            'users' => ['pinkiepie']
          },
          'wonderbolts' => {
            'id' => 'wonderbolts',
            'description' => 'The Bolts of Wonder',
            'groups' => ['foobars'],
            'users' => ['soarin']
          }
        })

      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

  end
end
