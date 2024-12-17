require 'net/http'
require 'json'
require 'uri'

require 'csv'
require 'terminal-table'

class SlideSpeakClient
  BASE_URL = 'https://api.slidespeak.co/api/v1'.freeze

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_presentation(plain_text, theme = nil, length = 10)
    uri = URI("#{BASE_URL}/presentation/generate")
    puts "POST #{uri}"
    request = Net::HTTP::Post.new(uri, headers)
    request.body = { plain_text: plain_text, theme: theme, length: length }.to_json

    response = execute_request(uri, request)
    JSON.parse(response.body)
  end

  def get_task_status(task_id)
    uri = URI("#{BASE_URL}/task_status/#{task_id}")
    request = Net::HTTP::Get.new(uri, headers)

    response = execute_request(uri, request)
    JSON.parse(response.body)
  end

  private

  def headers
    {
      "Content-Type" => "application/json",
      "X-API-key" => @api_key
    }
  end


  def execute_request(uri, request)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end
end

if ENV['SLIDE_SPEAK_API_KEY'].nil?
  puts 'Error: SLIDE_SPEAK_API_KEY environment variable not set.'
  exit(1)
end

api_key = ENV['SLIDE_SPEAK_API_KEY']
client = SlideSpeakClient.new(api_key)

puts 'Generating presentation about the French Revolution...'
response = client.generate_presentation('The French Revolution was a period of radical social and political upheaval in France from 1789 to 1799.')

if response['task_id']
  puts "Task ID: #{response['task_id']}"
  puts 'Polling for completion...'

  loop do
    sleep 2
    status = client.get_task_status(response['task_id'])
    puts "Status: #{status['task_status']}"
    puts "*" * 42
    puts "#{status}"
    puts "*" * 42
    next if status['task_status'] != 'SUCCESS'
    puts 'Presentation generation complete!'
    puts "You can download your presentation here: #{status['task_result']['url']}"
    puts "You can download your presentation info here: #{status['task_info']['url']}"
    break
  end

else
  puts 'Error generating presentation.'
end
