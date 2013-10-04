; call this file like this:
; drush make --working-copy stub.make multilang
; Built using http://drupal.org/project/buildkit

api = 2
core = 7.x

projects[drupal][type] = core
projects[drupal][version] = "7.23"

projects[multilang][type] = profile
projects[multilang][download][type] = git
projects[multilang][download][url] = git@github.com:robinpuga/multilang.git
; Use this to directly check out the develop branch
;projects[multilang][download][branch] = master

