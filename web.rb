require 'sinatra/base'

module PostageappPinger
  class Web < Sinatra::Base
    get "/" do
      "Yup, you found me."
    end
  end
end
