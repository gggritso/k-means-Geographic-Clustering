require 'rubygems'
require 'mongo'
require 'lib/kmeans'

def random_coordinate(range)
  min, max = range
  rand * (max - min) + min
end

# Insert 100 randomly-generated locations into a MongoDB database
db = Mongo::Connection.new('localhost').db('clustering')
coll = db['points']

for i in 1..100
  # Generate a point located roughly in downtown Toronto
  longitude_range = [-79.45, -79.30]
  latitude_range = [43.65, 43.70]

  lon = random_coordinate(longitude_range)
  lat = random_coordinate(latitude_range)

  doc = {'coordinates' => [lon,lat]}
  coll.insert(doc, :safe => true)
end

puts 'Inserted point into database.'

# Create the index for querying
coll.ensure_index([['coordinates', Mongo::GEO2D]])
puts 'Ensured 2D index for coordinate points.'

# Cluster one level using k-means
points = []
coll.find().each do |point|
  points << point['coordinates']
end

clusters = Kmeans(points, 10)
p clusters
