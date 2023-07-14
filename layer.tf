# add library

resource "aws_lambda_layer_version" "my_layer" {
  filename   = "${path.module}/python & zipfile/my_layer.zip"
  layer_name = "my-layer"
  compatible_runtimes = ["python3.10"]
}