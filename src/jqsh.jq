#!/usr/bin/env -S jq -rf

def w($s): $s + . + $s;
def q: w("\u0027");
def qq: w("\"");
def at: "$@" | qq;

def check:
  def check:
    .[] | select(has("id")) | select(has("jq") | not) | select(has("sh") | not)
    | "\($__loc__) \(@text) no .jq nor .sh" | error;
  check, .;

def add_sh:
  map(if has("jq") and has("id") and (has("sh") | not) then . + { sh: "self \(at)" } end);

def aliases:
  .[] | select(has("id") and has("ns")) | "jqsh:alias \(.id) \(.ns)";

def ns:
  map(.ns) | unique[]
  | "alias \(.)=ns:\(.); ns:\(.) () { \(.):${1:?} \("${@:2}" | qq); }";

def jq:
  if has("jq") then "local jq=\(.jq | @sh); " else "" end;

def js:
  if has("js") then "local js=$(<<< \(.js | @json | @sh) yq -oj); " else "" end;

def txt:
  .[] | select(has("id")) | "\(.id) () { local id=\(.id); local ns=\(.ns); \(jq)\(js)\(.sh); }";

def head:
  "BASH_ALIASES" as $a
  | "jqsh:alias () { if [[ ! -v \($a)[$1] || -v \($a)[$1] && \($a)[$1] != $2:$1 ]]; then alias $1=$2:$1; else echo warning $(alias $1) >&2; fi; }";

def init:
  add_sh | check | group_by(.ns) | sort_by(length)[];

def main:
  head, (init | aliases, txt, ns);

main
