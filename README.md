Terraform Cloudtrail logging module
========================

A Terraform module to create an S3 bucket for, and enable, Cloudtrail logging.

Input Variables
---------------
- `bucket_name` - Name of the S3 bucket
- `bucket_path` - Path within the bucket to store logs (excluding trailing '/')


Usage
-----

```js
module "cloudtrail" {
  source = "github.com/klibby/tf_cloudtrail"

  bucket_name = "my-s3-bucket"
  bucket_path = "CloudtrailLogs"

}
```

Outputs
-------
- `bucket_id` - S3 bucket name
- `bucket_arn` - S3 bucket ARN
- `cloudtrail_id` - Cloudtrail id
- `cloudtrail_arn` - Cloudtrail ARN


Authors
=======

Created by [Kendall Libby](https://github.com/klibby)

License
=======
Mozilla Public License, version 2.0. See LICENSE for full details.
