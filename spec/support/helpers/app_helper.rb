module AppHelper
  extend RSpec::SharedContext

  let(:response_hash) { JSON.parse(last_response.body, symbolize_names: true) }
  let(:json_headers) do
    {
      'CONTENT_TYPE' => 'application/json'
    }
  end

  def prettify_json(json)
    JSON.pretty_generate(json)
  end
end
