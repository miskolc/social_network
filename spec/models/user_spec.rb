require 'spec_helper'

describe User do
    before do 
        @user = User.new( name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation:"foobar")
    end 

    subject { @user }

    it {should respond_to(:name)}
    it {should respond_to(:email)}
    it {should respond_to(:password)}
    it {should respond_to(:password_confirmation)}


    it {should be_valid}


    describe "when name is not present" do
        before { @user.name=" " }
        it {should_not be_valid}
    end 

    describe "when email is not present" do
        before {@user.email= " "}
        it {should_not be_valid}
    end 

    describe "when name is too long" do
        before {@user.name="a"*51}
        it {should_not be_valid}
    end

    describe "when email address is allready taken" do
        before do 
            user_with_same_email=@user.dup
            user_with_same_email.email=@user.email.upcase
            user_with_same_email.save
        end 

        it {should_not be_valid}
    end 

    describe "when password is not present" do
        before {@user.password = @user.password_confirmation = " "}
        it { should_not be_valid}

    end 

    describe "when password doesn't match cofirmation" do
        before {@user.password_confirmation = "mismatch"}
        it { should_not be_valid}
    end 


    describe "when password is too short" do
        before {@user.password= @user.password_confirmation="a" * 5}
        it {should_not be_valid}
    end 

end
