module Kmeans
  # TODO: Error and validity checks for objects

  include Geometric

  def cluster(points, n)
    initial_seeds = points.sample(n) # Ruby 1.9 required
    clusters = initial_seed.clone

    loop do
      lists = [] * n

      points.each do |point|
        smallest_distance = haversine_distance(point, clusters[0].centroid)
        index = 0
        clusters.each do |cluster|
          distance = haversine_distance(point, cluster.centroid)
          if distance < smallest_distance
            smallest_distance = distance
            index = something # loop's index + 1
          end
          lists[index] << point

        biggest_shift = 0.0
        clusters.each do |cluster|
          shift = clusters # how much did the centroid move?
        if biggest_shift < cutoff
          break
        end

      return clusters
  
    end

  end

  class Node

    attr_accessor :coordinates

  end

  class Cluster

    attr_accessor :nodes :centroid

    def update(nodes)
      @nodes = nodes
      old_centroid = @centroid
      @centroid = calculate_centroid()
      haversine_distance(old_centroid, new_centroid)
    end

    def calculate_centroid()
      total_lat, total_lon = 0, 0

      @nodes.each do |node|
        total_lat += node.latitude
        total_lon += node.longitude
      end

      n = @nodes.length
      Node(total_lat/n, total_lon/n)

    end

  end

end
