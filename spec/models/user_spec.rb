require 'rails_helper'

describe User do
  let(:user) { User.new(name: "Big Tap", email: "big@taptech.net.com",
                        password: "foobar", password_confirmation: "foobar") }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe 'validations' do
    describe 'name' do
      context 'not present' do
        before { user.name = nil }
        it { should_not be_valid }
      end

      context 'too short' do
        before { user.name = 'a' * 2 }
        it { should_not be_valid }
      end

      context 'too long' do
        before { user.name = 'a' * 255 }
        it { should_not be_valid }
      end
    end

    describe 'email' do
      context 'not present' do
        it 'is invalid' do
          user.email = ""
          expect(user).to_not be_valid
        end
      end

      context 'too long' do
        it 'is invalid' do
          user.email = "a" * 255
          expect(user).not_to be_valid
        end
      end

      context 'valid format' do
        it 'is valid' do
          valid_addresses = %w{ user@foo.COM A_US-ER@f.b.org
                                first.last@foo.jp a+b@baz.cn a@b.co }
          valid_addresses.each do |address|
            user.email = address
            expect(user).to be_valid
          end
        end
      end

      context 'invalid format' do
        it 'is invalid' do
          invalid_addresses = %w{ user@foo,com user_at_foo.org example.user@foo.
                                  foo@bar_baz.com foo@bar+baz.com foo@bar..com }
          invalid_addresses.each do |address|
            user.email = address
            expect(user).to_not be_valid
          end
        end
      end

      context 'not unique' do
        before do
          # With a user defined near the top
          # Create a duplicate of that
          # Save the duplicate, note: original user has not be saved
          user_with_same_email = user.dup
          user_with_same_email.save

          # Original user is not valid
          it { should_not be_valid }
        end
      end

      context 'mixed case' do
        it 'is saved as lowercase' do
          mixed_case_email = 'Big@gmAIL.cOm'
          user.email = mixed_case_email
          user.save
          
          expect(user.reload.email).to eq(mixed_case_email.downcase)
        end
      end
    end
  end
end