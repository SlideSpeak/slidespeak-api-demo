require 'net/http'
require 'json'
require 'uri'
require 'csv'
require 'tty-prompt'
require 'tty-table'
require 'tty-spinner'

class SlideSpeakClient
  BASE_URL = 'https://api.slidespeak.co/api/v1'.freeze
  CSV_FILE = 'presentations.csv'.freeze

  def initialize(api_key)
    @api_key = api_key
    load_csv
  end

  def load_csv
    unless File.exist?(CSV_FILE)
      CSV.open(CSV_FILE, 'w') { |csv| csv << %w[task_id plain_text status url] }
    end
  end

  def generate_presentation(plain_text, theme = nil, length = 10)
    uri = URI("#{BASE_URL}/presentation/generate")
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


  def poll_and_update(task_id, plain_text)
    spinner = TTY::Spinner.new("[:spinner] Generating presentation... ", format: :dots)
    spinner.auto_spin

    loop do
      sleep 2
      status = get_task_status(task_id)
      current_status = status['task_status']
      url = status.dig('task_result', 'url') || ''
      update_csv(task_id, plain_text, current_status, url)

      if current_status == 'SUCCESS'
        spinner.success("✅ Presentation complete!")
        puts "🎉 You can download it here: #{url}"
        break
      elsif current_status == 'FAILURE'
        spinner.error("❌ Task failed. Please try again.")
        break
      end
    end
  end


  def update_csv(task_id, plain_text, status, url)
    table = CSV.table(CSV_FILE)
    existing_row = table.find { |row| row[:task_id] == task_id }
    if existing_row
      existing_row[:status] = status
      existing_row[:url] = url unless url.empty?
    else
      table << [task_id, plain_text, status, url]
    end
    File.open(CSV_FILE, 'w') { |f| f.write(table.to_csv) }
  end

  def display_csv
    rows = []
    CSV.foreach(CSV_FILE, headers: true) do |row|
      rows << [row['task_id'], row['plain_text'], row['status'], row['url']]
    end
    table = TTY::Table.new(header: ['Task ID', 'Description', 'Status', 'URL'], rows: rows)
    puts table.render(:unicode)
  end

  private

  def headers
    { "Content-Type" => "application/json", "X-API-key" => @api_key }
  end

  def execute_request(uri, request)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end
end

# Main CLI Loop
if ENV['SLIDE_SPEAK_API_KEY'].nil?
  puts 'Error: SLIDE_SPEAK_API_KEY environment variable not set.'
  exit(1)
end

api_key = ENV['SLIDE_SPEAK_API_KEY']
client = SlideSpeakClient.new(api_key)
prompt = TTY::Prompt.new
cursor = TTY::Cursor

loop do
  choice = prompt.select("\nWhat would you like to do?", cycle: true) do |menu|
    menu.choice '📄 View existing presentations', 1
    menu.choice '✨ Generate a new presentation', 2
    menu.choice '🚪 Exit', 3
  end

  case choice
  when 1
    print cursor.clear_screen
    print cursor.move_to(0, 0)
    puts "\n📊 Existing Presentations:"
    client.display_csv
  when 2
    print cursor.clear_screen
    print cursor.move_to(0, 0)
    plain_text = prompt.ask("📝 Enter a topic for the presentation (leave blank for 'French Revolution'):", default: "Key moments in the french revolution.").strip
    puts "\n✨ Generating presentation about '#{plain_text}'..."
    
    response = client.generate_presentation(plain_text)
    if response['task_id']
      task_id = response['task_id']
      client.update_csv(task_id, plain_text, 'PENDING', '')
      client.poll_and_update(task_id, plain_text)
      puts "✅ Presentation ready! Check the table for details."
    else
      puts '❌ Error generating presentation.'
    end
  when 3
    puts "\n👋 Goodbye!"
    break
  end
end

print cursor.clear_screen
print cursor.move_to(0, 0)