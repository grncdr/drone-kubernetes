# Generates a shell script that will call `kubectl apply -f $file` for each file
# in vargs.resource_files

[.vargs.args[]|"'\(.)'"] as $args |
.vargs.resource_files[] |
"kubectl \($args|join(" ")) apply -f '\(.)'"
