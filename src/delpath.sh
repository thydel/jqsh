: ${1:?}; PATH=$(jq -nr '(env.PATH / ":") as $p | $p - $ARGS.positional | join(":")' --args "$@")
