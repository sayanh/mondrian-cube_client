require 'spec_helper'
RSPEC_TEST_URL='http://localhost:8080'

RSpec.describe Mondrian::CubeClient do

  let(:cubedefinition) {
    File.read(RSPEC_APP_PATH.join('fixtures','cube_definition.xml'))
  }
  let(:connection) {
    Mondrian::CubeClient.connection( RSPEC_TEST_URL + "/mondrian/cubecrudapi")
  }
  
    it "sets the host and port for a connection" do
      expect(connection.base_url).to eq( RSPEC_TEST_URL + "/mondrian/cubecrudapi")
    end

  describe 'show cube for given catalog name' do
    it "gets a cube's definition" do
      expect(connection.get('mycat', 'mycube')).not_to be_empty
    end
  end

  describe 'show cube for given cube name' do
    it "gets a cube's definition" do
      expect(connection.get('', 'mycube')).not_to be_empty
    end
  end

  describe 'list all cubes' do
    it "gets all cubes with definitions" do
      expect(connection.get('', '')).not_to be_empty
    end
  end

  describe 'update cube' do
    it "updates a cube's definition" do
      puts "testing ::#{connection.update('mycat', 'mycube', cubedefinition).inspect}"
      expect(connection.update('mycat', 'mycube', cubedefinition)).not_to be_empty
    end
  end

  describe 'create cube' do
    it "creates a cube" do
      expect(connection.create('mycat','mycube',cubedefinition)).not_to be_empty
    end
  end

  describe 'delete cube' do
    it "deletes a cube" do
      expect(connection.delete('mycat','mycube')).not_to be_empty
    end
  end
end
