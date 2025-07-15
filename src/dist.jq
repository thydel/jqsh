#!/usr/bin/env -S jq -rf

# Distribute object with only one key to next objects of a list of objects
# <<< '[{"a":1},{"b":2,"c":3},{"z":0},{"b":3,"c":4}]' dist.jq --args a z -c
# [{"a":1,"b":2,"c":3},{"z":0,"a":1,"b":3,"c":4}]

def dist($k):
  def k: if length == 1 and has($k) then . else null end;
  def nok: if length == 1 and has($k) then empty end;
  reduce .[] as $i ([[], null]; [first + if $i | length > 1 then [last + $i] else [$i] end, ($i | k) // last]) | first | map(nok);

[$ARGS.positional, .] | until(first == []; .[0][0] as $k | [.[0][1:], (.[1] | dist($k))]) | last
