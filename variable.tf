variable "queue_name" {
  type    = string
  default = "sqs_queue"

}

variable "delay_seconds" {
  type    = number
  default = 0

}