# jqsh: A Compiler for Declarative Shell Libraries

Are you tired of wrestling with unreadable and brittle shell
one-liners? Do you find yourself rewriting the same `curl | jq |
xargs` logic across multiple scripts?

**`jqsh`** reimagines how we build command-line tools by treating shell
scripting as a compilation process rather than an ad-hoc task. At its
heart, `jqsh` **is a compiler that transforms simple, declarative YAML
files into powerful, modular shell libraries.**  Instead of writing
imperative scripts, you define a collection of namespaced functions
that can be composed, shared, and reused across all your projects.

## The Philosophy

The `jqsh` approach is guided by a few core principles designed to
bring structure, readability, and robustness to your shell
environment.

### Define, Don't Script

Describe the steps of your pipeline in a clean, human-readable YAML
format. `jqsh` handles the complexities of generating the underlying
shell code, freeing you to focus on your logic rather than wrestling
with quoting, pipes, and process substitution.

### Build Libraries, Not Scripts

Think in terms of reusable functions, not disposable scripts. `jqsh`
encourages you to build libraries of namespaced functions (e.g.,
`git:blame`, `aws:list-instances`) that create a powerful and
consistent toolkit for your command line.

### Compile to Standard Bash

`jqsh` doesn't introduce a new runtime dependency. It compiles your
high-level definitions into clean, efficient, and portable Bash
scripts. The final artifact is a standard `.sh` file that can be used
anywhere, by anyone, without needing `jqsh` to run it.

### Go Beyond Local: Your Toolkit, Everywhere

A key principle of `jqsh` is that your function libraries are not
confined to your local machine. Because functions and their
dependencies can be serialized on-the-fly into a self-contained
script, you can execute your local toolkit on any remote server over
SSH **with zero prior installation**.

This allows you to treat every remote shell as a seamless extension of
your development environment, instantly equipped with the exact
functions you need. It enables powerful, consistent, and reproducible
remote automation without the overhead of configuration management or
manual script distribution.
