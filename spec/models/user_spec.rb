require 'rails_helper'
 
RSpec.describe User, type: :model do
  let(:user){User.new(name:'Example User',email:'user@example.com',
                                   password: 'foobar',
                       password_confirmation: 'foobar')}

  it 'user is valid' do
    expect(user).to be_valid
  end

  it 'must enter name' do
    user.name=' '
    expect(user).to_not be_valid
  end

   it 'must enter email' do
    user.email=' '
    expect(user).to_not be_valid
  end 

  it 'within 50 words(name)' do
    user.name='a'*51
    expect(user).to_not be_valid
  end

  it 'within 50 words(email)' do
    user.name="#{'a'*244}@example.com"
    expect(user).to_not be_valid
  end

   it 'email is valid form' do
     valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
     valid_addresses.each do |valid_address|
       user.email = valid_address
       expect(user).to be_valid
     end
  end
  
  it 'can not register same email(1)' do
    duplicable_user = user.dup
    user.save
    expect(duplicable_user).to_not be_valid
  end

  it 'can not register same email(2)' do
    duplicable_user = user.dup
    duplicable_user.email=user.email.downcase
    user.save
    expect(duplicable_user).to_not be_valid
  end

  it 'email is registered samll words' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it 'must enter password' do
    user.password = user.password_confirmation= ' ' * 6
     expect(user).to_not be_valid
  end

  it 'password has more than 6 words' do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).to_not be_valid   
  end 
end