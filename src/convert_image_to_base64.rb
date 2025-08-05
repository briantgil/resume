require 'base64'


def convert_image(image)

  begin
    file_extension = File.basename(image).split(".")
    file_extension = file_extension.length > 1 ? file_extension = file_extension[1] : "NO_EXT"

    # Open the image file in binary read mode ('rb')
    # Read the entire content of the file
    image_data = File.open(image, "rb").read

    # Encode the binary data to Base64
    # It is generally recommended to use strict_encode64 as it does not add newlines
    base64_encoded_image = Base64.strict_encode64(image_data)

    case file_extension
      when "jpg", "jpeg"   
        html_tag = "<img alt=\"Converted Image\" width=\"200\" height=\"200\" src=\"data:image/jpg;base64, #{base64_encoded_image}\" />"
      when "png"   
        html_tag = "<img alt=\"Converted Image\" width=\"200\" height=\"200\" src=\"data:image/png;base64, #{base64_encoded_image}\" />"
      when "svg"   
        html_tag = "<img alt=\"Converted Image\" width=\"200\" height=\"200\" src=\"data:image/svg;base64, #{base64_encoded_image}\" />"
      when "pdf"   
        html_tag = "<img alt=\"Converted Image\" width=\"200\" height=\"200\" src=\"data:image/pdf;base64, #{base64_encoded_image}\" />"
      else
        html_tag = "no data"
    end
      
    File.open("#{image}.txt", "w") do |file|
      file.write(html_tag)
    end

    return html_tag

  rescue Errno::ENOENT
    puts "Error: Image file not found at #{image}"
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end
end


if __FILE__ == $0
  # Define the path to your image file
  image_path = ".\\assets\\images\\IMG_1880.jpg"
  puts("#{convert_image(image_path)[0..100]}...")
end

