# Use `jqsh`

```bash
make install
source jqsh.sh
```

# Exemple lib

## Git repo, file and commit to markdown link

```bash
load lib/git-to-md.yml
<<< lib/git-to-md.yml gf2md
gc2md 2
```

## Show use of `m4`

```bash
load lib/stdjq.yml
{ < /etc/passwd jc --passwd | jq 'map(.username)'; < /etc/group jc --group | jq 'map(.group_name)'; } | inter -sc
```
