locals {
    ami_id = data.aws_ami.joindevops.id
    sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    vip_id = data.aws_ssm_parameter.vip_id.value
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    tg_port = "${var.component}" == "frontend" ? 80 : 8080
    health_check_path = "${var.component}" == "frontend" ? "/" : "/health"
    frontend_alb_listener_arn = data.frontend_alb_listener_arn.value
    backend_alb_listener_arn = data.backend_alb_listener_arn.value

    listener_arn = "${var.component}" == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn
    host_context ="${var.component}" == "frontend" ? "${var.project_name}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"

    common_name = "${var.project_name}-${var.environment}"
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }
}