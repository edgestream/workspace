userpart='`export XIT=$? \
&& [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER} " || echo -n "\[\033[0;32m\]\u " \
&& [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'

gitbranch='`\
if [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
	export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
	if [ "${BRANCH}" != "" ]; then \
		echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
		&& if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
				echo -n " \[\033[1;33m\]✗"; \
		fi \
		&& echo -n "\[\033[0;36m\]) "; \
	fi; \
fi`'

export PS1="${userpart} \[\033[1;34m\]\w ${gitbranch}\[\033[0m\]\$ "
