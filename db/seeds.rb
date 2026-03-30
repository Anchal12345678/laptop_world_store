# Create Admin User
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end
puts "Admin user ready"

# Create Categories
categories = [
  { name: "Gaming Laptops", description: "High performance laptops for gaming" },
  { name: "Business Laptops", description: "Professional laptops for work" },
  { name: "Student Laptops", description: "Affordable laptops for students" },
  { name: "Ultrabooks", description: "Thin and light premium laptops" }
]

categories.each do |cat|
  Category.find_or_create_by!(name: cat[:name]) do |c|
    c.description = cat[:description]
  end
end
puts "Created #{Category.count} categories"

# Create Provinces
provinces = [
  { name: "Alberta", gst: 5, pst: 0, hst: 0 },
  { name: "British Columbia", gst: 5, pst: 7, hst: 0 },
  { name: "Manitoba", gst: 5, pst: 7, hst: 0 },
  { name: "New Brunswick", gst: 0, pst: 0, hst: 15 },
  { name: "Newfoundland and Labrador", gst: 0, pst: 0, hst: 15 },
  { name: "Nova Scotia", gst: 0, pst: 0, hst: 15 },
  { name: "Ontario", gst: 0, pst: 0, hst: 13 },
  { name: "Prince Edward Island", gst: 0, pst: 0, hst: 15 },
  { name: "Quebec", gst: 5, pst: 9.975, hst: 0 },
  { name: "Saskatchewan", gst: 5, pst: 6, hst: 0 },
  { name: "Northwest Territories", gst: 5, pst: 0, hst: 0 },
  { name: "Nunavut", gst: 5, pst: 0, hst: 0 },
  { name: "Yukon", gst: 5, pst: 0, hst: 0 }
]

provinces.each do |p|
  Province.find_or_create_by!(name: p[:name]) do |prov|
    prov.gst = p[:gst]
    prov.pst = p[:pst]
    prov.hst = p[:hst]
  end
end
puts "Created #{Province.count} provinces"

# Real laptop names per category
gaming_laptops = [
  "ASUS ROG Strix G15", "MSI Gaming GS66 Stealth", "Razer Blade 15",
  "Alienware m15 R7", "Lenovo Legion 5 Pro", "Acer Predator Helios 300",
  "HP Omen 16", "Dell G15 Gaming", "MSI Katana GF66", "ASUS TUF Gaming A15",
  "Gigabyte AORUS 15", "Razer Blade 14", "Alienware x17", "MSI GE76 Raider",
  "ASUS ROG Zephyrus G14", "Lenovo Legion 7i", "Acer Nitro 5",
  "HP Victus 16", "Dell Alienware m17", "ASUS ROG Flow X13",
  "MSI Pulse GL76", "Razer Blade 17", "ASUS TUF Dash F15",
  "Lenovo IdeaPad Gaming 3", "Acer Predator Triton 500"
]

business_laptops = [
  "Lenovo ThinkPad X1 Carbon", "Dell Latitude 9520", "HP EliteBook 840",
  "Microsoft Surface Pro 9", "Apple MacBook Pro 14", "Dell XPS 15",
  "HP ZBook Fury 15", "Lenovo ThinkPad T14", "Dell Precision 5560",
  "HP EliteBook 1040", "Lenovo ThinkPad P15", "Dell Latitude 7420",
  "HP ProBook 450", "Lenovo ThinkPad E15", "Dell Vostro 5510",
  "HP EliteBook 830", "Lenovo ThinkPad L14", "Dell Latitude 5520",
  "HP ZBook Studio G8", "Lenovo ThinkPad X13", "Dell XPS 13 9310",
  "HP EliteBook x360", "Lenovo ThinkPad T15", "Dell Precision 3560",
  "HP ProBook 640"
]

student_laptops = [
  "Acer Aspire 5", "Lenovo IdeaPad 3", "HP Pavilion 15", "Dell Inspiron 15",
  "ASUS VivoBook 15", "Acer Chromebook Spin 513", "HP Stream 14",
  "Lenovo Chromebook Duet", "Dell Chromebook 3100", "ASUS Chromebook C423",
  "Acer Aspire 3", "HP 15s", "Lenovo IdeaPad 1", "Dell Inspiron 14",
  "ASUS VivoBook 14", "Acer Aspire 7", "HP Notebook 15", "Lenovo IdeaPad 5",
  "Dell Inspiron 13", "ASUS VivoBook S15", "Acer Swift 1",
  "HP 14s", "Lenovo IdeaPad Slim 3", "Dell Inspiron 16",
  "ASUS VivoBook 16"
]

ultrabooks = [
  "Apple MacBook Air M2", "Dell XPS 13", "HP Spectre x360",
  "Lenovo Yoga 9i", "Microsoft Surface Laptop 5", "Samsung Galaxy Book Pro",
  "Asus ZenBook 14", "LG Gram 14", "Acer Swift 5", "HP Envy 13",
  "Dell XPS 13 Plus", "Lenovo Yoga Slim 7", "Microsoft Surface Laptop Go",
  "Samsung Galaxy Book 2", "ASUS ZenBook S13", "LG Gram 16",
  "Acer Swift 3", "HP Spectre x360 14", "Lenovo Yoga 7i",
  "Dell Inspiron 14 Plus", "Apple MacBook Air M1", "HP Envy x360",
  "ASUS ZenBook 13", "LG Gram 17", "Acer Swift 7"
]

all_products = [
  { names: gaming_laptops, category: "Gaming Laptops",
    min_price: 999, max_price: 3499 },
  { names: business_laptops, category: "Business Laptops",
    min_price: 799, max_price: 2999 },
  { names: student_laptops, category: "Student Laptops",
    min_price: 299, max_price: 999 },
  { names: ultrabooks, category: "Ultrabooks",
    min_price: 699, max_price: 2499 }
]

all_products.each do |group|
  category = Category.find_by(name: group[:category])
  group[:names].each do |laptop_name|
    price = rand(group[:min_price]..group[:max_price]).to_f
    on_sale = [true, false].sample
    sale_price = on_sale ? (price * 0.85).round(2) : nil

    Product.find_or_create_by!(name: laptop_name) do |p|
      p.description = "The #{laptop_name} features the latest processor technology, " \
                      "stunning display, and premium build quality. " \
                      "Perfect for #{group[:category].downcase} users who need " \
                      "reliability and performance. Includes #{rand(8..32)}GB RAM, " \
                      "#{[256, 512, 1024].sample}GB SSD storage, and up to " \
                      "#{rand(6..15)} hours battery life."
      p.current_price = price.round(2)
      p.sale_price = sale_price
      p.on_sale = on_sale
      p.stock_quantity = rand(5..50)
      p.category = category
    end
  end
end

puts "Total products: #{Product.count}"
puts "Total provinces: #{Province.count}"
puts "Seeding complete!"