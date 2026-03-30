require 'open-uri'

laptop_image_urls = [
  'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=500',
  'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
  'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500',
  'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=500',
  'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500',
  'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=500',
  'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=500',
  'https://images.unsplash.com/photo-1484788984921-03950022c9ef?w=500',
  'https://images.unsplash.com/photo-1593642634315-48f5414c3ad9?w=500',
  'https://images.unsplash.com/photo-1516397281156-ca07cf9746fc?w=500'
]

products_without_images = Product.all.select { |p| !p.image.attached? }
puts "Found #{products_without_images.count} products without images"

products_without_images.each_with_index do |product, index|
  begin
    url = laptop_image_urls[index % laptop_image_urls.length]
    downloaded = URI.open(url)
    product.image.attach(
      io: downloaded,
      filename: "#{product.name.parameterize}.jpg",
      content_type: 'image/jpeg'
    )
    puts "Added image to: #{product.name}"
  rescue => e
    puts "Failed for #{product.name}: #{e.message}"
  end
end
puts "Done! All images added."
