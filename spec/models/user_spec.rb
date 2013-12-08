require 'spec_helper'

describe User do
  it "creates a valid user" do
    FactoryGirl.create(:user).should be_valid
  end
  
  def self.it_fails_on_blank(*attr_list)
    attr_list.each do |attr|
      it "fails on blank #{attr}" do
        FactoryGirl.build(:user, attr => "").should_not be_valid 
      end
    end
  end
  
  def self.it_responds_to(*attr_list)
    attr_list.each do |attr|
      it "responds to #{attr}" do
        User.new.respond_to? :attr
      end
    end
  end
  
  it_responds_to  :email, 
                  :first_name, 
                  :last_name, 
                  :password, 
                  :password_confirmation, 
                  :encrypted_password
  
  
  describe "email tests" do
    it_fails_on_blank   :email, 
                        :first_name, 
                        :last_name

    it "raises error on invalid email" do
      expect { FactoryGirl.create(:user, :email => "bademail-example-com") }.to raise_error ActiveRecord::RecordInvalid
    end

    it "fails on duplicate email" do
      user = FactoryGirl.create(:user)
      FactoryGirl.build(:user, :email => user.email).should_not be_valid 
    end

    it "accepts valid email addresses" do
      %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |email|
        FactoryGirl.create(:user, :email => email).should be_valid 
      end
    end

    it "fails on invalid email addresses" do
      %w[user@foo,com user_at_foo.org example.user@foo.].each do |email|
        FactoryGirl.build(:user, :email => email).should_not be_valid       
      end
    end

    it "rejects emails identical except for case" do
      user = FactoryGirl.create(:user)
      FactoryGirl.build(:user, :email => user.email.upcase).should_not be_valid 
    end
  end
    
  describe "passwords" do
    it_fails_on_blank   :password, 
                        :password_confirmation
    
    it "fails on unmatched passwords" do
      FactoryGirl.build(:user, :password => 'dsfgklhfgjh', :password_confirmation => 'hgjwdhfbsadjkhfg').should_not be_valid
    end
    
    it "fails on short passwords" do
      %w[a ab abc abcd abcde abcdef abcdefg].each do |password|
        FactoryGirl.build(:user, :password => password, :password_confirmation => password).should_not be_valid 
      end
    end

    it "should set the encrypted password attribute" do
      FactoryGirl.create(:user).encrypted_password.should_not be_blank
    end
  end
end
