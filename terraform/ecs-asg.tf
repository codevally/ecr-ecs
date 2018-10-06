
data "template_file" "ecs_userdata"
{
  template = "${file("userdata/ecs-asg.template")}"

  vars
  {
    ECS_CLUSTER    = "${aws_ecs_cluster.webapp_cluster.name}"
   }
}
resource "aws_launch_configuration" "webapp_on_demand" {
    instance_type = "${var.instance_type}"
    image_id = "${lookup(var.ecs_image_id, var.aws_region)}"
    iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"
    user_data = "${data.template_file.ecs_userdata.rendered}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.webapp_instances.id}"]
    associate_public_ip_address = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "webapp_on_demand" {
    name = "${var.name_prefix}_webapp_on_demand"
    max_size = 50
    min_size = 0
    desired_capacity = "${var.desired_capacity_on_demand}" 
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true
    launch_configuration = "${aws_launch_configuration.webapp_on_demand.name}"
    vpc_zone_identifier = [ "${aws_subnet.subnet.*.id}" ]

    tag {
        key = "Name"
        value = "${var.name_prefix}-webapp-on-demand"
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}

data "template_file" "autoscaling_user_data" {
    template = "${file("autoscaling_user_data.tpl")}"
    vars {
        ecs_cluster = "${aws_ecs_cluster.webapp_cluster.name}"
    }
}