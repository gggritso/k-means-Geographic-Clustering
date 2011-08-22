require 'rubygems'
require 'mongo'

require_relative 'lib/kmeans'
require_relative 'lib/geometric'

include Geometric

def random_coordinate(range)
  min, max = range
  rand * (max - min) + min
end

db = Mongo::Connection.new('localhost').db('clustering')
coll = db['points']

# Insert 100 randomly-generated locations into a MongoDB database
if not coll.find.count > 0

  for i in 1..100
    # Generate a point located roughly in downtown Toronto
    longitude_range = [-79.45, -79.30]
    latitude_range = [43.65, 43.70]

    lon = random_coordinate(longitude_range)
    lat = random_coordinate(latitude_range)

    doc = {'coordinates' => [lon,lat]}
    coll.insert(doc, :safe => true)
  end

  puts 'Inserted points into database.'

end

# Create the index for querying
coll.ensure_index([['coordinates', Mongo::GEO2D]])
puts 'Ensured 2D index for coordinate points.'

# Cluster one level using k-means
points = []
coll.find().each do |point|
  node = Kmeans::Node.new(point['coordinates'])
  points << node
end

clusters = Kmeans::cluster(points, 10)
p clusters
puts "#{clusters.length} clusters created successfully."
