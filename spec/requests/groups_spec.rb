require 'rails_helper'

module Committee
  class RequestUnpacker
    def unpack_query_params(request)
      pp request.GET
      pp request.POST
      @allow_query_params ? self.class.indifferent_params(request.GET) : {}
    end
  end
end

RSpec.describe "/groups", type: :request do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def committee_options
    @committee_options ||= { schema: Committee::Drivers::load_from_file('swagger/swagger.yml') }
  end

  def request_object
    last_request
  end

  def response_data
    [last_response.status, last_response.headers, last_response.body]
  end

  describe "GET /groups" do
    it "returns ok" do
      Group.create!
      get groups_url, { limit: 1 }, as: :json
      assert_schema_conform 200
    end
  end

  describe "PATCH /groups/:id" do
    it "returns ok" do
      group = Group.create!
      patch group_url(group), { name: "something" }, as: :json
      assert_schema_conform 200
    end
  end
end
