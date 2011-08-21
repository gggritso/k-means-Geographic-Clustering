$: << File.dirname(__FILE__)

require 'geometric'
include Geometric

module Kmeans
  # TODO: Error and validity checks for objects

  class Node

    attr_accessor :lat, :lon

    def initialize(coordinates)

      lon, lat = coordinates
      if not lat or not lon
        raise Exception.new('Coordinates not provided to Node')
      end

      @lon ||= lon
      @lat ||= lat

    end

  end

  class Cluster

    attr_accessor :nodes, :centroid

    def initialize(nodes)
      if not nodes
        raise Exception.new('Nodes not provided to Cluster')
      end
      @nodes ||= nodes
      @centroid = calculate_centroid()
    end

    def update(nodes)
      # TODO: Use .send() to allow passing of other distance calculations
      @nodes = nodes
      old_centroid = @centroid
      @centroid = calculate_centroid()
      haversine_distance(old_centroid, new_centroid)
    end

    def calculate_centroid()
      total_lat, total_lon = 0, 0

      @nodes.each do |node|
        total_lat += node.lat
        total_lon += node.lon
      end

      n = @nodes.length
      Node.new([total_lon/n, total_lat/n])

    end

  end


  def self.cluster(points, n)
    initial_seeds = points.sample(n) # Ruby 1.9 required
    # Create a one-point Cluster for each seed
    clusters = []
    cutoff = 1

    initial_seeds.each do |node|
      cluster = Cluster.new([node])
      clusters << cluster
    end

    index = 0
    loop do
      index += 1
      lists = []
      for i in 0..n
        lists << []
      end

      points.each do |point|
        smallest_distance = haversine_distance(point, clusters[0].centroid)
        index = 0
        clusters.each do |cluster|
          distance = haversine_distance(point, cluster.centroid)
          if distance < smallest_distance
            smallest_distance = distance
          end
          lists[index] << point
        end

      end

      biggest_shift = 0.0
      clusters.each do |cluster|
        shift = clusters # how much did the centroid move?
      end

      break if biggest_shift < cutoff

    end

    return clusters
    
  end

end
