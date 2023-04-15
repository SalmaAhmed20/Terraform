resource "aws_elasticache_subnet_group" "elasticsubnetgroup" {
  name       = "my-cache-subnet"
  subnet_ids = [module.networks.PrivsubnetID1,module.networks.PrivsubnetID2]
}
resource "aws_elasticache_cluster" "terraformECache" {
  cluster_id           = "elasticcacheterraform"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name = aws_elasticache_subnet_group.elasticsubnetgroup.name
  security_group_ids = [ module.networks.Redissg ]
}
