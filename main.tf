
# Syntactic sugar for terraform
#<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
#  <IDENTIFIER> = <EXPRESSION>
#}

resource "random_string" "random" {
  length = 10
}