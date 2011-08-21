class Kmeans
  include Geometric

  def initialize(points, cluster_count)
    # TODO: Set defaults
    @points = points
    @cluster_count cluster_count
  end

  def cluster(points, n)
    initial_seeds = points.sample(n) # Ruby 1.9 required
    initial_seeds.map {|n| Node(n)}

    loop do
      clusters = []
  
    end

  end

end

class Node

end

class Cluster

  attr_accessor :nodes :centroid

  def update(nodes)
    @nodes = nodes
    @centroid = calculate_centroid()
  end

  def calculate_centroid()
    
  end

end
