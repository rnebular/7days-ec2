# 7days-ec2
7 Days to Die - dedicated server on linux

# instance setup
instance_type: `t3.medium` for setup, possibly `t3.large` for performance
security_groups: `7days2die,GenericHostAdmin,GameServer`
storage: 60Gb gp3
key_pair: WorkBasic
iam_role: s3full-r53full
