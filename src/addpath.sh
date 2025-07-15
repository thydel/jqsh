: ${1:?}; PATH=$(jq -nr '(env.PATH / ":") as $p | ($ARGS.positional - $p) + $p | join(":")' --args "$@")
