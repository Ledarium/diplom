alias gl="git --no-pager log --pretty=format:'%s'"
echo "### Плюсы\n"
gl $1...$2 --grep='+ ' --reverse
echo "\n\n### Минусы\n"
gl $1...$2 --grep='- ' --reverse
echo "\n\n### Подводные камни\n"
gl $1...$2 --grep='+ ' --grep='- ' --invert-grep --reverse
echo "\n"

