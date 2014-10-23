require "spec_helper"

describe Devise::Mailer do
  let(:user) { mock_model(User, email: "foo@bar.com") }
  describe "#confirmation_instructions" do
    let(:mail) { Devise::Mailer.confirmation_instructions(user, "abc123") }

    it { expect(mail.from).to eq ["contact@theyvoteforyou.org.au"] }
    it { expect(mail.to).to eq ["foo@bar.com"] }
    it { expect(mail.subject).to eq "Confirmation instructions" }
    it { expect(mail).to_not be_multipart }
    it do
      expect(mail.body.to_s).to eq <<-EOF
<p>Welcome foo@bar.com!</p>

<p>You can confirm your account email through the link below:</p>

<p><a href="http://pw.org.au/users/confirmation?confirmation_token=abc123">Confirm my account</a></p>
      EOF
    end
  end

  describe "#reset_password_instructions" do
    let(:mail) { Devise::Mailer.reset_password_instructions(user, "abc123") }

    it { expect(mail.from).to eq ["contact@theyvoteforyou.org.au"] }
    it { expect(mail.to).to eq ["foo@bar.com"] }
    it { expect(mail.subject).to eq "Reset password instructions" }
    it { expect(mail).to_not be_multipart }
    it do
      expect(mail.body.to_s).to eq <<-EOF
<p>Hello foo@bar.com!</p>

<p>Someone has requested a link to change your password. You can do this through the link below.</p>

<p><a href="http://pw.org.au/users/password/edit?reset_password_token=abc123">Change my password</a></p>

<p>If you didn't request this, please ignore this email.</p>
<p>Your password won't change until you access the link above and create a new one.</p>
      EOF
    end
  end
end