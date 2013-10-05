api = 2
core = 7.x

; Build Kit drupal-org.make 
includes[] = http://drupalcode.org/project/buildkit.git/blob_plain/5796abbad762d3a54b88728b7a8ba26106af4989:/drupal-org.make

; Build Kit Overrides

projects[tao][subdir] = contrib
projects[rubik][subdir] = contrib


projects[context][version] = 3.0-beta6
projects[ctools][version] = 1.3
projects[devel][version] = 1.3
projects[diff][version] = 3.2
projects[features][version] = 1.0
projects[strongarm][version] = 2.0
projects[views][version] = 3.7

;
; Development
;
projects[coder][subdir] = development
projects[coder][version] = 1.0-beta6


;
; Contrib Modules
;

projects[admin_menu][version] = 3.0-rc3
projects[admin_menu][subdir] = contrib 

projects[backup_migrate][version] = 2.4
projects[backup_migrate][subdir] = contrib

projects[date][version] = 2.6
projects[date][subdir] = contrib

projects[entity][subdir] = contrib
projects[entity][version] = 1.0

projects[entity_translation][subdir] = contrib
projects[entity_translation][version] = 1.0-beta3

projects[i18n][version] = 1.8
projects[i18n][subdir] = contrib

projects[image_caption][version] = 1.0-beta3
projects[image_caption][subdir] = contrib

projects[l10n_client][version] = 1.1
projects[l10n_client][subdir] = contrib

projects[l10n_update][version] = 1.0-beta3
projects[l10n_update][subdir] = contrib

projects[libraries][version] = 2.1
projects[libraries][subdir] = contrib

projects[link][version] = 1.0
projects[link][subdir] = contrib

projects[pathauto][version] = 1.2
projects[pathauto][subdir] = contrib

projects[potx][version] = 1.0
projects[potx][subdir] = contrib

projects[token][version] = 1.5
projects[token][subdir] = contrib

projects[translation_helpers][version] = 1.0
projects[translation_helpers][subdir] = contrib

projects[translation_table][version] = 1.0-beta1
projects[translation_table][subdir] = contrib

projects[variable][version] = 2.2
projects[variable][subdir] = contrib

;
; Libraries
;




;
; Themes
;

projects[zen][version] = 3.1
projects[zen][subdir] = contrib
