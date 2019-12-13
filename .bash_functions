# extract all the things!
extract () {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
}

composer(){
    if which composer > /dev/null; then
        composer "$@"
    else
        if [[ ! -d "${HOME}/.composer" ]]; then
            mkdir -p "${HOME}/.composer"
        fi

        docker run --rm --interactive --tty \
            --volume $PWD:/app \
            --volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp \
            --user $(id -u):$(id -g) \
            composer "$@"
    fi
}

tldr() {
    if which tldr > /dev/null; then
        tldr "$@"
    else
        if [[ ! -d "${HOME}/.tldr" ]]; then
            mkdir -p "${HOME}/.tldr"
        fi

        docker run --rm --interactive --tty \
            --volume ${HOME}/.tldr:/root/.tldr \
            nutellinoit/tldr "$@"
    fi
}