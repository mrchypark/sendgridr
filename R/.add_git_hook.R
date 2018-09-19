usethis::use_git_hook("pre-commit", readLines("pre_commit"))
usethis::use_git_hook("post-commit",readLines("post_commit"))
