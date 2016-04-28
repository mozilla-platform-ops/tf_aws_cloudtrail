variable "bucket_name" {
    description = "Name of S3 bucket in which to store Cloudtrail logs"
}

variable "bucket_path" {
    description = "Optional path within the bucket (excluding trailing '/*')"
    default = "CloudtrailLogs"
}

resource "template_file" "logging_bucket_policy" {
    template = "${file("cloudtrail_bucket.json.tmpl")}"
    vars {
        bucket_name = "${var.bucket_name}"
        bucket_path = "${var.bucket_path}"
    }
}

resource "aws_s3_bucket" "logging_bucket" {
    bucket = "${var.bucket_name}"
    acl = "private"
    policy = "${template_file.logging_bucket_policy.rendered}"
    tags {
        Name = "cloudtrail bucket"
    }
}

resource "aws_cloudtrail" "cloudtrail" {
    name = "cloudtrail"
    s3_bucket_name = "${aws_s3_bucket.logging_bucket.id}"
    include_global_service_events = true
    is_multi_region_trail = true
    tags {
        Name = "local cloudtrail"
    }
}

output "bucket_id" {
    value = "${aws_s3_bucket.logging_bucket.id}"
}

output "bucket_arn" {
    value = "${aws_s3_bucket.logging_bucket.arn}"
}

output "cloudtrail_id" {
    value = "${aws_cloudtrail.cloudtrail.id}"
}

output "cloudtrail_arn" {
    value = "${aws_cloudtrail.cloudtrail.arn}"
}
