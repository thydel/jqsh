#!/usr/bin/env -S jq -rf

# use m4 to embed macros in json
# <<< '[{"m4":{"foo":"local n=42"}},{"bar":"foo; echo $n"},{"«foo»":"foo; bar($n)"}]' yq -oj | ./jsm4.jq | m4 -P | jq -c
# [{"bar":"local n=42; echo $n"},{"foo":"local n=42; bar($n)"}]

def m4:
  def head: "m4_changequote(«,»)m4_dnl";
  def m4:
    def jstr: gsub("\\\\"; "\\\\") | gsub("\n"; "\\n") | gsub("\""; "\\\"");
    "m4_define(«\(.key)»,«\(.value | tostring | jstr)»)m4_dnl";
  head, (.[][] | to_entries[] | m4);

if map(has("m4")) | any then group_by(has("m4")) | (last | m4), first end
