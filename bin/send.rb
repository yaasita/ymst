#!/usr/bin/env ruby
require 'yaml'
require 'mail'

Dir.chdir(File.dirname(File.expand_path(__FILE__)) + "/..")

mail_file = ARGV.first
envelope_to = ENV["ORIGINAL_RECIPIENT"]

File.open("mail.yml") do |f|
  @yaml = YAML.load(f)
end

def send_mail_data(filename)
  mail = Mail.read(filename)
  # edit mail data
  return mail.to_s
end

@yaml[envelope_to].each do |member|
  IO.popen("/usr/sbin/sendmail -f #{ENV['SENDER']} #{member}","w") do |io|
    io.puts send_mail_data(mail_file)
  end
end
