module Geometric
  include Math
  # TODO: Add documentation

  def rad(n)
    n * PI / 180
  end

  def pythagorean_distance(a, b)
    lon_a, lat_a = a[0], a[1]
    lon_b, lat_b = b[0], b[1]

    sqrt((lon_a - lon_b)**2 + (lat_a - lat_b)**2)
  end

  def euclidean_distance(a, b, radius=6371.0)
    lon_d = rad((b[0] - a[0]))
    lat_d = rad((b[1] - a[1]) * cos(rad(a[1])))

    diag_d = sqrt(lat_d**2 + lon_d**2)
    diag_d * radius
  end

  def haversine_distance(a, b, radius=6371.0)
    lon_d = rad((b[0] - a[0]))
    lat_d = rad((b[1] - a[1]))

    t1 = sin(lat_d / 2)**2 + cos(rad(a[1])) * cos(rad(b[1])) * sin(lon_d/2)**2
    t2 = 2 * asin(sqrt(t1))

    radius * t2
  end
