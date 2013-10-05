<?php


/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function multilang_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
}


/**
 * Implements hook_install_tasks().
 *
 * Add additional tasks to the install profile install process.
 */
function multilang_install_tasks($install_state) {

  $tasks['add_french_language'] = array(
    'display_name' => st('Installing French language'),
    'display' => TRUE,
    'type' => 'batch',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'multilang_add_french_language',
  );
  
  
  return $tasks;
}


/**
 * Implement hook_install_tasks_alter().
 *
 * Perform actions to set up the site for this profile.
 */
function multilang_install_tasks_alter(&$tasks, $install_state) {
  // Remove core steps for translation imports.
  unset($tasks['install_import_locales']);
  unset($tasks['install_import_locales_remaining']);
}


function multilang_add_french_language(&$install_state) {
  
  // Enable installation language as default site language.
  include_once DRUPAL_ROOT . '/includes/locale.inc';
  include_once DRUPAL_ROOT . '/includes/iso.inc';
  
  // Code borrowed from http://drupal.stackexchange.com/questions/912/testing-installation-profile-with-custom-tasks
  $batch = array();
  $predefined = _locale_get_predefined_list();
  foreach (array('fr') as $install_locale) {
    if (!isset($predefined[$install_locale])) {
      // Drupal does not know about this language, so we prefill its values with
      // our best guess. The user will be able to edit afterwards.
      locale_add_language($install_locale, $install_locale, $install_locale, LANGUAGE_LTR, '', '', TRUE, FALSE);
    }
    else {
      // A known predefined language, details will be filled in properly.
      locale_add_language($install_locale, NULL, NULL, NULL, '', '', TRUE, FALSE);
    }
  
    // Collect files to import for this language.
    $batch = array_merge($batch, locale_batch_by_language($install_locale, NULL));
  
  }
  if (!empty($batch)) {
      // Remember components we cover in this batch set.
      variable_set('multilang_install_import_locales', $batch['#components']);      
      variable_set('language_default', (object) array('language' => 'en', 'name' => 'English', 'native' => 'English', 'direction' => 0, 'enabled' => 1, 'plurals' => 0, 'formula' => '', 'domain' => '', 'prefix' => 'en', 'weight' => 0, 'javascript' => ''));
      variable_set('language_count', 2);
      
      variable_set('language_negotiation_language', array(
        'locale-url' => array(
          'callbacks' => array(
            'language' => 'locale_language_from_url',
            'switcher' => 'locale_language_switcher_url',
            'url_rewrite' => 'locale_language_url_rewrite_url',
          ),
          'file' => 'includes/locale.inc',
        ),
        'language-default' => array(
          'callbacks' => array(
            'language' => 'language_from_default',
          ),
        ),
      ));
      
      variable_set('language_negotiation_language_content', array(
        'locale-interface' => array(
          'callbacks' => array(
            'language' => 'locale_language_from_interface',
          ),
          'file' => 'includes/locale.inc',
        ),
      ));

      variable_set('language_negotiation_language_url', array(
        'locale-url' => array(
          'callbacks' => array(
            'language' => 'locale_language_from_url',
            'switcher' => 'locale_language_switcher_url',
            'url_rewrite' => 'locale_language_url_rewrite_url',
          ),
          'file' => 'includes/locale.inc',
        ),
        'locale-url-fallback' => array(
          'callbacks' => array(
            'language' => 'locale_language_url_fallback',
          ),
          'file' => 'includes/locale.inc',
        ),
      ));
      
      variable_set('language_types', array(
        'language' => TRUE,
        'language_content' => FALSE,
        'language_url' => FALSE,
      ));

      variable_set('locale_language_providers_weight_language', array(
        'locale-url' => '-8',
        'locale-session' => '-6',
        'locale-user' => '-4',
        'locale-browser' => '-2',
        'language-default' => '10',
      ));
      
      db_query('UPDATE {languages} SET prefix=:prefix WHERE language=:lang', array(':lang' => 'en', ':prefix' => 'en'));
      
      return $batch;
  }
  
}

