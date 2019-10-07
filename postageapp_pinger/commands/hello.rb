module PostageappPinger
  module Commands
    class Hello < SlackRubyBot::Commands::Base
      command "hello" do |client, data, _match|
        client.say(
          channel: data.channel,
          text: "Hello world yourself, you big galoot."
        )
      end
    end
  end
end
