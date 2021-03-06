require 'spec_helper_rspec'

[:shield, :xpack].each do |provider|
  describe Puppet::Type.type(:elasticsearch_role_mapping).provider(provider) do
    describe 'instances' do
      it 'should have an instance method' do
        expect(described_class).to respond_to :instances
      end

      context 'with no roles' do
        it 'should return no resources' do
          expect(described_class.parse("\n")).to eq([])
        end
      end

      context 'with one role' do
        it 'should return one resource' do
          expect(described_class.parse(%q{
            admin:
              - "cn=users,dc=example,dc=com"
          })[0]).to eq({
            :ensure => :present,
            :name => 'admin',
            :mappings => [
              "cn=users,dc=example,dc=com"
            ]
          })
        end
      end

      context 'with multiple roles' do
        it 'should return three resources' do
          expect(described_class.parse(%q{
            admin:
              - "cn=users,dc=example,dc=com"
            user:
              - "cn=users,dc=example,dc=com"
              - "cn=admins,dc=example,dc=com"
              - "cn=John Doe,cn=other users,dc=example,dc=com"
            power_user:
              - "cn=admins,dc=example,dc=com"
          }).length).to eq(3)
        end
      end
    end # of describe instances

    describe 'prefetch' do
      it 'should have a prefetch method' do
        expect(described_class).to respond_to :prefetch
      end
    end
  end # of describe puppet type
end
