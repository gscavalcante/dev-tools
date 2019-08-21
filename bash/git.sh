# Git stuffs
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\e[33;1m\u@\h: \e[31m\W\e[0m\$(git_branch)\$ "
