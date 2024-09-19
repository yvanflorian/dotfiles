
# Some of my Custom Git Settings:

Running `git config --global --edit` will show global configs.
I have below added for diff:

```sh
[icdiff]
	options = --highlight --line-numbers
[init]
	defaultBranch = main
[diff]
	tool = icdiff
[diff "icdiff"]
  cmd = icdiff --line-numbers \"$LOCAL\" \"$REMOTE\"
```

You may visit [github](https://github.com/jeffkaufman/icdiff) to view details about the diff tool.
